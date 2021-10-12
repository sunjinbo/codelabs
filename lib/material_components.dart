import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class MaterialComponentsPage extends StatefulWidget {

  const MaterialComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MaterialStatefulWidgetState();
}

class _MaterialStatefulWidgetState extends State<MaterialComponentsPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    ButtonComponentsView(),
    InputComponentsView(),
    DialogComponentsView(),
    InfoComponentsView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(CodeLabsLocalizations.of(context).materialComponents),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){},
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
        label: const Text('Approve'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Button',
            backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Input',
            backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Dialog',
            backgroundColor: Colors.lightBlueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Info',
            backgroundColor: Colors.lightBlueAccent,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ButtonComponentsView extends StatelessWidget {
  const ButtonComponentsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25, 2, 3, 1),
            child: RaisedButton(
              color: Colors.blueAccent,
              child: Text('Button'),
              onPressed: () {},
            )
          ),
          FlatButton(
            color: Colors.deepOrange,
            child: Text('Button'),
            onPressed: (){},
          ),
          Center(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.access_alarm_outlined),
                tooltip: 'alarm',
                onPressed: (){},
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.add_a_photo),
                tooltip: 'photo',
                onPressed: (){},
              ),

              IconButton(
                icon: const Icon(Icons.add_box_outlined),
                tooltip: 'box',
                onPressed: (){},
              ),

              IconButton(
                icon: const Icon(Icons.addchart_rounded),
                tooltip: 'chart',
                onPressed: (){},
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 5,
            child: Container(color: Colors.purpleAccent,),
          )
        ],
      ),
    );
  }
}

class InputComponentsView extends StatefulWidget {
  const InputComponentsView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputComponentState();
}

class _InputComponentState extends State<InputComponentsView> {
  bool isChecked = false;
  bool radioSelected = false;
  double currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
          cursorColor: Colors.red,
        ),
        Checkbox(
          activeColor: Colors.blue,
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Switch(value: isChecked, onChanged: (bool? value){
          setState(() {
            isChecked = value!;
          });
        }),
        Slider(
          min: 0,
          max: 100,
          divisions: 5,
          label: currentSliderValue.round().toString(),
          value: currentSliderValue,
          onChanged: (double value) {
            setState(() {
              currentSliderValue = value;
            });
          })
      ],
    );
  }
}

class DialogComponentsView extends StatelessWidget {
  const DialogComponentsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RaisedButton(
         child: Text('SimpleDialog'),
         onPressed: (){
           _showSimpleDialog(context);
         }),
        RaisedButton(
            child: Text('AlertDialog'),
            onPressed: (){
              _showAlertDialog(context);
            }),
        RaisedButton(
            child: Text('BottomSheet'),
            onPressed: (){
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.amber,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Modal BottomSheet'),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
        RaisedButton(
            child: Text('ExpansionPanel'),
            onPressed: (){

            }),
        RaisedButton(
            child: Text('SnackBar'),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Awesome SnackBar!'),
                action: SnackBarAction(
                  label: 'Action',
                  onPressed: () {

                  },
                ),)
              );
            }),
      ],
    );
  }

  void _showSimpleDialog(BuildContext context) async {
    var result = await showDialog(
        context:context,
        builder: (context){
          return SimpleDialog(
            title: Text('This is an SimpleDialog!'),
            children: [
              SimpleDialogOption(
                onPressed: () {Navigator.pop(context, '');},
                child: const Text('Ok'),
              ),
              SimpleDialogOption(
                onPressed: () {Navigator.pop(context, '');},
                child: const Text('Cancel'),
              ),
            ],
          );
        }
    );
  }

  void _showAlertDialog(BuildContext context) async {
    var result = await showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text('Alert'),
            content: Text('This is an AlertDialog!'),
            actions: <Widget>[
              TextButton(
                child: Text(CodeLabsLocalizations.of(context).cancel),
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
              ),
              TextButton(
                child: Text(CodeLabsLocalizations.of(context).ok),
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                },
              )
            ],
          );
        }
    );
  }
}

class InfoComponentsView extends StatelessWidget {
  const InfoComponentsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/barrier.png'),
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Icon(
                Icons.audiotrack,
                color: Colors.green,
                size: 30.0,
              ),
              Icon(
                Icons.beach_access,
                color: Colors.blue,
                size: 36.0,
              ),
            ],
          ),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          label: const Text('Aaron Burr'),
        ),
        Divider(
          height: 20,
          thickness: 5,
          indent: 20,
          endIndent: 20,
        ),
        const Tooltip(
          message: 'I am a Tooltip',
          child: Text('Hover over the text to show a tooltip.'),
        ),
        LinearProgressIndicator(
          minHeight: 2,
          value: 50,
          semanticsLabel: 'Linear progress indicator',
        ),
        Text(
          'Hello, Text! This is our homeland, we believe our country will be the top class country in the  world.',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 2,
        ),
        RichText(
          text: TextSpan(
            text: 'hello ',
            style: DefaultTextStyle.of(context).style,
            children: const <TextSpan>[
              TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' world!'),
            ]
        )),
        RawImage(
          color: Colors.red,
          width: 20,
          height: 20,
        )
      ],
    );
  }
}