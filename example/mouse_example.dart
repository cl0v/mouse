import 'dart:async';

import 'package:mouse/mouse.dart';

void main() {
  Timer.periodic(const Duration(milliseconds: 100), (timer) {
    final position = getPosition();
    print('Current mouse position: $position');
  });
}
