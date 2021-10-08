import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'codelabs_localizations.dart';

class BasicWidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CodeLabsLocalizations.of(context).basicWidgets),
      ),
      body: Center(
        child: BasicWidgetsContainer(),
      ),
    );
  }
}

class BasicWidgetsContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 600,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.purple,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        transform: Matrix4.rotationZ(0.1),
        constraints: BoxConstraints.expand(height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 250.0,),
        child: Column(
          children: [
            new Row(
                children: [
                  const FlutterLogo(),
                  const FlutterLogo(),
                  const FlutterLogo(),
                  const Icon(Icons.image),
                  const Expanded(
                    child: const Text('Flutter\'s hot reload helps you quickly and easily experiment, build UIs, add features, and fix bug faster.')
                  )
                ]),
            new Row(
              children: [
                const Image(
                  width: 120,
                  height: 120,
                  color: Colors.lightBlue,
                  colorBlendMode: BlendMode.colorBurn,
                  isAntiAlias: true,
                  fit: BoxFit.contain,
                  image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                ),
                const Text(
                  'Hello, Flutter!!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            const Text.rich(
              TextSpan(
                text: 'Hello', // default text style
                children: <TextSpan>[
                  TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Click me'),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Toast",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                );
              }),
          ],),
        ),
    );
  }
}