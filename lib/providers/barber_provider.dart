import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/barber.dart';
import '../models/env.dart';
import '../models/http_exception.dart';

class BarberProvider with ChangeNotifier {
  final List<Barber> _barbers = [];

  List<Map<String, dynamic>> _workingTime = [];

  List<int> _freeWeekdays = [];

  List<int> get freeWeekdays {
    return [..._freeWeekdays];
  }

  List<Barber> get barbers {
    return [..._barbers];
  }

  Future<void> fetchBarbers() async {
    try {
      final response =
          await http.get(Uri.parse(EnviromentVariables.baseUrl + "barbers"));
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
            daysoff: [],
          ),
        );
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> fetchFreeWeekdays() async {
    try {
      final response = await http
          .get(Uri.parse(EnviromentVariables.baseUrl + "freeweekdays/"));
      final resposeData = json.decode(response.body) as List<dynamic>;

      for (var elementData in resposeData) {
        var element = elementData as Map<String, dynamic>;
        _freeWeekdays.add(int.parse(element["weekday_off"] as String));
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> fetchDaysoff() async {
    try {
      final response =
          await http.get(Uri.parse(EnviromentVariables.baseUrl + "daysoff/"));
      final responseData = json.decode(response.body) as List<dynamic>;

      for (var data in responseData) {
        var freeData = data as Map<String, dynamic>;

        var startDate = DateTime.parse(freeData["startDate"] as String);
        var endDate = DateTime.parse(freeData["endDate"] as String);
        var barberId = freeData["userId"] as String;
        List<DateTime> dates = [];

        dates.add(startDate);

        while (startDate != endDate) {
          startDate = startDate.add(const Duration(days: 1));
          dates.add(startDate);
        }

        for (var date in dates) {
          _barbers
              .firstWhere((element) => element.id == barberId)
              .daysoff
              .add(date);
        }
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> fetchWorkingTime() async {
    try {
      final response = await http
          .get(Uri.parse(EnviromentVariables.baseUrl + "workingtime/"));

      final resposeData = json.decode(response.body) as List<dynamic>;

      for (var elementData in resposeData) {
        _workingTime.add(elementData);
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  List<Map<String, dynamic>> findWorkingTime(String barberId, String weekDay) {
    return _workingTime
        .where((element) =>
            element["userId"] == barberId && element["weekDay"] == weekDay)
        .toList();
  }
}
