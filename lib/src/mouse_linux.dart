part of 'mouse_base.dart';

const _soPaths = [
  '/usr/lib/aarch64-linux-gnu/libXtst.so',
  '/usr/lib/x86_64-linux-gnu/libXtst.so',
];

var _soPath = _findX11TestLibraryPath();

Point<double> _getPositionLinux() {
  final lib = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = lib.XOpenDisplay(nullptr);
  if (display == nullptr) {
    throw Exception('Faild to open display');
  }

  final root = lib.XDefaultRootWindow(display);
  final rootReturn = calloc<UnsignedLong>();
  final childReturn = calloc<UnsignedLong>();
  final rootXReturn = calloc<Int>();
  final rootYReturn = calloc<Int>();
  final winXReturn = calloc<Int>();
  final winYReturn = calloc<Int>();
  final maskReturn = calloc<UnsignedInt>();
  final result = lib.XQueryPointer(
    display,
    root,
    rootReturn,
    childReturn,
    rootXReturn,
    rootYReturn,
    winXReturn,
    winYReturn,
    maskReturn,
  );
  if (result != x11Test.True) {
    throw Exception('Mouse cursor not on default window');
  }
  print("root: ${rootXReturn.value}, ${rootYReturn.value}, win: ${winXReturn.value}, ${winYReturn.value}");
  final ret = Point(rootXReturn.value.toDouble(), rootYReturn.value.toDouble());

  free(rootReturn);
  free(childReturn);
  free(rootXReturn);
  free(rootYReturn);
  free(winXReturn);
  free(winYReturn);
  free(maskReturn);

  lib.XCloseDisplay(display);

  return ret;
}

void _moveToLinux(Point<double> position) {
  final lib = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = lib.XOpenDisplay(nullptr);
  if (display == nullptr) {
    throw Exception('Faild to open display');
  }

  final rootWindow = lib.XDefaultRootWindow(display);
  final rootX = position.x.toInt();
  final rootY = position.y.toInt();

  lib.XWarpPointer(
    display,
    x11Test.None,
    rootWindow,
    0,
    0,
    0,
    0,
    rootX,
    rootY,
  );
  lib.XFlush(display);

  lib.XCloseDisplay(display);
}

void _clickLinux() {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = libX11Tests.XOpenDisplay(nullptr);
  _primitiveMouseDownLinux(display, MouseButton.left.buttonNumber);
  _primitiveMouseUpLinux(display, MouseButton.left.buttonNumber);
  libX11Tests.XCloseDisplay(display);
}

void _rightClickLinux() {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = libX11Tests.XOpenDisplay(nullptr);
  _primitiveMouseDownLinux(display, MouseButton.right.buttonNumber);
  _primitiveMouseUpLinux(display, MouseButton.right.buttonNumber);
  libX11Tests.XCloseDisplay(display);
}

void _mouseDownLinux(MouseButton button) {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = libX11Tests.XOpenDisplay(nullptr);
  _primitiveMouseDownLinux(display, button.buttonNumber);
  libX11Tests.XCloseDisplay(display);
}

void _mouseUpLinux(MouseButton button) {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  final display = libX11Tests.XOpenDisplay(nullptr);
  _primitiveMouseUpLinux(display, button.buttonNumber);
  libX11Tests.XCloseDisplay(display);
}

void _primitiveMouseDownLinux(Pointer<x11Test.Display> display, int button) {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  libX11Tests.XTestFakeButtonEvent(
    display,
    button,
    x11Test.True,
    x11Test.CurrentTime,
  );
}

void _primitiveMouseUpLinux(Pointer<x11Test.Display> display, int button) {
  final libX11Tests = x11Test.X11ExtensionXTest(DynamicLibrary.open(_soPath));
  libX11Tests.XTestFakeButtonEvent(
    display,
    button,
    x11Test.False,
    x11Test.CurrentTime,
  );
}

String _findX11TestLibraryPath() {
  for (final soPath in _soPaths) {
    if (File(soPath).existsSync()) {
      return soPath;
    }
  }

  final result = Process.runSync('ldconfig', ['-p']);
  final lines = result.stdout.split('\n');
  for (final line in lines) {
    if (line.contains('libXtst.so')) {
      return line.split(' ')[1];
    }
  }
  throw Exception('libXtst.so not found');
}

extension _MouseButtonButtonNumber on MouseButton {
  int get buttonNumber {
    switch (this) {
      case MouseButton.left:
        return x11Test.Button1;
      case MouseButton.right:
        return x11Test.Button3;
      case MouseButton.middle:
        return x11Test.Button2;
    }
  }
}

