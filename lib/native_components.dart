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

  @override
  Widget build(BuildContext context) {
    _getBatteryLevel();

    return Scaffold(
        appBar: AppBar(title: Text(CodeLabsLocalizations.of(context).native),),
        body: Container(
          color: Colors.white,
          child: Text("$_batteryLevel"),
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
}
