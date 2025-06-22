import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:mouse/src/linux/x11_extension_xtest_bindings.dart' as x11Test;
import 'package:mouse/src/macos/core_graphics_min_bindings.dart' as cg;
import 'package:win32/win32.dart';

part 'mouse_macos.dart';
part 'mouse_windows.dart';
part 'mouse_linux.dart';

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
    case 'linux':
      return _getPositionLinux();
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
      break;
    case 'windows':
      _moveToWindows(position);
      break;
    case 'linux':
      _moveToLinux(position);
      break;
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
      break;
    case 'windows':
      _clickWindows();
      break;
    case 'linux':
      _clickLinux();
      break;
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
      break;
    case 'windows':
      _rightClickWindows();
      break;
    case 'linux':
      _rightClickLinux();
      break;
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
      break;
    case 'windows':
      _mouseDownWindows(button);
      break;
    case 'linux':
      _mouseDownLinux(button);
      break;
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
      break;
    case 'windows':
      _mouseUpWindows(button);
      break;
    case 'linux':
      _mouseUpLinux(button);
      break;
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}

/// Scroll the mouse wheel.
///
/// [deltaX] specifies horizontal scroll amount. Positive values scroll right
/// and negative values scroll left. [deltaY] specifies vertical scroll amount.
/// Positive values scroll up and negative values scroll down.
void scroll({int deltaX = 0, int deltaY = 0}) {
  switch (Platform.operatingSystem) {
    case 'macos':
      _scrollMacos(deltaX: deltaX, deltaY: deltaY);
      break;
    case 'windows':
      _scrollWindows(deltaX: deltaX, deltaY: deltaY);
      break;
    case 'linux':
      _scrollLinux(deltaX: deltaX, deltaY: deltaY);
      break;
    default:
      throw UnsupportedError(
          'Unsupported platform: ${Platform.operatingSystem}');
  }
}
