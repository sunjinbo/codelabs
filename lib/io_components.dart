import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class IoComponentsPage extends StatefulWidget {

  const IoComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IoStatefulWidgetState();
}

class _IoStatefulWidgetState extends State<IoComponentsPage> {
  DownloadTask task = DownloadTask();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CodeLabsLocalizations.of(context).io),),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            LinearProgressIndicator(
              minHeight: 2,
              value: 0,
              semanticsLabel: 'Linear progress indicator',
            ),
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: new Text(getText()),
              onPressed: () {
                task.next();
              },
            ),
          ],
        ),
      )
    );
  }

  String getText() {
    switch(task.state) {
      case DownloadState.NotStart: return CodeLabsLocalizations.of(context).start;
      case DownloadState.Downloading: return CodeLabsLocalizations.of(context).pause;
      case DownloadState.DownloadSuspend: return CodeLabsLocalizations.of(context).resume;
      case DownloadState.DownloadFailed: return CodeLabsLocalizations.of(context).retry;
      case DownloadState.Downloaded: return CodeLabsLocalizations.of(context).tryAgain;
    }
  }
}

enum DownloadState {
  NotStart,
  Downloading,
  DownloadSuspend,
  DownloadFailed,
  Downloaded
}

class DownloadTask {
  var state = DownloadState.NotStart;

  void next() {
    switch(state) {
      case DownloadState.NotStart:
      case DownloadState.Downloaded:
        _start();
        break;
      case DownloadState.Downloading:
        _pause();
        break;
      case DownloadState.DownloadSuspend:
        _resume();
        break;
      case DownloadState.DownloadFailed:
        _retry();
        break;
    }
  }

  void _start() {

  }

  void _pause() {

  }

  void _resume() {

  }

  void _retry() {

  }
}
