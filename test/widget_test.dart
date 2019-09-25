// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dart_score/pages/xx1/GameXX1.dart';
import 'package:flutter_dart_score/widgets/xx1/PlayerXX1.dart';
import 'package:flutter_dart_score/widgets/cricket/PlayerCricket.dart';
import 'package:flutter_dart_score/pages/cricket/GameCricket.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dart_score/pages/common/AppLocalizationsDelegate.dart';

void main() {

  /*
  *
  * Test for XX1
  *
  */
  testWidgets('Init XX1 Game with 1 player', (WidgetTester tester) async {
    List<PlayerXX1> players = [];
    players.add(new PlayerXX1(score: 301, name: 'Léa',));
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameXX1(score: 301, endByDouble: false, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    expect(find.byKey(Key('detailPlayerXX1')), findsOneWidget);
    expect(find.byKey(Key('messagePlayer')), findsOneWidget);
    expect(find.byKey(Key('scoringXX1')), findsOneWidget);
  });

  testWidgets('In XX1 Game a player throws a dart', (WidgetTester tester) async {
    List<PlayerXX1> players = [];
    players.add(new PlayerXX1(score: 301, name: 'Léa',));
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameXX1(score: 301, endByDouble: false, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    await tester.tap(find.byKey(Key('btn20')));

    await tester.pump();
    
    expect(players[0].score, 281);

  });

  testWidgets('In XX1 Game a player can end the game', (WidgetTester tester) async {
    List<PlayerXX1> players = [];
    players.add(new PlayerXX1(score: 301, name: 'Léa',));
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameXX1(score: 301, endByDouble: false, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);
  
    for(int i = 0; i<5; i++) {
      await tester.tap(find.byKey(Key('btnX3')));
      await tester.pump();
      await tester.tap(find.byKey(Key('btn20')));
      await tester.pump();
    }
    await tester.tap(find.byKey(Key('btn1')));
    await tester.pump();
    expect(players[0].score, 301);
  });

  /*
  *
  * Test for Cricket
  *
  */
  testWidgets('Init Cricket Game with 1 player', (WidgetTester tester) async {
    List<PlayerCricket> players = [];
    players.add(new PlayerCricket(score: 0, name: 'Léa',));
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameCricket(score: 0, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    expect(find.byKey(Key('detailPlayerCricket')), findsOneWidget);
    expect(find.byKey(Key('messagePlayerCricket')), findsOneWidget);
    expect(find.byKey(Key('scoringCricket')), findsOneWidget);
  });

  testWidgets('In Cricket Game, a player can close a number and make points', (WidgetTester tester) async {
    List<PlayerCricket> players = [];
    players.add(new PlayerCricket(score: 0, name: 'Léa',));
    players.add(new PlayerCricket(score: 0, name: 'Hugo',));

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameCricket(score: 0, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    expect(players[0].score, 30);
  });

  testWidgets('In Cricket Game, two players can close a number and nobody make points', (WidgetTester tester) async {
    List<PlayerCricket> players = [];
    players.add(new PlayerCricket(score: 0, name: 'Léa',));
    players.add(new PlayerCricket(score: 0, name: 'Hugo',));

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameCricket(score: 0, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    //First Player
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn0')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn0')));
    await tester.pump();

    //Second Player
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();

    expect(players[1].score, 0);
  });

  
  testWidgets('In Cricket Game, a player win a game', (WidgetTester tester) async {
    List<PlayerCricket> players = [];
    players.add(new PlayerCricket(score: 0, name: 'Léa',));

    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(
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
            home: new GameCricket(score: 0, players: players,)
        )
    );
    await tester.pumpWidget(testWidget);

    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn15')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn16')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn17')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn18')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn19')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX3')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn20')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btnX2')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn25')));
    await tester.pump();
    await tester.tap(find.byKey(Key('btn25')));
    await tester.pump();

    expect(players[0].tableCricket[15], 0);
  });

}

