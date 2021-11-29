import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'codelabs_localizations.dart';

class NativeComponentsPage extends StatefulWidget {

  const NativeComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NativeStatefulWidgetState();
}

class _NativeStatefulWidgetState extends State<NativeComponentsPage> {
  static const platform = const MethodChannel("com.codelabs.codelabs/battery");
  String _batteryLevel = 'Unknown battery level.';
  String _flutterTips = 'No flutter tips.';

  var _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(platformCallHandler);
  }

  @override
  Widget build(BuildContext context) {
    _getBatteryLevel();

    return Scaffold(
        appBar: AppBar(title: Text(CodeLabsLocalizations.of(context).native),),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Text("$_batteryLevel"),
              TextField(
                decoration: InputDecoration(
                    fillColor: Colors.lightGreen
                ),
                controller: _textController,
                maxLength: 20,
                maxLines: 1,
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: double.infinity,
                child: new Text('send text to native'),
                onPressed: () async {
                  await platform.invokeMethod("setTips");

                  await _getTips();
                },
              ),
              Text("$_flutterTips"),
              AndroidView(viewType: 'com.codelabs.codelabs/myview')
            ],
          ),
        )
    );
  }

  Future<String> _getBatteryLevel() async {
    String batteryLevel = 'Unknown battery level.';

    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "Battery level at $result % .";
    } on PlatformException catch (e) {
      batteryLevel = 'Failed to get battery level: ${e.message}';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });

    return batteryLevel;
  }

  Future<dynamic> platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "getFlutterTips":
        return _textController.text;
        break;
    }
  }

  Future<String> _getTips() async {
    String tips = 'No flutter tips.';

    try {
      final String result = await platform.invokeMethod("getTips");
      tips = "$result";
    } on PlatformException catch (e) {
      tips = 'Failed to get tips: ${e.message}';
    }

    setState(() {
      _flutterTips = tips;
    });

    return tips;
  }
}
