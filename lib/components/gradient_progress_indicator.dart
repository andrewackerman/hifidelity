import 'dart:ui';
import 'package:flutter/material.dart';

class GradientProgressIndicator extends StatefulWidget {
  final double value;

  GradientProgressIndicator({this.value});

  @override
  State createState() => _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator> with TickerProviderStateMixin {
  double current = 0.0;

  AnimationController controller;
  CurvedAnimation curve;
  Animation animation;
  Tween tween;

  @override
  initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    controller.addListener(() {
      setState(() {
        current = (animation.value as num).toDouble();
      });
    });

    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0, end: widget.value).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext cxt) {
    final tick = Text(
      "|",
      style: TextStyle(
        color: Color.fromARGB(255, 200, 200, 200),
        fontSize: 8,
      ),
    );
    final tickRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        tick,
        tick,
        tick,
        tick,
        tick,
      ],
    );

    return Column(
      children: [
        tickRow,
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Container(
            height: 8,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (cxt, constraints) => CustomPaint(
                size: constraints.biggest,
                foregroundPainter: _GradientProgressPainter(value: current),
              ),
            ),
          ),
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: Colors.red,
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   height: 8,
          // ),
        ),
        tickRow,
      ],
    );
  }
}

class _GradientProgressPainter extends CustomPainter {
  static const _leftColor = Color.fromARGB(255, 238, 85, 17);
  static const _rightColor = Color.fromARGB(255, 247, 206, 69);

  final double value;

  _GradientProgressPainter({@required this.value});

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final valColor = Color.lerp(_leftColor, _rightColor, this.value);

    final leftPaint = Paint()..color = _leftColor;
    final rightPaint = Paint()..color = valColor;

    final gradient = LinearGradient(
      colors: [
        _leftColor,
        valColor,
      ],
      stops: [ 0.0, 1.0, ],
    );

    final h2 = size.height / 2;
    final valueWidth = lerpDouble(h2, size.width - h2 - h2, this.value);

    canvas.drawCircle(Offset(h2, h2), h2, leftPaint);
    canvas.drawCircle(Offset(valueWidth + h2, h2), h2, rightPaint);

    final progressRect = Rect.fromLTWH(h2, 0, valueWidth, size.height);
    final gradientPaint = Paint()..shader = gradient.createShader(progressRect);
    canvas.drawRect(progressRect, gradientPaint);
  }
}