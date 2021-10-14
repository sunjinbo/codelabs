import 'package:codelabs/list_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'asynchronous_components.dart';
import 'basic_widgets.dart';
import 'cupertino_components.dart';
import 'codelabs_localizations_delegates.dart';
import 'codelabs_localizations_widget.dart';
import 'codelabs_localizations.dart';
import 'layout_widgets.dart';
import 'material_components.dart';
import 'snake_page.dart';

void main() {
  runApp(MyApp());
}

GlobalKey<CodeLabsLocalizationsState> codeLabsLocalizationStateKey = new GlobalKey<CodeLabsLocalizationsState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeLabs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CodeLabsLocalizationsWidget(
        key: codeLabsLocalizationStateKey,
        child: MyHomePage(title: 'CodeLabs'),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CodeLabsLocalizationsDelegates.delegate
      ],
      locale: Locale('zh', 'CN'),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('zh', 'CN'),
      ],
    localeResolutionCallback: (local, support) {
      if (support.contains(local)) {
        return local;
      }
      return const Locale('zh', 'CN'); // default language
    }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () { _changeLocal(); },
            icon: Icon(Icons.language),
            tooltip: CodeLabsLocalizations.of(context).language,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 4, left: 4, right: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).snake),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return SnakePage();
                  }));
            },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).basicWidgets),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return BasicWidgetsPage();
                    }));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).materialComponents),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return MaterialComponentsPage();
                    }));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).cupertinoComponents),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return CupertinoComponentsPage();
                    }));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).layout),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return LayoutPage();
                    }));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).list),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return ListComponentsPage();
                    }));
              },
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(CodeLabsLocalizations.of(context).asynchronous),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return AsyncComponentsPage();
                    }));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _changeLocal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text(CodeLabsLocalizations.of(context).selectLanguage),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                _switchLanguage(0);
                Navigator.of(context).pop();
              },
              child: new Text(CodeLabsLocalizations.of(context).chinese),
            ),
            SimpleDialogOption(
              onPressed: () {
                _switchLanguage(1);
                Navigator.of(context).pop();
              },
              child: new Text(CodeLabsLocalizations.of(context).english),
            )
          ],
        );
      },
    );
  }

  void _switchLanguage(int index) {
    switch(index){
      case 0:
        codeLabsLocalizationStateKey.currentState?.changeLocale(const Locale('zh','CH'));
        break;
      case 1:
        codeLabsLocalizationStateKey.currentState?.changeLocale(const Locale('en','US'));
        break;
    }
  }
}
