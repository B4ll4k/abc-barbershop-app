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

  Map<String, dynamic> _userData = {};

  Future<void> login(String email, String password) async {
    final Map<String, dynamic> user = {'username': email, 'password': password};
    try {
      final response = await http.post(
        Uri.parse(EnviromentVariables.baseUrl + 'api/login'),
        body: json.encode(user),
      );
      final responseMap = json.decode(response.body) as Map<String, dynamic>;
      if (responseMap['success'] == null) {
        throw HttpException(responseMap['failure']);
      } else {
        await fetchUserInfo(email);
      }
    } catch (e) {
      print(e);
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
    final responseMap = responseList as Map<String, dynamic>;

    _user = User(
        id: responseMap["id"],
        email: responseMap["email"],
        firstName: responseMap["firstName"],
        lastName: responseMap["lastName"],
        phoneNum: responseMap["phone"]);
    print(_user);
    notifyListeners();
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

  Future<void> signup(Map<String, dynamic> userData) async {
    print(jsonEncode(userData));
    try {
      final response = await http.post(
        Uri.parse(EnviromentVariables.baseUrl + 'signUp'),
        body: json.encode(user),
      );
      print(response.body);
      final responseBody = (json.decode(response.body) as Map<String, dynamic>);
      if (responseBody['Success'] == null) {
        String error = responseBody['Failure'];
        throw HttpException(error);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
