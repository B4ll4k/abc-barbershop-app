import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/services.dart';
import '../models/http_exception.dart';
import '../models/env.dart';

class ServicesProvider with ChangeNotifier {
  final List<Service> _services = [];

  List<Service> get services {
    return [..._services];
  }

  Future<void> fetchServices() async {
    try {
      final response =
          await http.get(Uri.parse(EnviromentVariables.baseUrl + "services"));
      //print(response.body);
      final responseData = jsonDecode(response.body) as List<dynamic>;
      for (var data in responseData) {
        var service = data as Map<String, dynamic>;
        _services.add(
          Service(
            id: service["id"].toString(),
            name: service["name"],
            price: double.parse(service["price"]),
            durationSeconds: double.parse(service["duration"]),
            pictureUrl: service["pictureFullPath"] ?? "",
          ),
        );
      }
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
