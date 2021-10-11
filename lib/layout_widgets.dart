import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class LayoutPage extends StatefulWidget {

  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LayoutStatefulWidgetState();
}

class _LayoutStatefulWidgetState extends State<LayoutPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LinearLayoutView(),
    FlexLayoutView(),
    FlowLayoutView(),
    StackLayoutView(),
    ConstraintsLayoutView()
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
        title: new Text(CodeLabsLocalizations.of(context).layout),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
        icon: Icon(Icons.circle),
        label: 'linear',
        backgroundColor: Colors.lightBlueAccent,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.circle),
        label: 'flex',
        backgroundColor: Colors.lightBlueAccent,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.circle),
        label: 'flow',
        backgroundColor: Colors.lightBlueAccent,
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.circle),
        label: 'stack',
        backgroundColor: Colors.lightBlueAccent,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'constraints',
          backgroundColor: Colors.lightBlueAccent,
        ),
      ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
    ));
  }
}

class LinearLayoutView extends StatelessWidget {
  const LinearLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 50, height: 50, color: Colors.greenAccent, margin: EdgeInsets.fromLTRB(1, 1, 1, 1),),
              Container(width: 50, height: 50, color: Colors.blueGrey, margin: EdgeInsets.fromLTRB(1, 1, 1, 1)),
              Container(width: 50, height: 50, color: Colors.blue, margin: EdgeInsets.fromLTRB(1, 1, 1, 1),),
            ],
          ),
          Container(width: 50, height: 50, color: Colors.yellow, margin: EdgeInsets.fromLTRB(1, 1, 1, 1),),
          Container(width: 50, height: 50, color: Colors.deepOrange, margin: EdgeInsets.fromLTRB(1, 1, 1, 1)),
          Container(width: 50, height: 50, color: Colors.purpleAccent, margin: EdgeInsets.fromLTRB(1, 1, 1, 1),),
          Container(width: 50, height: 50, color: Colors.cyanAccent, margin: EdgeInsets.fromLTRB(1, 1, 1, 1),),
        ],
      ),
    );
  }
}

class FlexLayoutView extends StatelessWidget {
  const FlexLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: Flex(direction: Axis.horizontal,
        children: [
          Expanded(
              flex: 2,
              child: Container(color: Colors.deepOrange)
          ),
          Expanded(
              flex: 1,
              child: Container(color: Colors.blueAccent)
          )
        ],
      ),
    );
  }
}

class FlowLayoutView extends StatelessWidget {
  const FlowLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: [
          Text("x" * 256),
          Container(width: 50, height: 50, color: Colors.deepOrange),
          Container(width: 50, height: 50, color: Colors.blue),
          Container(width: 50, height: 50, color: Colors.cyanAccent),
          Container(width: 50, height: 50, color: Colors.yellowAccent),
          Container(width: 50, height: 50, color: Colors.amberAccent),
          Container(width: 50, height: 50, color: Colors.amber),
          Container(width: 50, height: 50, color: Colors.teal),
          Container(width: 50, height: 50, color: Colors.black87),

          Flow(
            delegate: FlowLayoutDelegate(margin: EdgeInsets.all(10.0)),
            children: <Widget>[
              Container(width: 80.0, height:80.0, color: Colors.red,),
              Container(width: 80.0, height:80.0, color: Colors.green,),
              Container(width: 80.0, height:80.0, color: Colors.blue,),
              Container(width: 80.0, height:80.0,  color: Colors.yellow,),
              Container(width: 80.0, height:80.0, color: Colors.brown,),
              Container(width: 80.0, height:80.0,  color: Colors.purple,),
            ],
          )
        ],
      )
    );
  }
}

class FlowLayoutDelegate extends FlowDelegate {
  EdgeInsets margin;

  FlowLayoutDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

class StackLayoutView extends StatelessWidget {
  const StackLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: Column(
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              Container(color: Colors.blue, width: 100, height: 100,),
              Container(color: Colors.red, width: 50, height: 50,),
              Positioned(
                left: 10.0,
                top: 10.0,
                child: Container(color: Colors.yellowAccent, width: 10, height: 10,),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ConstraintsLayoutView extends StatelessWidget {
  const ConstraintsLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.amberAccent,
          child: Align(
            widthFactor: 4,
            heightFactor: 2,
            alignment: Alignment.topRight,
            child: FlutterLogo(size: 50,),
          ),
        ),
      )
    );
  }
}
