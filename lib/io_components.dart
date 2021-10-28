import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'codelabs_localizations.dart';
import 'log.dart';

class IoComponentsPage extends StatefulWidget {

  const IoComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IoStatefulWidgetState();
}

class _IoStatefulWidgetState extends State<IoComponentsPage> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CodeLabsLocalizations.of(context).io),),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            FutureBuilder(
                future: _dio.get('https://www.baidu.com/'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Response response = snapshot.data;
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return Text(response.data.toString());
                  }
                  return Text('loading...');
                }),
            DownloadWidgets(),
          ],
        ),
      )
    );
  }
}

class DownloadWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DownloadWidgetsStatefulState();
}

class _DownloadWidgetsStatefulState extends State<DownloadWidgets> {
  double _progress = 0.0;
  late DownloadTask _task;

  _DownloadWidgetsStatefulState() {
    _task = DownloadTask(this, (progress, total) {
      _progress = progress.toDouble() / total.toDouble();
      Log.d("$progress - $total - $_progress");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 4,
            value: _progress,
            backgroundColor: Colors.greenAccent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            semanticsLabel: 'Linear progress indicator',
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            minWidth: double.infinity,
            child: new Text(getText()),
            onPressed: () {
              _task.next();
            },
          ),
        ],
      ),
    );
  }

  String getText() {
    switch(_task.state) {
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
  static const url = 'https://icons.iconarchive.com/icons/graphicloads/100-flat/128/announcement-icon.png';
  static const chunk = 1024;

  DownloadState state = DownloadState.NotStart;
  late ProgressCallback callback;
  late State<DownloadWidgets> widgets;

  var start = 0;
  var end = 0;
  var contentLength = 0;

  DownloadTask(this.widgets, this.callback);

  Future<void> next() async {
    switch(state) {
      case DownloadState.NotStart:
      case DownloadState.Downloaded:
        await _start();
        break;
      case DownloadState.Downloading:
        await _pause();
        break;
      case DownloadState.DownloadSuspend:
        await _resume();
        break;
      case DownloadState.DownloadFailed:
        await _retry();
        break;
    }
  }

  Future<void> _start() async {
    if (state == DownloadState.NotStart
      || state == DownloadState.Downloaded
      || state == DownloadState.DownloadFailed) {

      _setState(DownloadState.Downloading);

      try {
        // 先判断临时文件是否存在，如果不存在则直接下载，否则先删除
        String dir = (await getApplicationDocumentsDirectory()).path;
        File temp = File('$dir/temp');
        if (await temp.exists()) {
          await temp.delete();
        }

        // 准备下载文件，创建dio
        Dio dio = Dio();

        // 获取当前下载文件的总的大小
        contentLength = await _getContentLength(dio, url);
        print("$contentLength");

        // 开始启动下载
        Response response = await dio.get(
          url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );

        File saveFile = new File('$dir/temp');
        var raf = saveFile.openSync(mode: FileMode.write);

        start = 0;
        end = chunk < contentLength ? chunk : contentLength;

        callback.call(0, contentLength);

        while (start < end) {
          raf.writeFromSync(response.data, start, end);
          callback.call(end, contentLength);

          start = end;
          end += chunk;
          if (end > contentLength - 1) {
            end = contentLength - 1;
          }

          if (state == DownloadState.DownloadSuspend) { // 被用户中止了
            // 先判断是否已经下载完了
            if (start < end) {
              // 跳出读取循环，并保存当前下载位置，关闭文件
              await raf.close();
              return;
            } else {
              // 已经下载完了，没办法就这么着吧
            }
          }
        }

        callback.call(end, contentLength);

        await raf.close();

        _setState(DownloadState.Downloaded);
      } catch (e) {
        Log.d(e.toString());

        _setState(DownloadState.DownloadFailed);
      }
    }
  }

  Future<void> _pause() async {
    if (state == DownloadState.Downloading) {
      _setState(DownloadState.DownloadSuspend);
    }
  }

  Future<void> _resume() async {
    if (state == DownloadState.DownloadSuspend) {
      _setState(DownloadState.Downloading);

      try {
        Dio dio = Dio();
        Response response = await dio.get(
          url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );

        String dir = (await getApplicationDocumentsDirectory()).path;
        File saveFile = File('$dir/temp');
        var raf = saveFile.openSync(mode: FileMode.append);

        while (start < end) {
          raf.writeFromSync(response.data, start, end);
          callback.call(end, contentLength);

          start = end;
          end += chunk;
          if (end > contentLength - 1) {
            end = contentLength - 1;
          }

          if (state == DownloadState.DownloadSuspend) { // 被用户中止了
            // 先判断是否已经下载完了
            if (start < end) {
              // 跳出读取循环，并保存当前下载位置，关闭文件
              await raf.close();
              return;
            } else {
              // 已经下载完了，没办法就这么着吧
            }
          }
        }

        callback.call(end, contentLength);

        await raf.close();

        _setState(DownloadState.Downloaded);
      } catch (e) {
        Log.d(e.toString());
        _setState(DownloadState.DownloadFailed);
      }
    }
  }

  Future<void> _retry() async {
    await _start();
  }

  void _setState(DownloadState newState) {
    state = newState;
    widgets.setState(() {

    });
  }

  Future<int> _getContentLength(Dio dio, url) async {
    try {
      Response response = await dio.head(url);
      return int.parse(response.headers.value('content-length'));
    } catch (e) {
      return 0;
    }
  }
}
