import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef IsolateCallback = void Function(String msg);

class IsolateComponentsPage extends StatefulWidget {

  const IsolateComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IsolateStatefulWidgetState();
}

class _IsolateStatefulWidgetState extends State<IsolateComponentsPage> {

  late IsolateTask _task;

  _IsolateStatefulWidgetState() {
    _task = IsolateTask((String s)=>{
      setState(() {})
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Isolate'),),
        body: Container(color: Colors.white,
          child: Column(
            children: [
              Text(_task.msg),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: double.infinity,
                child: new Text('echo'),
                onPressed: () async {
                  await _task.start();
                },
              ),
            ],
          ),
        )
    );
  }
}

class IsolateTask {

  String _msg = "";

  late IsolateCallback callback;

  IsolateTask(this.callback);

  String get msg => _msg;

  Future start() async {
    var receivePort = new ReceivePort();
    await Isolate.spawn(echo, receivePort.sendPort);

    // The 'echo' isolate sends it's SendPort as the first message
    var sendPort = await receivePort.first;

    var msg = await sendReceive(sendPort, "foo");
    print('received $msg');
    _msg = msg;

    callback.call(_msg);

    msg = await sendReceive(sendPort, "bar");
    print('received $msg');
    _msg = msg;

    callback.call(_msg);
  }

  static echo(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    var port = new ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      var data = msg[0];
      SendPort replyTo = msg[1];

      await Future.delayed(Duration(seconds: 1));
      replyTo.send(data);
      if (data == "bar") port.close();
    }
  }

  /// sends a message on a port, receives the response,
  /// and returns the message
  Future sendReceive(SendPort port, msg) {
    ReceivePort response = new ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
