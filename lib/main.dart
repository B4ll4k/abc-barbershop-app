import 'package:barbershop_app/pages/appointment_page.dart';
import 'package:barbershop_app/pages/gallery_page.dart';
import 'package:barbershop_app/pages/auth_page.dart';
import 'package:barbershop_app/pages/main_page.dart';
import 'package:barbershop_app/pages/results_page.dart';
import 'package:barbershop_app/pages/search_page.dart';
import 'package:barbershop_app/pages/splash_screen.dart';
import 'package:barbershop_app/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.black,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        title: 'BarberShop Booking',
        //initialRoute: 'welcome',
        routes: {
          'home': (BuildContext context) => const MainPage(),
          'start': (BuildContext context) => StartPage(),
          'search': (BuildContext context) => SearchPage(),
          'gallery': (BuildContext context) => GalleryPage(),
          'results': (BuildContext context) => ResultsPage(),
          'appointments': (BuildContext context) => const AppointmentPage(),
          'authPage': (BuildContext context) => const AuthPage(),
        },

        //Theme de diseños general de la Aplicación
        theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(172, 128, 39, 1.0),
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black),
          bottomAppBarTheme: const BottomAppBarTheme(
            color: Color.fromRGBO(172, 128, 39, 1.0),
          ),
        ),
      ),
    );
  }
}
