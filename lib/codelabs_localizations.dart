import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CodeLabsLocalizations {
  final Locale locale;

  CodeLabsLocalizations(this.locale);

  static CodeLabsLocalizations of(BuildContext context) {
    return Localizations.of(context, CodeLabsLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'snake': 'Snake',
      'language': 'Language',
      'up': 'Up',
      'down': 'Down',
      'left': 'Left',
      'right': 'Right',
      'game over': 'Game Over!',
      'replay tips': 'Would you like play again?',
      'ok': 'Ok',
      'cancel': 'Cancel'
    },
    'zh': {
      'snake': '贪吃蛇',
      'language': '语言',
      'up': '上',
      'down': '下',
      'left': '左',
      'right': '右',
      'game over': '游戏结束！',
      'replay tips': '想再玩一局吗？',
      'ok': '确认',
      'cancel': '取消'
    }
  };

  get snake {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['snake'];
  }

  get language {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['language'];
  }

  get up {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['up'];
  }

  get down {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['down'];
  }

  get left {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['left'];
  }

  get right {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['right'];
  }

  get gameOver {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['game over'];
  }

  get replayTips {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['replay tips'];
  }

  get ok {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['ok'];
  }

  get cancel {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['cancel'];
  }
}