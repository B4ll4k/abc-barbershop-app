import 'dart:async';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        ('home'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(172, 128, 39, 1.0),
          elevation: 0.0,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(172, 128, 39, 1.0),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            vertical: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 3.0),
                          ),
                        ),
                        child: Container(
                            decoration: const BoxDecoration(
                                border: Border.symmetric(
                                    horizontal: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 3.0,
                            ))),
                            width: 180.0,
                            height: 210.0,
                            child: Image.asset(
                              'assets/images/hair.png',
                              width: 150.0,
                              height: 150.0,
                            )),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                              vertical: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2.0)),
                        ),
                        child: Container(
                            width: 180.0,
                            height: 50.0,
                            decoration: const BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 3.0)),
                            ),
                            child: const Text(
                              'Barber',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 40.0,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      Container(
                        width: 180.0,
                        height: 100.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
