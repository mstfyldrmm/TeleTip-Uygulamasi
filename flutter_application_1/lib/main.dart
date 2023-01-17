import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_detayli_profil.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_giris.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_kayit.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_profil.dart';
import 'package:flutter_application_1/screen/giris_ekrani.dart';
import 'package:flutter_application_1/screen/giris_ui.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_bilgileri.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_chat_ekrani.dart';

import 'package:flutter_application_1/screen/page_hasta/hasta_doktor_listesi.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_giris.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_kayit.dart';
import 'package:flutter_application_1/screen/page_doktor/home.dart';
import 'package:flutter_application_1/screen/page_hasta/home.dart';
import 'package:flutter_application_1/screen/page_hasta/home_page.dart';
import 'package:flutter_application_1/screen/splash_screen.dart';
import 'package:flutter_application_1/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme().theme,
        home: AnimatedSplashScreen(
          splash: SplashScreen(),
          nextScreen: GirisUi(),
          backgroundColor: Color.fromARGB(255, 138, 134, 226),
          curve: Curves.slowMiddle,
          duration: 3000,
          animationDuration: Duration(seconds: 2),
        ));
  }
}


/*
 AnimatedSplashScreen(
          splash: SplashScreen(),
          nextScreen: GirisUi(),
          backgroundColor: Color.fromARGB(255, 138, 134, 226),
          curve: Curves.slowMiddle,
          duration: 3000,
          animationDuration: Duration(seconds: 2),
        )
*/