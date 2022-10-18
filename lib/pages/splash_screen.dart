import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:abc_barbershop/localization/language_constraints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/services_provider.dart';
import '../providers/barber_provider.dart';
import '../size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isConnected;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) => {_checkConnection(context)});
    super.initState();
  }

  Future _checkConnection(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 30), onTimeout: () async {
        return Future.delayed(Duration.zero).then((value) async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(minutes: 15),
              content: Text(translation(context).connectionFailed
                  // 'Failed to estasblish connection!'
                  ),
              action: SnackBarAction(
                label: translation(context).retry,
                onPressed: () async {
                  await _checkConnection(context);
                },
              ),
            ),
          );
          List<InternetAddress> temp = [];
          temp.add(InternetAddress.fromRawAddress(Uint8List.fromList([])));
          return Future.value(temp);
        });
      });
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      } else {
        _isConnected = false;
      }
      if (_isConnected!) {
        bool isAuth = await Provider.of<UserProvider>(context, listen: false)
            .tryAutoLogIn();
        await initJobs();
        if (isAuth) {
          await Provider.of<AppointmentProvider>(context, listen: false)
              .fetchActiveAppointments(
                  Provider.of<UserProvider>(context, listen: false).user.id);
          await Provider.of<AppointmentProvider>(context, listen: false)
              .fetchHistoryAppointments(
                  Provider.of<UserProvider>(context, listen: false).user.id);
        }
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(minutes: 15),
            content: Text(translation(context).connectionFailed),
            action: SnackBarAction(
              label: translation(context).retry,
              onPressed: () async {
                await _checkConnection(context);
              },
            ),
          ),
        );
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(minutes: 15),
          content: Text(translation(context).connectionFailed),
          action: SnackBarAction(
            label: translation(context).retry,
            onPressed: () async {
              await _checkConnection(context);
            },
          ),
        ),
      );
      _isConnected = false;
    }
  }

  Future<void> initJobs() async {
    await Provider.of<ServicesProvider>(context, listen: false).fetchServices();
    await Provider.of<BarberProvider>(context, listen: false).fetchBarbers();
    await Provider.of<BarberProvider>(context, listen: false).fetchDaysoff();
    await Provider.of<BarberProvider>(context, listen: false)
        .fetchFreeWeekdays();
    await Provider.of<BarberProvider>(context, listen: false)
        .fetchWorkingTime();
    await Provider.of<BarberProvider>(context, listen: false)
        .fetchWorkingHours();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
              height: getProportionateScreenHeight(200),
              width: getProportionateScreenWidth(340),
            ),
            const SizedBox(
              height: 5,
            ),
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
      ),
    );
  }
}
