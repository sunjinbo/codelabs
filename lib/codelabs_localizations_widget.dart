import 'package:flutter/material.dart';

class CodeLabsLocalizationsWidget extends StatefulWidget {
  final Widget child;

  CodeLabsLocalizationsWidget({required Key key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CodeLabsLocalizationsState();
}

class CodeLabsLocalizationsState extends State<CodeLabsLocalizationsWidget> {
  Locale _locale = const Locale('zh', 'CH');

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}

