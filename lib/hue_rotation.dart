library hue_rotation;

import 'dart:math';

import 'package:flutter/material.dart';

///
class HueRotation extends StatelessWidget {
  /// Applies a hue rotation on the color of the [child].
  const HueRotation({
    required this.degrees,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// [degrees] around the color circle the [child]'s color is adjusted.
  /// A value of 0 leaves the child unchanged.
  /// A value of 180 paints the complementary color.
  /// https://en.wikipedia.org/wiki/Color_wheel
  final num degrees;

  /// The [child] widget whose color to be manipulated.
  final Widget child;

  static const _matrix1 = [
    0.2127, 0.7152, 0.0722, //
    0.2127, 0.7152, 0.0722,
    0.2127, 0.7152, 0.0722,
  ];

  static const _matrix2 = [
    0.7873, -0.7152, -0.0722, //
    -0.2127, 0.2845, -0.0722,
    -0.2127, -0.7152, 0.9278,
  ];

  static const _matrix3 = [
    -0.2127, -0.7152, 0.9278, //
    0.143, 0.140, -0.283,
    -0.7873, 0.7152, 0.0722,
  ];

  @override
  Widget build(BuildContext context) {
    final double radians = degrees / 180 * pi;
    final double cosinus = cos(radians);
    final double sinus = sin(radians);

    // https://www.w3.org/TR/filter-effects-1/#feColorMatrixElement
    double value(int position) =>
        _matrix1[position] +
        cosinus * _matrix2[position] +
        sinus * _matrix3[position];

    final ColorFilter hueFilter = ColorFilter.matrix([
      value(0), value(1), value(2), 0, 0, //
      value(3), value(4), value(5), 0, 0,
      value(6), value(7), value(8), 0, 0,
      0, 0, 0, 1, 0,
    ]);

    return ColorFiltered(colorFilter: hueFilter, child: child);
  }
}
