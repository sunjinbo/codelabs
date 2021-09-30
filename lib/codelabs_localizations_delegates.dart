import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'codelabs_localizations.dart';

class CodeLabsLocalizationsDelegates extends LocalizationsDelegate<CodeLabsLocalizations> {

  const CodeLabsLocalizationsDelegates();

  static CodeLabsLocalizationsDelegates delegate = const CodeLabsLocalizationsDelegates();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<CodeLabsLocalizations> load(Locale locale) {
    return new SynchronousFuture(new CodeLabsLocalizations(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}