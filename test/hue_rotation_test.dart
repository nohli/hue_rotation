import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hue_rotation/hue_rotation.dart';

void main() {
  testWidgets('zero degrees preserves every channel with an identity filter', (tester) async {
    await tester.pumpWidget(const HueRotation(degrees: 0, child: SizedBox()));
    expect(
        tester.widget<ColorFiltered>(find.byType(ColorFiltered)).colorFilter,
        const ColorFilter.matrix(<double>[
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]));
  });
  final cases = <num, List<int>>{
    0: [255, 0, 0, 255],
    90: [0, 91, 0, 255],
    180: [0, 108, 108, 255],
    -180: [0, 108, 108, 255],
    360: [255, 0, 0, 255],
  };
  for (final entry in cases.entries) {
    testWidgets('renders red rotated by ${entry.key} degrees', (tester) async {
      final key = GlobalKey();
      const child = ColoredBox(color: Color(0xffff0000));
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
            child: RepaintBoundary(
          key: key,
          child: SizedBox(width: 10, height: 10, child: HueRotation(degrees: entry.key, child: child)),
        )),
      ));
      expect(tester.widget<ColorFiltered>(find.byType(ColorFiltered)).child, same(child));
      final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final bytes = await tester.runAsync(() async {
        final image = await boundary.toImage();
        try {
          return await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        } finally {
          image.dispose();
        }
      });
      for (var channel = 0; channel < 4; channel++) {
        expect(bytes!.getUint8(channel), closeTo(entry.value[channel], 1));
      }
    });
  }
}
