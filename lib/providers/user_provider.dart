import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/env.dart';
import '../models/user.dart';
import '../models/http_exception.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get user {
    return _user!;
  }

  Future<void> login(String email, String password) async {
    final Map<String, dynamic> user = {'email': email, 'password': password};
    try {
      final response = await http.post(
        Uri.parse(EnviromentVariables.baseUrl + 'login'),
        body: json.encode(user),
      );
      print(response.body);
      final responseMap = json.decode(response.body) as Map<String, dynamic>;
      print(responseMap['Success']);
      if (responseMap['Success'] == null) {
        throw HttpException(responseMap['Failure']);
      } else {
        await fetchUserInfo(email);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> fetchUserInfo(String email) async {
    final requestData = {"email": email};

    final response = await http.post(
      Uri.parse(EnviromentVariables.baseUrl + "user"),
      body: json.encode(requestData),
    );
    final responseList = json.decode(response.body) as List<dynamic>;
    final responseMap = responseList[0] as Map<String, dynamic>;

    _user = User(
        id: responseMap["id"].toString(),
        email: responseMap["email"],
        firstName: responseMap["firstName"],
        lastName: responseMap["lastName"],
        phoneNum: responseMap["phone"]);
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'id': _user!.id,
      'firstName': _user!.firstName,
      'lastName': _user!.lastName,
      'phoneNum': _user!.phoneNum,
      'email': _user!.email,
    });
    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _user = User(
        id: userData['id'].toString(),
        email: userData['email'].toString(),
        firstName: userData['firstName'].toString(),
        lastName: userData['lastName'].toString(),
        phoneNum: userData['phoneNum'].toString());

    print(_user);
    return true;
  }

  Future<void> signup(String firstName, String lastName, String phoneNo,
      String email, String password) async {
    final userData = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNo': phoneNo,
      'email': email,
      'password': password,
    };
    try {
      final response = await http.post(
        Uri.parse(EnviromentVariables.baseUrl + 'signup'),
        body: json.encode(userData),
      );
      print(response.body);
      final responseBody = (json.decode(response.body) as Map<String, dynamic>);
      if (responseBody['Success'] == null) {
        String error = responseBody['Failure'];
        throw HttpException(error);
      } else {
        await fetchUserInfo(email);
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
