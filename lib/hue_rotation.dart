library hue_rotation;

import 'dart:math';

import 'package:flutter/material.dart';

///
class HueRotation extends StatelessWidget {
  /// Applies a hue rotation on the input image.
  const HueRotation({
    required this.degrees,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Number of degrees around the color circle the child's color is adjusted.
  /// A value of 0 leaves the input unchanged.
  /// A value of 180 paints the complementary color.
  /// https://en.wikipedia.org/wiki/Color_wheel
  final num degrees;

  /// The widget whose color to be manipulated.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const List<double> matrix1 = <double>[
      0.213, 0.715, 0.072, //
      0.213, 0.715, 0.072,
      0.213, 0.715, 0.072,
    ];
    const List<double> matrix2 = <double>[
      0.787, -0.715, -0.072, //
      -0.213, 0.2845, -0.072,
      -0.213, -0.715, 0.928,
    ];
    const List<double> matrix3 = <double>[
      -0.213, -0.715, 0.928, //
      0.143, 0.140, -0.283,
      -0.787, 0.715, 0.072,
    ];

    // https://www.w3.org/TR/filter-effects-1/#feColorMatrixElement
    double value(int position) =>
        matrix1[position] +
        cos(degrees / 60) * matrix2[position] +
        sin(degrees / 60) * matrix3[position];

    final ColorFilter hueFilter = ColorFilter.matrix(<double>[
      value(0), value(1), value(2), 0, 0, //
      value(3), value(4), value(5), 0, 0,
      value(6), value(7), value(8), 0, 0,
      0, 0, 0, 1, 0,
    ]);

    return ColorFiltered(colorFilter: hueFilter, child: child);
  }
}
