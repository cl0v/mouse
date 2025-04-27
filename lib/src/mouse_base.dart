import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:mouse/src/macos/core_graphics_min_bindings.dart' as cg;
import 'package:win32/win32.dart';

part 'mouse_macos.dart';
part 'mouse_windows.dart';

/// The mouse button to use.
enum MouseButton {
  /// The left mouse button.
  left,

  /// The right mouse button.
  right,

  /// The middle mouse button.
  middle,
}

/// Get the current mouse cursor position.
Point<double> getPosition() {
  switch (Platform.operatingSystem) {
    case 'macos':
      return _getPositionMacos();
    case 'windows':
      return _getPositionWindows();
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Move the mouse cursor to a specific position.
void moveTo(Point<double> position) {
  switch (Platform.operatingSystem) {
    case 'macos':
      _moveToMacos(position);
    case 'windows':
      _moveToWindows(position);
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Click the left mouse button.
void click() {
  switch (Platform.operatingSystem) {
    case 'macos':
      _clickMacos();
    case 'windows':
      _clickWindows();
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Click the right mouse button.
void rightClick() {
  switch (Platform.operatingSystem) {
    case 'macos':
      _rightClickMacos();
    case 'windows':
      _rightClickWindows();
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Press down a mouse button.
void mouseDown(MouseButton button) {
  switch (Platform.operatingSystem) {
    case 'macos':
      _mouseDownMacos(button);
    case 'windows':
      _mouseDownWindows(button);
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Release a mouse button.
void mouseUp(MouseButton button) {
  switch (Platform.operatingSystem) {
    case 'macos':
      _mouseUpMacos(button);
    case 'windows':
      _mouseUpWindows(button);
  }
}
