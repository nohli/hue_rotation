import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hue_rotation/hue_rotation.dart';
import 'package:hue_rotation_example/main.dart';

void main() {
  testWidgets('Displays row of boxes', (WidgetTester tester) async {
    const widget = MyApp();

    await tester.pumpWidget(widget);

    expect(find.byType(Wrap), findsOneWidget);
    expect(find.byType(ColoredBox), findsWidgets);
  });

  testWidgets('Displays 7 colored boxes', (WidgetTester tester) async {
    const widget = MyApp();

    await tester.pumpWidget(widget);

    expect(find.descendant(of: find.byType(HueRotation), matching: find.byType(ColoredBox)), findsNWidgets(7));
  });

  for (final size in [const Size(227, 227), const Size(600, 227)]) {
    testWidgets('Keeps every color reachable in a $size viewport', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MyApp());
      await tester.pump();

      expect(tester.takeException(), isNull);
      final colors = find.descendant(of: find.byType(HueRotation), matching: find.byType(ColoredBox));
      expect(colors, findsNWidgets(7));
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pump(const Duration(milliseconds: 300));

      for (var second = 0; second < 8; second++) {
        await tester.pump(const Duration(seconds: 1));
        final animation = tester.getRect(colors.last);
        expect(animation.top, greaterThanOrEqualTo(0));
        expect(animation.bottom, lessThanOrEqualTo(size.height));
      }
      expect(tester.takeException(), isNull);
    });
  }
}
