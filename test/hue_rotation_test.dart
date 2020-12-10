import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hue_rotation/hue_rotation.dart';

void main() {
  test('test if widget is painted', () {
    const Widget widget = HueRotation(degrees: 90, child: Icon(Icons.widgets));
    expect(widget, Widget);
  });
}
