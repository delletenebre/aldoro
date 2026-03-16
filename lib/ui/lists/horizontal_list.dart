import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../keyboard/dpad.dart';
import 'horizontal_list_controller.dart';
import 'list_state.dart';

class HorizontalList extends HookConsumerWidget {
  final FocusNode? focusNode;
  final Widget Function(int index, FocusNode focusNode) builder;
  final ListParams params;

  const HorizontalList({
    super.key,
    this.focusNode,
    required this.builder,
    required this.params,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(horizontalListProvider(params));
    final listController = ref.read(horizontalListProvider(params).notifier);

    final isFocused = useState(false);

    return Dpad(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        print('HorizontalList onFocusChange: $hasFocus');
        isFocused.value = hasFocus;
        if (hasFocus) {
          //requestLastFocused();
        }
      },
      onLeft: listController.goPrevious,
      onRight: listController.goNext,
      child: Container(
        color: isFocused.value ? Colors.blue.withOpacity(0.1) : Colors.red,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: params.padding),
          controller: listController.scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: listState.itemCount,
          itemExtent: params.itemExtent + params.spacing,
          itemBuilder: (context, index) {
            return Padding(
              padding: .only(
                right: (index == listState.itemCount - 1)
                    ? 0.0
                    : params.spacing,
              ),
              child: builder(index, listController.focusNodes[index]),
            );
          },
        ),
      ),
    );
  }
}
