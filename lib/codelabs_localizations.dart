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
      'cancel': 'Cancel',
      'select language': 'Select language',
      'english': 'English',
      'chinese': 'Chinese',
      'basic widgets': 'Basic Widgets',
      'material components': 'Material Components',
      'cupertino components': 'Cupertino Components',
      'layout': 'Layout',
      'text': 'Text',
      'assets': 'Assets, Image, Icons',
      'list': 'List',
      'asynchronous': 'Asynchronous',
      'io': 'File & Network',
      'start': 'Start',
      'pause': 'Pause',
      'resume': 'Resume',
      'stop': 'Stop',
      'retry': 'Retry',
      'try again': 'Try again',
      'custom widgets': 'Custom Widgets',
      'event handler': 'Event Handler',
      'native': 'Native Invocation'
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
      'cancel': '取消',
      'select language': '请选择语言',
      'english': '英文',
      'chinese': '中文',
      'basic widgets': '基础控件',
      'material components': 'Android风格的控件',
      'cupertino components': 'iOS风格的控件',
      'layout': '布局',
      'text': '文本显示和样式',
      'assets': 'Assets、图片、Icons',
      'list': '列表控件',
      'asynchronous': '异步处理',
      'io': '文件操作与网络请求',
      'start': '开始',
      'pause': '暂停',
      'resume': '继续',
      'stop': '停止',
      'retry': '重试',
      'try again': '再来一次',
      'custom widgets': '自定义组件',
      'event handler': '事件处理',
      'native': '原生调用',
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

  get selectLanguage {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['select language'];
  }

  get english {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['english'];
  }

  get chinese {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['chinese'];
  }

  get basicWidgets {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['basic widgets'];
  }

  get materialComponents {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['material components'];
  }

  get cupertinoComponents {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['cupertino components'];
  }

  get layout {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['layout'];
  }

  get text {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['text'];
  }

  get assets {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['assets'];
  }

  get list {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['list'];
  }

  get asynchronous {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['asynchronous'];
  }

  get io {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['io'];
  }

  get start {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['start'];
  }

  get pause {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['pause'];
  }

  get resume {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['resume'];
  }

  get stop {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['stop'];
  }

  get retry {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['retry'];
  }

  get tryAgain {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['try again'];
  }

  get customWidgets {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['custom widgets'];
  }

  get eventHandler {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['event handler'];
  }

  get native {
    Map<String, String> map = _localizedValues[locale.languageCode]!;
    return map['native'];
  }
}
