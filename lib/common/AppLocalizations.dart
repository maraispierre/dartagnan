import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'play': 'PLAY',
      'rooms': 'ROOMS',
      'game': 'Game',
      'back': 'Back',
      'next': 'Next',
      'round': 'Round ',
      'of': ' of ',
      'or': 'Or',
      'won_the_game': ' wons the game.',
      'see_all': 'SEE ALL',
      'title_add_player': 'Add players',
      'add_player_field': 'Add a player',
      'add_player_field_help': 'Please add a player',
      'title_add_room': 'Rooms Manager',
      'add_room_field': 'Add a room',
      'add_room_field_help': 'Please add a room',
      'add_player_field_name': 'Name',
      'end_by_double': 'End by X2',
      'average': 'Average ',
      'login': 'Sign in with Google',
      'offline': 'Play Offline',
      'choose_room': 'Choose a room'
    },
    'fr': {
      'play': 'JOUER',
      'rooms': 'SALONS',
      'game': 'Jeu',
      'back': 'Ret.',
      'next': 'Suiv.',
      'round': 'Tour ',
      'of': ' de ',
      'or': 'Ou',
      'won_the_game': ' a gagné la partie.',
      'see_all': 'VOIR TOUS',
      'title_add_player': 'Ajouter des joueurs',
      'add_player_field': 'Ajouter un joueur',
      'add_player_field_help': 'Entrer un joueur',
      'add_player_field_name': 'Nom',
      'title_add_room': 'Gestion des salons',
      'add_room_field': 'Ajouter un salon',
      'add_room_field_help': 'Entrer un salon',
      'end_by_double': 'Terminer avec un X2',
      'average': 'Moyenne ',
      'login': 'Se connecter avec Google',
      'offline': 'Jouer hors-ligne',
      'choose_room': 'Choisir un salon'
    },
  };

  String get play {
    return _localizedValues[locale.languageCode]['play'];
  }

  String get rooms {
    return _localizedValues[locale.languageCode]['rooms'];
  }

  String get titleAddPlayer {
    return _localizedValues[locale.languageCode]['title_add_player'];
  }

  String get titleAddRoom {
    return _localizedValues[locale.languageCode]['title_add_room'];
  }

  String get addPlayerField {
    return _localizedValues[locale.languageCode]['add_player_field'];
  }

  String get addPlayerFieldHelp {
    return _localizedValues[locale.languageCode]['add_player_field_help'];
  }

  String get addPlayerFieldName {
    return _localizedValues[locale.languageCode]['add_player_field_name'];
  }

  String get addRoomField {
    return _localizedValues[locale.languageCode]['add_room_field'];
  }

  String get addRoomFieldHelp {
    return _localizedValues[locale.languageCode]['add_room_field_help'];
  }

  String get endByDouble {
    return _localizedValues[locale.languageCode]['end_by_double'];
  }

  String get game {
    return _localizedValues[locale.languageCode]['game'];
  }

  String get back {
    return _localizedValues[locale.languageCode]['back'];
  }

  String get next {
    return _localizedValues[locale.languageCode]['next'];
  }

  String get round {
    return _localizedValues[locale.languageCode]['round'];
  }

  String get det_of {
    return _localizedValues[locale.languageCode]['of'];
  }

  String get det_or {
    return _localizedValues[locale.languageCode]['or'];
  }

  String get wonTheGame {
    return _localizedValues[locale.languageCode]['won_the_game'];
  }

  String get seeAll {
    return _localizedValues[locale.languageCode]['see_all'];
  }

  String get average {
    return _localizedValues[locale.languageCode]['average'];
  }

  String get login {
    return _localizedValues[locale.languageCode]['login'];
  }

  String get offline {
    return _localizedValues[locale.languageCode]['offline'];
  }

  String get chooseRoom {
    return _localizedValues[locale.languageCode]['choose_room'];
  }
}