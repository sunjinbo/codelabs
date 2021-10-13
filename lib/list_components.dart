import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class ListComponentsPage extends StatefulWidget {

  const ListComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListStatefulWidgetState();
}

class _ListStatefulWidgetState extends State<ListComponentsPage> {
  final List<String> entries = <String>[];
  final List<int> colorCodes = <int>[];

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);

    entries.clear();
    entries.add('width = ${deviceData.size.width.toString()}');
    entries.add('height = ${deviceData.size.height.toString()}');
    entries.add('orientation = ${deviceData.orientation.toString()}');
    entries.add('textScaleFactor = ${deviceData.textScaleFactor.toString()}');

    colorCodes.clear();
    for (int i = 0; i < entries.length; ++i) {
      if (i % 2 == 0) {
        colorCodes.add(600);
      } else {
        colorCodes.add(500);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: new Text(CodeLabsLocalizations.of(context).list),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber[colorCodes[index]],
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          }
      )
    );
  }
}
