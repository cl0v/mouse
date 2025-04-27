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
  final button = MouseButton.left;
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseDown,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseUp,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
}

void _rightClickMacos() {
  final button = MouseButton.right;
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseDown,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseUp,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
}

void _mouseDownMacos(MouseButton button) {
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseDown,
    _primitiveGetPositionMacos(),
    button.cgMouseButton,
  );
}

void _mouseUpMacos(MouseButton button) {
  _primitiveMouseEventMacos(
    button.cgEventTypeMouseUp,
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

  cg.CGEventType get cgEventTypeMouseDown {
    switch (this) {
      case MouseButton.left:
        return cg.CGEventType.kCGEventLeftMouseDown;
      case MouseButton.right:
        return cg.CGEventType.kCGEventRightMouseDown;
      case MouseButton.middle:
        return cg.CGEventType.kCGEventOtherMouseDown;
    }
  }

  cg.CGEventType get cgEventTypeMouseUp {
    switch (this) {
      case MouseButton.left:
        return cg.CGEventType.kCGEventLeftMouseUp;
      case MouseButton.right:
        return cg.CGEventType.kCGEventRightMouseUp;
      case MouseButton.middle:
        return cg.CGEventType.kCGEventOtherMouseUp;
    }
  }

  // TODO: Implement mouse dragged event
  // cg.CGEventType get cgEventTypeMouseDragged {
  //   switch (this) {
  //     case MouseButton.left:
  //       return cg.CGEventType.kCGEventLeftMouseDragged;
  //     case MouseButton.right:
  //       return cg.CGEventType.kCGEventRightMouseDragged;
  //     case MouseButton.middle:
  //       return cg.CGEventType.kCGEventOtherMouseDragged;
  //   }
  // }
}
