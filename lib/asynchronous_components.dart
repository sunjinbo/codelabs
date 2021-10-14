import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class AsyncComponentsPage extends StatefulWidget {

  const AsyncComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AsyncStatefulWidgetState();
}

class _AsyncStatefulWidgetState extends State<AsyncComponentsPage> {
  DataModel _model = DataModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CodeLabsLocalizations.of(context).asynchronous),
      ),
      body: Container(
        color: Colors.white,
        child: AnimatedBuilder(
          animation: _model,
          builder: (context, child) {
            return Column(
              children: [
                Text("${_model.data.name} - ${_model.data.age}"),
                RaisedButton(onPressed: (){
                  _model.getData();
                },
                  child: Text('update'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DataBean {
  var name = 'bear';
  var age = 9;
}

class DataModel extends ChangeNotifier {
  late DataBean _dataBean;

  DataModel() {
    _dataBean = DataBean();
  }

  DataBean get data => _dataBean;

  Future<void> getData() async {
    Future.delayed(
      const Duration(seconds: 3),
          () {
            _dataBean.name = 'star';
            _dataBean.age += 1;
            notifyListeners();
          }
    );
  }
}