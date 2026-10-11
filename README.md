# hue_rotation

Apply a hue rotation to any Flutter widget subtree using a color matrix.

## Installation

**Flutter 3.47+**

```yaml
dependencies:
  hue_rotation: ^3.0.0
```

**Flutter 3.10–<3.47**

```yaml
dependencies:
  hue_rotation: ^2.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:hue_rotation/hue_rotation.dart';

const HueRotation(
  degrees: 90,
  child: Icon(Icons.favorite, color: Colors.blue, size: 64),
)
```

`degrees` accepts positive, negative, and fractional angles. Zero and full turns leave colors unchanged. Alpha is preserved. A half-turn (`180`) uses the [hue rotation matrix](https://www.w3.org/TR/filter-effects-1/#feColorMatrixElement); it is not RGB inversion or an HSV hue adjustment. Output channels outside the display gamut are clamped, so brightness and saturation can appear different.

Update `degrees` from an animation to animate the filter. See the [example](example/lib/main.dart) for static and animated rotations of `Colors.blue`.

## Upgrading to 3.0.0

The widget API is unchanged. Mobile host apps follow Flutter’s minimums (iOS 15 and Android API 24 on Flutter 3.47), or any higher minimum required by the app.

## HueRotation in action

![Hue rotation preview](https://raw.githubusercontent.com/nohli/hue_rotation/main/assets/preview.gif)
![Animated hue rotation](https://raw.githubusercontent.com/nohli/hue_rotation/main/assets/breathe.gif)
