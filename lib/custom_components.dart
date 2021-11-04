import 'dart:math';

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
              RepaintBoundary(
                child: GradientCircularProgressIndicator(
                  colors: [Colors.blue, Colors.blue],
                  radius: 50.0,
                  strokeWidth: 3.0,
                  stops: <double>[],
                  value: 1,
                ),
              )
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

class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator({
    this.strokeWidth = 2.0,
    required this.radius,
    required this.colors,
    required this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    required this.value
  });

  ///粗细
  final double strokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出，读者有兴趣可以研究一下为什么是这样
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme
          .of(context)
          .accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _GradientCircularProgressPainter(
            stops: <double>[],
            strokeWidth: strokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: _colors,
          )
      ),
    );
  }
}

//实现画笔
class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth: 10.0,
    this.strokeCapRound: false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    required this.radius,
    this.total = 2 * pi,
    required this.colors,
    required this.stops,
    required this.value
  });

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(strokeWidth/ (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) & Size(
        size.width - strokeWidth,
        size.height - strokeWidth
    );

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(
          rect,
          _start,
          total,
          false,
          paint
      );
    }

    // 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(
          rect,
          _start,
          _value,
          false,
          paint
      );
    }
  }

  //简单返回true，实践中应该根据画笔属性是否变化来确定返回true还是false
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}
