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
      'game': 'Game',
      'back': 'Back',
      'next': 'Next',
      'round': 'Round ',
      'of': ' of ',
      'won_the_game': 'wons the game.',
      'see_all': 'SEE ALL',
      'title_add_player': 'Add players',
      'add_player_field': 'Add a player',
      'add_player_field_help': 'Please add a player',
      'add_player_field_name': 'Name',
      'end_by_double': 'End by X2',
      'average': 'Average ',
    },
    'fr': {
      'play': 'JOUER',
      'game': 'Jeu',
      'back': 'Retour',
      'next': 'Suiv.',
      'round': 'Tour ',
      'of': ' de ',
      'won_the_game': 'a gagné la partie.',
      'see_all': 'VOIR TOUS',
      'title_add_player': 'Ajouter des joueurs',
      'add_player_field': 'Ajouter un joueur',
      'add_player_field_help': 'Entrer un joueur',
      'add_player_field_name': 'Nom',
      'end_by_double': 'Terminer avec un X2',
      'average': 'Moyenne ',
    },
  };

  String get play {
    return _localizedValues[locale.languageCode]['play'];
  }

  String get titleAddPlayer {
    return _localizedValues[locale.languageCode]['title_add_player'];
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

  String get wonTheGame {
    return _localizedValues[locale.languageCode]['won_the_game'];
  }

  String get seeAll {
    return _localizedValues[locale.languageCode]['see_all'];
  }

  String get average {
    return _localizedValues[locale.languageCode]['average'];
  }

}