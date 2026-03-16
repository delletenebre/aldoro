import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../keyboard/dpad.dart';
import 'list_state.dart';
import 'vertical_list_controller.dart';

class VerticalList extends ConsumerWidget {
  final ListParams params;
  final Widget Function(int index, FocusNode hasFocus) builder;

  const VerticalList({super.key, required this.params, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(verticalListProvider(params));
    final listController = ref.read(verticalListProvider(params).notifier);

    return Dpad(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          listController.requestCurrentFocus();
        }
      },
      onUp: listController.goPrevious,
      onDown: listController.goNext,
      child: ListView.builder(
        controller: listController.scrollController,
        scrollDirection: Axis.vertical,
        itemCount: listState.itemCount,
        itemExtent: params.itemExtent + params.spacing,
        itemBuilder: (context, index) {
          return Padding(
            padding: .only(bottom: params.spacing),
            child: builder(index, listController.focusNodes[index]),
          );
        },
      ),
    );
  }
}
