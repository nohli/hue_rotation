import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
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

    final elements = tester.elementList(
      find.byElementType(SingleChildRenderObjectElement),
    );

    final coloredBoxes = elements
        .map((e) => e.renderObject)
        .whereType<RenderConstrainedBox>()
        .where((e) => e.child != null)
        .map((e) => e.child)
        .toList();

    expect(coloredBoxes.length, 7);
  });
}
