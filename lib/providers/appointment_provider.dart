import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/env.dart';
import '../models/http_exception.dart';
import '../models/apponitments.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _activeAppointments = [];

  List<Appointment> get activeAppointments {
    return [..._activeAppointments];
  }

  List<Appointment> _historyAppointments = [];

  List<Appointment> get historyAppointments {
    return [..._historyAppointments];
  }

  Future<void> fetchActiveAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(EnviromentVariables.baseUrl + "appointments"),
      );
      print(response.body);
      final responseData = jsonDecode(response.body) as List<dynamic>;

      for (var data in responseData) {
        var appointment = data as Map<String, dynamic>;

        _activeAppointments.add(
          Appointment(
            id: appointment["id"].toString(),
            bookingStart: DateTime.parse(appointment["bookingStart"]),
            bookingEnd: DateTime.parse(appointment["bookingEnd"]),
            serviceId: appointment["serviceId"].toString(),
            barberId: appointment["providerId"].toString(),
          ),
        );
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> fetchHistoryAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(EnviromentVariables.baseUrl + "historyappointments"),
      );
      print(response.body);
      final responseData = jsonDecode(response.body) as List<dynamic>;

      for (var data in responseData) {
        var appointment = data as Map<String, dynamic>;

        _historyAppointments.add(
          Appointment(
            id: appointment["id"].toString(),
            bookingStart: DateTime.parse(appointment["bookingStart"]),
            bookingEnd: DateTime.parse(appointment["bookingEnd"]),
            serviceId: appointment["serviceId"].toString(),
            barberId: appointment["providerId"].toString(),
          ),
        );
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
