import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:motor/motor.dart';

class ListCard extends HookWidget {
  final FocusNode? focusNode;
  final Size size;

  const ListCard({
    super.key,
    this.focusNode,
    this.size = const Size(196.0, 110.0),
  });

  @override
  Widget build(BuildContext context) {
    final isFocused = useState(false);

    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        isFocused.value = hasFocus;
      },
      child: SingleMotionBuilder(
        value: isFocused.value ? 1.1 : 1.0,
        motion: const Motion.smoothSpring(),
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: isFocused.value
                ? Colors.green.shade600
                : Colors.green.shade200,
          ),
        ),
      ),
    );
  }
}
