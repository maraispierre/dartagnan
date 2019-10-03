import 'package:flutter/material.dart';
import 'package:dartagnan/pages/common/AddPlayer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dartagnan/pages/common/AppLocalizationsDelegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';

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
    debugShowCheckedModeBanner: false,
    title: 'Dartagnan',
    home: LoginPage(),
  ));
}
