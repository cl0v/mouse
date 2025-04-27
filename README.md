A simple, low-dependency and cross-platform mouse control library for Dart.

This package provides primitive mouse control functionality for desktop platforms. It supports both Windows and macOS, allowing you to programmatically control mouse movements and clicks.

## Features

- Get current mouse cursor position
- Move mouse cursor to specific coordinates
- Perform left and right clicks
- Support for different mouse buttons (left, right, middle)
- Cross-platform support (Windows and macOS)

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  mouse: ^1.0.0
```

## Usage

Here's a simple example that prints the current mouse position every 100 milliseconds:

```dart
import 'dart:async';
import 'package:mouse/mouse.dart';

void main() {
  Timer.periodic(const Duration(milliseconds: 100), (timer) {
    final position = getPosition();
    print('Current mouse position: $position');
  });
}
```

To move the mouse cursor to a specific position:

```dart
import 'package:mouse/mouse.dart';

void main() {
  // Move to coordinates (100, 100)
  moveTo(Point(100, 100));
}
```

To perform a click:

```dart
import 'package:mouse/mouse.dart';

void main() {
  // Left click
  click();
  
  // Right click
  rightClick();
}
```

## Additional information

This package uses FFI to interact with the native system APIs:
- Windows: Uses the Win32 API through the `win32` package
- macOS: Uses CoreGraphics through the `objective_c` package

For more information about the implementation details, please refer to the source code in the `lib/src` directory.

## Known issues

- Drag & Drop using mouseDown and mouseUp is not supported on macOS.
- Linux is not supported.