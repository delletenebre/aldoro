import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'key_events.dart';

class Dpad extends HookWidget {
  final FocusNode? focusNode;
  // final bool? skipTraversal;
  // final bool? descendantsAreTraversable;
  final void Function(bool)? onFocusChange;
  final KeyEventResult Function()? onLeft;
  final KeyEventResult Function()? onRight;
  final KeyEventResult Function()? onUp;
  final KeyEventResult Function()? onDown;
  final KeyEventResult Function()? onSelect;
  final KeyEventResult Function()? onLongPressed;
  final KeyEventResult Function()? onBack;
  final Widget child;

  const Dpad({
    super.key,
    this.focusNode,
    // this.skipTraversal,
    // this.descendantsAreTraversable,
    this.onFocusChange,
    this.onLeft,
    this.onRight,
    this.onUp,
    this.onDown,
    this.onSelect,
    this.onLongPressed,
    this.onBack,
    required this.child,
  });

  @override
  Widget build(context) {
    final isPressed = useState(false);
    final pressedAt = useRef(0);

    return Focus(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      // skipTraversal: skipTraversal,
      // descendantsAreTraversable: descendantsAreTraversable,
      onKeyEvent: (node, event) {
        bool pressed = isPressed.value;
        if ([
          LogicalKeyboardKey.enter,
          LogicalKeyboardKey.select,
        ].contains(event.logicalKey)) {
          pressed = [KeyRepeatEvent, KeyDownEvent].contains(event.runtimeType);

          switch (event.runtimeType) {
            case const (KeyDownEvent):
              pressedAt.value = DateTime.now().millisecondsSinceEpoch;
              break;
            case const (KeyRepeatEvent):
              if (pressedAt.value > 0 &&
                  DateTime.now().millisecondsSinceEpoch - pressedAt.value >
                      750) {
                onLongPressed?.call();
                pressedAt.value = 0;
              }
              break;
            case const (KeyUpEvent):
              if (pressedAt.value > 0) {
                onSelect?.call();
              }
              pressedAt.value = 0;

              break;
          }
        }

        /// обновляем состояние
        isPressed.value = pressed;

        final callbacks = {
          KeyEvents.left: onLeft,
          KeyEvents.right: onRight,
          KeyEvents.up: onUp,
          KeyEvents.down: onDown,
          KeyEvents.select: onSelect,
          KeyEvents.escape: onBack,
        };

        for (final entry in callbacks.entries) {
          if (entry.key) {
            return entry.value?.call() ?? KeyEventResult.ignored;
          }
        }

        return KeyEventResult.skipRemainingHandlers;
      },
      // onKeyEvent: (node, event) {
      //   final callbacks = {
      //     KeyEvents.left: onLeft,
      //     KeyEvents.right: onRight,
      //     KeyEvents.up: onUp,
      //     KeyEvents.down: onDown,
      //     KeyEvents.select: onSelect,
      //     KeyEvents.escape: onBack,
      //   };

      //   for (final entry in callbacks.entries) {
      //     if (entry.key) {
      //       return entry.value?.call() ?? KeyEventResult.ignored;
      //     }
      //   }

      //   return KeyEventResult.ignored;
      // },
      child: child,
    );
  }
}
