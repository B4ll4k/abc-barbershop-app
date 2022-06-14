import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/barber.dart';
import '../models/env.dart';
import '../models/http_exception.dart';

class BarberProvider with ChangeNotifier {
  final List<Barber> _barbers = [];

  List<Barber> get barbers {
    return [..._barbers];
  }

  Future<void> fetchBarbers() async {
    try {
      final response =
          await http.get(Uri.parse(EnviromentVariables.baseUrl + "barbers"));
      //print(response.body);
      final responseData = json.decode(response.body) as List<dynamic>;

      for (var data in responseData) {
        var barber = data as Map<String, dynamic>;

        _barbers.add(
          Barber(
            id: barber["id"].toString(),
            email: barber["email"],
            firstName: barber["firstName"],
            lastName: barber["lastName"],
            phoneNum: barber["phone"] ?? "",
            pictureUrl: barber["pictureFullPath"] ?? "",
          ),
        );
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
