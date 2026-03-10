import 'package:flutter/services.dart';

class KeyEvents {
  static final keyboard = HardwareKeyboard.instance;

  static bool get select =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.enter) ||
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.numpadEnter) ||
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.select);

  static bool get escape =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.escape) ||
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.backspace);
  //      ||
  // keyboard.isLogicalKeyPressed(LogicalKeyboardKey.goBack);

  static bool get space =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.space);

  static bool get down =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.arrowDown);

  static bool get up =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.arrowUp);

  static bool get left =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.arrowLeft);

  static bool get right =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.arrowRight);

  static bool get seekLeft =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.mediaFastForward);
  static bool get seekRight =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.mediaStepBackward);
  static bool get playPause =>
      keyboard.isLogicalKeyPressed(LogicalKeyboardKey.mediaPlayPause);

  static bool isSelect(LogicalKeyboardKey key) => [
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.numpadEnter,
    LogicalKeyboardKey.select,
  ].contains(key);

  static bool isLeft(LogicalKeyboardKey key) =>
      key == LogicalKeyboardKey.arrowLeft;

  static bool isRight(LogicalKeyboardKey key) =>
      key == LogicalKeyboardKey.arrowRight;

  static bool isUp(LogicalKeyboardKey key) => key == LogicalKeyboardKey.arrowUp;

  static bool isDown(LogicalKeyboardKey key) =>
      key == LogicalKeyboardKey.arrowDown;
}
