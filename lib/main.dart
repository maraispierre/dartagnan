import 'package:flutter/material.dart';
import 'package:dartagnan/pages/launcher/GameLauncher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dartagnan/common/AppLocalizationsDelegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login/LoginPage.dart';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      const AppLocalizationsDelegate(),
    ],
    supportedLocales: [
      const Locale('en'), // English
      const Locale('fr'), // Français
    ],
    theme: ThemeData(fontFamily: 'Portico'),
    debugShowCheckedModeBanner: false,
    title: 'Dartagnan',
    home: LoginPage(),
  ));
}
