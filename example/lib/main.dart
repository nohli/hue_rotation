import 'package:flutter/material.dart';
import 'package:hue_rotation/hue_rotation.dart';

void main() => runApp(const MyApp());

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const Color color = Colors.blue;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: const <Widget>[
                  // https://daddycoding.com/2020/03/30/swiftui-huerotation/
                  _Box(color: color, degrees: -45),
                  _Box(color: color, degrees: 0),
                  _Box(color: color, degrees: 45),
                  _Box(color: color, degrees: 90),
                  _Box(color: color, degrees: 180),
                  _Box(color: color, degrees: 360),
                ],
              ),
            ),
            const SizedBox(height: 50),
            _AnimatedBox(),
          ],
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  const _Box({
    required this.color,
    required this.degrees,
    this.size = 40,
    Key? key,
  }) : super(key: key);

  final Color color;
  final num degrees;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        HueRotation(
          degrees: degrees,
          child: Container(width: size, height: size, color: color),
        ),
        Text('$degrees'),
      ],
    );
  }
}

class _AnimatedBox extends StatefulWidget {
  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<_AnimatedBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation animation;
  late final Animation<double> rotation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    rotation = Tween<double>(begin: 0, end: 1).animate(animation);
    rotation.addListener(() {
      if (mounted) setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: rotation,
      child: _Box(
        color: Colors.blue,
        degrees: (rotation.value * 360).round(),
        size: 120,
      ),
    );
  }
}
