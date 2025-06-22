import 'dart:ffi' as ffi;

/// Bindings for CoreGraphics.
class CoreGraphics {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  CoreGraphics(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  CGEventRef CGEventCreateMouseEvent(
    CGEventSourceRef source,
    CGEventType mouseType,
    CGPoint mouseCursorPosition,
    CGMouseButton mouseButton,
  ) {
    return _CGEventCreateMouseEvent(
      source,
      mouseType.value,
      mouseCursorPosition,
      mouseButton.value,
    );
  }

  late final _CGEventCreateMouseEventPtr = _lookup<
      ffi.NativeFunction<
          CGEventRef Function(CGEventSourceRef, ffi.Uint32, CGPoint,
              ffi.Uint32)>>('CGEventCreateMouseEvent');
  late final _CGEventCreateMouseEvent = _CGEventCreateMouseEventPtr.asFunction<
      CGEventRef Function(CGEventSourceRef, int, CGPoint, int)>();

  void CGEventPost(
    CGEventTapLocation tap,
    CGEventRef event,
  ) {
    return _CGEventPost(
      tap.value,
      event,
    );
  }

  late final _CGEventPostPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Uint32, CGEventRef)>>(
          'CGEventPost');
  late final _CGEventPost =
      _CGEventPostPtr.asFunction<void Function(int, CGEventRef)>();

  void CFRelease(
    CFTypeRef cf,
  ) {
    return _CFRelease(
      cf,
    );
  }

  late final _CFReleasePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(CFTypeRef)>>('CFRelease');
  late final _CFRelease = _CFReleasePtr.asFunction<void Function(CFTypeRef)>();

  CGError CGDisplayMoveCursorToPoint(
    DartCGDirectDisplayID display,
    CGPoint point,
  ) {
    return CGError.fromValue(_CGDisplayMoveCursorToPoint(
      display,
      point,
    ));
  }

  late final _CGDisplayMoveCursorToPointPtr = _lookup<
          ffi.NativeFunction<ffi.Int32 Function(CGDirectDisplayID, CGPoint)>>(
      'CGDisplayMoveCursorToPoint');
  late final _CGDisplayMoveCursorToPoint =
      _CGDisplayMoveCursorToPointPtr.asFunction<int Function(int, CGPoint)>();

  CGEventRef CGEventCreate(
    CGEventSourceRef source,
  ) {
    return _CGEventCreate(
      source,
    );
  }

  late final _CGEventCreatePtr =
      _lookup<ffi.NativeFunction<CGEventRef Function(CGEventSourceRef)>>(
          'CGEventCreate');
  late final _CGEventCreate =
      _CGEventCreatePtr.asFunction<CGEventRef Function(CGEventSourceRef)>();

  CGPoint CGEventGetLocation(
    CGEventRef event,
  ) {
    return _CGEventGetLocation(
      event,
    );
  }

  late final _CGEventGetLocationPtr =
      _lookup<ffi.NativeFunction<CGPoint Function(CGEventRef)>>(
          'CGEventGetLocation');
  late final _CGEventGetLocation =
      _CGEventGetLocationPtr.asFunction<CGPoint Function(CGEventRef)>();

  CGEventRef CGEventCreateScrollWheelEvent(
    CGEventSourceRef source,
    CGScrollEventUnit units,
    int wheelCount,
    int wheel1,
    int wheel2,
  ) {
    return _CGEventCreateScrollWheelEvent(
      source,
      units.value,
      wheelCount,
      wheel1,
      wheel2,
    );
  }

  late final _CGEventCreateScrollWheelEventPtr = _lookup<
      ffi.NativeFunction<
          CGEventRef Function(CGEventSourceRef, ffi.Uint32, ffi.Int32, ffi.Int32,
              ffi.Int32)>>('CGEventCreateScrollWheelEvent');
  late final _CGEventCreateScrollWheelEvent =
      _CGEventCreateScrollWheelEventPtr.asFunction<
          CGEventRef Function(CGEventSourceRef, int, int, int, int)>();
}

typedef CGDirectDisplayID = ffi.Uint32;
typedef DartCGDirectDisplayID = int;

final class __CGEventSource extends ffi.Opaque {}

typedef CGEventSourceRef = ffi.Pointer<__CGEventSource>;

typedef CFTypeRef = ffi.Pointer<ffi.Void>;

final class __CGEvent extends ffi.Opaque {}

typedef CGEventRef = ffi.Pointer<__CGEvent>;

typedef CGFloat = ffi.Double;

final class CGPoint extends ffi.Struct {
  @CGFloat()
  external double x;

  @CGFloat()
  external double y;
}

enum CGError {
  kCGErrorSuccess(0),
  kCGErrorFailure(1000),
  kCGErrorIllegalArgument(1001),
  kCGErrorInvalidConnection(1002),
  kCGErrorInvalidContext(1003),
  kCGErrorCannotComplete(1004),
  kCGErrorNotImplemented(1006),
  kCGErrorRangeCheck(1007),
  kCGErrorTypeCheck(1008),
  kCGErrorInvalidOperation(1010),
  kCGErrorNoneAvailable(1011);

  final int value;
  const CGError(this.value);

  static CGError fromValue(int value) => switch (value) {
        0 => kCGErrorSuccess,
        1000 => kCGErrorFailure,
        1001 => kCGErrorIllegalArgument,
        1002 => kCGErrorInvalidConnection,
        1003 => kCGErrorInvalidContext,
        1004 => kCGErrorCannotComplete,
        1006 => kCGErrorNotImplemented,
        1007 => kCGErrorRangeCheck,
        1008 => kCGErrorTypeCheck,
        1010 => kCGErrorInvalidOperation,
        1011 => kCGErrorNoneAvailable,
        _ => throw ArgumentError('Unknown value for CGError: $value'),
      };
}

enum CGEventType {
  kCGEventNull(0),
  kCGEventLeftMouseDown(1),
  kCGEventLeftMouseUp(2),
  kCGEventRightMouseDown(3),
  kCGEventRightMouseUp(4),
  kCGEventMouseMoved(5),
  kCGEventLeftMouseDragged(6),
  kCGEventRightMouseDragged(7),
  kCGEventKeyDown(10),
  kCGEventKeyUp(11),
  kCGEventFlagsChanged(12),
  kCGEventScrollWheel(22),
  kCGEventTabletPointer(23),
  kCGEventTabletProximity(24),
  kCGEventOtherMouseDown(25),
  kCGEventOtherMouseUp(26),
  kCGEventOtherMouseDragged(27),
  kCGEventTapDisabledByTimeout(-2),
  kCGEventTapDisabledByUserInput(-1);

  final int value;
  const CGEventType(this.value);

  static CGEventType fromValue(int value) => switch (value) {
        0 => kCGEventNull,
        1 => kCGEventLeftMouseDown,
        2 => kCGEventLeftMouseUp,
        3 => kCGEventRightMouseDown,
        4 => kCGEventRightMouseUp,
        5 => kCGEventMouseMoved,
        6 => kCGEventLeftMouseDragged,
        7 => kCGEventRightMouseDragged,
        10 => kCGEventKeyDown,
        11 => kCGEventKeyUp,
        12 => kCGEventFlagsChanged,
        22 => kCGEventScrollWheel,
        23 => kCGEventTabletPointer,
        24 => kCGEventTabletProximity,
        25 => kCGEventOtherMouseDown,
        26 => kCGEventOtherMouseUp,
        27 => kCGEventOtherMouseDragged,
        -2 => kCGEventTapDisabledByTimeout,
        -1 => kCGEventTapDisabledByUserInput,
        _ => throw ArgumentError('Unknown value for CGEventType: $value'),
      };
}

enum CGMouseButton {
  kCGMouseButtonLeft(0),
  kCGMouseButtonRight(1),
  kCGMouseButtonCenter(2);

  final int value;
  const CGMouseButton(this.value);

  static CGMouseButton fromValue(int value) => switch (value) {
        0 => kCGMouseButtonLeft,
        1 => kCGMouseButtonRight,
        2 => kCGMouseButtonCenter,
        _ => throw ArgumentError('Unknown value for CGMouseButton: $value'),
      };
}

enum CGEventTapLocation {
  kCGHIDEventTap(0),
  kCGSessionEventTap(1),
  kCGAnnotatedSessionEventTap(2);

  final int value;
  const CGEventTapLocation(this.value);

  static CGEventTapLocation fromValue(int value) => switch (value) {
        0 => kCGHIDEventTap,
        1 => kCGSessionEventTap,
        2 => kCGAnnotatedSessionEventTap,
        _ =>
      throw ArgumentError('Unknown value for CGEventTapLocation: $value'),
      };
}

enum CGScrollEventUnit {
  kCGScrollEventUnitPixel(0),
  kCGScrollEventUnitLine(1);

  final int value;
  const CGScrollEventUnit(this.value);

  static CGScrollEventUnit fromValue(int value) => switch (value) {
        0 => kCGScrollEventUnitPixel,
        1 => kCGScrollEventUnitLine,
        _ => throw ArgumentError('Unknown value for CGScrollEventUnit: $value'),
      };
}
