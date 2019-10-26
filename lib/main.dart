import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dartagnan/common/AppLocalizationsDelegate.dart';
import 'pages/login/LoginPage.dart';
import 'pages/launcher/GameLauncher.dart';
import 'pages/rooms/RoomsManagerPage.dart';

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
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/launcher': (context) => GameLauncher(),
      '/launcherOffline': (context) => GameLauncher(isOffline: true,),
      '/rooms': (context) => RoomsManagerPage(),
    },
  ));
}
