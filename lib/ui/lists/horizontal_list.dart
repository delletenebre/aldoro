import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../keyboard/dpad.dart';
import 'horizontal_list_controller.dart';
import 'list_state.dart';

class HorizontalList extends ConsumerWidget {
  final FocusNode? focusNode;
  final Widget Function(int index) builder;
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

    return Dpad(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        print('HorizontalList onFocusChange: $hasFocus');
        if (hasFocus) {
          //requestLastFocused();
        }
      },
      onLeft: listController.goPrevious,
      onRight: listController.goNext,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listState.itemCount,
        itemExtent: params.itemExtent,
        itemBuilder: (context, index) {
          return Focus(
            focusNode: listState.focusNodes[index],
            child: builder(index),
          );
        },
      ),
    );
  }
}
