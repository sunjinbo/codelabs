import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'codelabs_localizations.dart';

class CustomComponentsPage extends StatefulWidget {

  const CustomComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomStatefulWidgetState();
}

class _CustomStatefulWidgetState extends State<CustomComponentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(CodeLabsLocalizations.of(context).customWidgets),),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              GradientButton(
                colors: [Colors.orange, Colors.red],
                height: 50.0,
                width: 100.0,
                child: Text("Submit"),
                onPressed: onTap,
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              GradientButton(
                height: 50.0,
                width: 200.0,
                colors: [Colors.lightGreen, Colors.pink],
                child: Text("Submit"),
                onPressed: onTap,
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              GradientButton(
                height: 50.0,
                width: 300.0,
                colors: [Colors.amber, Colors.blueAccent],
                child: Text("Submit"),
                onPressed: onTap,
                borderRadius: BorderRadius.all(Radius.zero),
              ),
            ],
          ),
        ));
  }

  onTap() {
    print("button click");
  }
}

class GradientButton extends StatelessWidget {
  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  //点击回调
  final GestureTapCallback onPressed;

  GradientButton({
    required this.colors,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> _colors = colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
