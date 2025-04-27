part of 'mouse_base.dart';

const _dylibPath =
    '/System/Library/Frameworks/CoreGraphics.framework/Versions/Current/CoreGraphics';

Point<double> _getPositionMacos() {
  final location = _primitiveGetPositionMacos();
  return Point(location.x, location.y);
}

void _moveToMacos(Point<double> position) {
  final lib = cg.CoreGraphics(DynamicLibrary.open(_dylibPath));
  final location = Struct.create<cg.CGPoint>();
  location.x = position.x;
  location.y = position.y;
  lib.CGDisplayMoveCursorToPoint(0, location);
}

void _clickMacos() {
  _mouseDownMacos(MouseButton.left);
  _mouseUpMacos(MouseButton.left);
}

void _rightClickMacos() {
  _mouseDownMacos(MouseButton.right);
  _mouseUpMacos(MouseButton.right);
}

void _mouseDownMacos(MouseButton button) {
  _primitiveMouseEventMacos(
    cg.CGEventType.kCGEventLeftMouseDown,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
}

void _mouseUpMacos(MouseButton button) {
  _primitiveMouseEventMacos(
    cg.CGEventType.kCGEventLeftMouseUp,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
}

cg.CGPoint _primitiveGetPositionMacos() {
  final lib = cg.CoreGraphics(DynamicLibrary.open(_dylibPath));
  final event = lib.CGEventCreate(nullptr);
  final location = lib.CGEventGetLocation(event);
  lib.CFRelease(event as cg.CFTypeRef);
  return location;
}

void _primitiveMouseEventMacos(
  cg.CGEventType type,
  cg.CGPoint location,
  cg.CGMouseButton button,
) {
  final lib = cg.CoreGraphics(DynamicLibrary.open(_dylibPath));
  final event = lib.CGEventCreateMouseEvent(
    nullptr,
    type,
    location,
    button,
  );
  lib.CGEventPost(cg.CGEventTapLocation.kCGHIDEventTap, event);
  lib.CFRelease(event as cg.CFTypeRef);
}

extension _MouseButtonCGMouseButton on MouseButton {
  cg.CGMouseButton get cgMouseButton {
    switch (this) {
      case MouseButton.left:
        return cg.CGMouseButton.kCGMouseButtonLeft;
      case MouseButton.right:
        return cg.CGMouseButton.kCGMouseButtonRight;
      case MouseButton.middle:
        return cg.CGMouseButton.kCGMouseButtonCenter;
    }
  }
}