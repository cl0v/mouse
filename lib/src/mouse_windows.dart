part of 'mouse_base.dart';

Point<double> _getPositionWindows() {
  final lpPoint = calloc<POINT>();
  final result = GetCursorPos(lpPoint);
  final ret = Point(lpPoint.ref.x.toDouble(), lpPoint.ref.y.toDouble());
  free(lpPoint);

  if (result == 0) {
    _throwLastError();
  }
  return ret;
}

void _moveToWindows(Point<double> position) {
  final int screenWidth = GetSystemMetrics(SYSTEM_METRICS_INDEX.SM_CXSCREEN);
  final int screenHeight = GetSystemMetrics(SYSTEM_METRICS_INDEX.SM_CYSCREEN);

  final int normalizedX = (position.x * 65535) ~/ screenWidth;
  final int normalizedY = (position.y * 65535) ~/ screenHeight;

  final moveInput = calloc<INPUT>();
  moveInput.ref.type = INPUT_TYPE.INPUT_MOUSE;
  moveInput.ref.mi.dx = normalizedX;
  moveInput.ref.mi.dy = normalizedY;
  moveInput.ref.mi.mouseData = 0;
  moveInput.ref.mi.dwFlags = MOUSE_EVENT_FLAGS.MOUSEEVENTF_MOVE |
      MOUSE_EVENT_FLAGS.MOUSEEVENTF_ABSOLUTE;
  moveInput.ref.mi.time = 0;
  moveInput.ref.mi.dwExtraInfo = 0;

  final result = SendInput(1, moveInput, sizeOf<INPUT>());
  free(moveInput);

  if (result == 0) {
    _throwLastError();
  }
}

void _clickWindows() {
  _mouseDownWindows(MouseButton.left);
  _mouseUpWindows(MouseButton.left);
}

void _rightClickWindows() {
  _mouseDownWindows(MouseButton.right);
  _mouseUpWindows(MouseButton.right);
}

void _mouseDownWindows(MouseButton button) {
  final downInput = calloc<INPUT>();
  downInput.ref.type = INPUT_TYPE.INPUT_MOUSE;
  downInput.ref.mi.dx = 0;
  downInput.ref.mi.dy = 0;
  downInput.ref.mi.mouseData = 0;
  downInput.ref.mi.dwFlags = button.downFlags;
  downInput.ref.mi.time = 0;
  downInput.ref.mi.dwExtraInfo = 0;

  final result = SendInput(1, downInput, sizeOf<INPUT>());
  free(downInput);

  if (result == 0) {
    _throwLastError();
  }
}

void _mouseUpWindows(MouseButton button) {
  final upInput = calloc<INPUT>();
  upInput.ref.type = INPUT_TYPE.INPUT_MOUSE;
  upInput.ref.mi.dx = 0;
  upInput.ref.mi.dy = 0;
  upInput.ref.mi.mouseData = 0;
  upInput.ref.mi.dwFlags = button.upFlags;
  upInput.ref.mi.time = 0;
  upInput.ref.mi.dwExtraInfo = 0;

  final result = SendInput(1, upInput, sizeOf<INPUT>());
  free(upInput);

  if (result == 0) {
    _throwLastError();
  }
}

void _scrollWindows({int deltaX = 0, int deltaY = 0}) {
  if (deltaY != 0) {
    final input = calloc<INPUT>();
    input.ref.type = INPUT_TYPE.INPUT_MOUSE;
    input.ref.mi.dx = 0;
    input.ref.mi.dy = 0;
    input.ref.mi.mouseData = deltaY;
    input.ref.mi.dwFlags = MOUSE_EVENT_FLAGS.MOUSEEVENTF_WHEEL;
    input.ref.mi.time = 0;
    input.ref.mi.dwExtraInfo = 0;

    final result = SendInput(1, input, sizeOf<INPUT>());
    free(input);
    if (result == 0) {
      _throwLastError();
    }
  }
  if (deltaX != 0) {
    final input = calloc<INPUT>();
    input.ref.type = INPUT_TYPE.INPUT_MOUSE;
    input.ref.mi.dx = 0;
    input.ref.mi.dy = 0;
    input.ref.mi.mouseData = deltaX;
    input.ref.mi.dwFlags = MOUSE_EVENT_FLAGS.MOUSEEVENTF_HWHEEL;
    input.ref.mi.time = 0;
    input.ref.mi.dwExtraInfo = 0;

    final result = SendInput(1, input, sizeOf<INPUT>());
    free(input);
    if (result == 0) {
      _throwLastError();
    }
  }
}

Never _throwLastError() {
  final errorCode = GetLastError();
  final buffer = calloc.allocate<Utf16>(1024);
  final result = FormatMessage(
    FORMAT_MESSAGE_OPTIONS.FORMAT_MESSAGE_ALLOCATE_BUFFER |
        FORMAT_MESSAGE_OPTIONS.FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_OPTIONS.FORMAT_MESSAGE_IGNORE_INSERTS,
    nullptr,
    errorCode,
    0,
    buffer,
    1024,
    nullptr,
  );
  final message = buffer.toDartString();
  free(buffer);
  if (result == 0) {
    throw Exception('Windows error ($errorCode)');
  }
  throw Exception('Windows error ($errorCode): $message');
}

extension _MouseButtonMouseEventFlags on MouseButton {
  int get downFlags {
    switch (this) {
      case MouseButton.left:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTDOWN;
      case MouseButton.right:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTDOWN;
      case MouseButton.middle:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEDOWN;
    }
  }

  int get upFlags {
    switch (this) {
      case MouseButton.left:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_LEFTUP;
      case MouseButton.right:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_RIGHTUP;
      case MouseButton.middle:
        return MOUSE_EVENT_FLAGS.MOUSEEVENTF_MIDDLEUP;
    }
  }
}
