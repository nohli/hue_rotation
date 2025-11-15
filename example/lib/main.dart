import 'package:flutter/material.dart';
import 'package:hue_rotation/hue_rotation.dart';

void main() => runApp(const MyApp());

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  // https://daddycoding.com/2020/03/30/swiftui-huerotation/
                  _Box(color: _color, degrees: -45),
                  _Box(color: _color, degrees: 0),
                  _Box(color: _color, degrees: 45),
                  _Box(color: _color, degrees: 90),
                  _Box(color: _color, degrees: 180),
                  _Box(color: _color, degrees: 360),
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
    required this.degrees,
    required this.color,
    this.size = 40,
  });

  final num degrees;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        HueRotation(
          degrees: degrees,
          child: SizedBox(
            width: size,
            height: size,
            child: ColoredBox(
              color: color,
            ),
          ),
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
  late final AnimationController _controller;
  late final CurvedAnimation _animation;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _rotation = Tween<double>(begin: 0, end: 1).animate(_animation);
    _controller.repeat();
  }

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotation,
      builder: (context, _) {
        return RotationTransition(
          turns: _rotation,
          child: _Box(
            degrees: (_rotation.value * 360).round(),
            color: Colors.blue,
            size: 120,
          ),
        );
      },
    );
  }
}
