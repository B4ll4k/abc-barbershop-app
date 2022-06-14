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

  void setActiveAppointment(List<Appointment> newActiveAppointment) {
    _activeAppointments = newActiveAppointment;
  }

  final List<Appointment> _historyAppointments = [];

  List<Appointment> get historyAppointments {
    return [..._historyAppointments];
  }

  void setHistoryAppointment(List<Appointment> newHistoryAppointment) {
    _activeAppointments = newHistoryAppointment;
  }

  Future<void> fetchActiveAppointments(String id) async {
    try {
      final response = await http.get(
        Uri.parse(EnviromentVariables.baseUrl + "appointments/$id"),
      );
      //print(response.body);
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
      notifyListeners();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> fetchHistoryAppointments(String id) async {
    try {
      final response = await http.get(
        Uri.parse(EnviromentVariables.baseUrl + "historyappointments/$id"),
      );
      //print(response.body);
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
        notifyListeners();
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<void> bookAppointment(
      {required String userId,
      required String barberId,
      required String serviceId,
      required double servicePrice,
      required String bookingStart,
      required String bookingEnd}) async {
    try {
      Map<String, dynamic> bodyMap = {
        'customerId': userId,
        'providerId': barberId,
        'serviceId': serviceId,
        'servicePrice': servicePrice,
        'bookingStart': bookingStart,
        'bookingEnd': bookingEnd
      };
      final response = await http.post(
        Uri.parse(EnviromentVariables.baseUrl + 'bookappointments'),
        body: jsonEncode(bodyMap),
      );
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (responseData['Success'] == null) {
        throw HttpException(responseData['Failure']);
      }
      _activeAppointments.add(
        Appointment(
          id: DateTime.now().toString(),
          bookingStart: DateTime.parse(bookingStart),
          bookingEnd: DateTime.parse(bookingEnd),
          serviceId: serviceId,
          barberId: barberId,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
