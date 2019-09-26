import 'package:flutter/material.dart';
import 'package:flutter_dart_score/pages/common/AddPlayer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dart_score/pages/common/AppLocalizationsDelegate.dart';

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
    home: AddPlayer(),
  ));
}
