import 'package:flutter/cupertino.dart';

import 'codelabs_localizations.dart';

class CupertinoComponentsPage extends StatefulWidget {

  const CupertinoComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CupertinoStatefulWidgetState();
}

class _CupertinoStatefulWidgetState extends State<CupertinoComponentsPage> {
  double _sliderValue = 25;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(CodeLabsLocalizations.of(context).cupertinoComponents),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CupertinoButton(
            onPressed: () {

            },
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5),
            child: Text('CupertinoDialog'),),
          CupertinoButton(
            onPressed: () {
              showCupertinoDialog<void>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Proceed with destructive action?'),
                  actions: <CupertinoDialogAction>[
                    CupertinoDialogAction(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('Yes'),
                      isDestructiveAction: true,
                      onPressed: () {
                        // Do something destructive.
                      },
                    )
                  ],
                ),
              );
            },
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            color: Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5),
            child: Text('CupertinoAlertDialog'),),
          CupertinoActivityIndicator(
            animating: true,
            radius: 20.0,
          ),
          CupertinoSlider(
            onChanged: (double value) {
              setState(() {
                _sliderValue = value;
              });
            },
            max: 100,
            min: 0,
            value: _sliderValue,),
          CupertinoSwitch(
            onChanged: (bool value) {
              setState(() {
                _switchValue = value;
              });
            },
            value: _switchValue,),
        ],),
    );
  }
}