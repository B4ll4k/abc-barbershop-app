import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pages/barbers_page.dart';
import './pages/gallery_page.dart';
import './pages/auth_page.dart';
import './pages/main_page.dart';
import './pages/results_page.dart';
import './pages/search_page.dart';
import './pages/splash_screen.dart';
import '../pages/start_page.dart';
import './providers/user_provider.dart';
import './providers/appointment_provider.dart';
import './providers/barber_provider.dart';
import './providers/services_provider.dart';

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
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ServicesProvider()),
        ChangeNotifierProvider(create: (context) => BarberProvider()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        title: 'BarberShop Booking',
        //initialRoute: 'appointments',
        routes: {
          'home': (BuildContext context) => const MainPage(),
          'start': (BuildContext context) => StartPage(),
          'search': (BuildContext context) => SearchPage(),
          'gallery': (BuildContext context) => GalleryPage(),
          'results': (BuildContext context) => ResultsPage(),
          //'appointments': (BuildContext context) => AppointmentPage(),
          'authPage': (BuildContext context) => const AuthPage(),
        },
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
