import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../ui/lists/aldoro_lists.dart';

final itemsProvider = AsyncNotifierProvider.autoDispose
    .family<ItemsNotifier, List<int>, ListParams>(ItemsNotifier.new);

class ItemsNotifier<T> extends AsyncNotifier<List<int>> {
  final ListParams params;

  ItemsNotifier(this.params);

  @override
  Future<List<int>> build() async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(horizontalListProvider(params).notifier).addItems([
      1,
      2,
      3,
      4,
      5,
      6,
    ]);
    return [];
  }
}

class FuturedItemsRowView extends HookConsumerWidget {
  final FocusNode? focusNode;
  const FuturedItemsRowView({super.key, this.focusNode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listParams = ListParams(
      id: 'futured_items_row',
      itemExtent: 196.0,
      spacing: 12.0,
    );

    ref.watch(itemsProvider(listParams));

    return HorizontalList(
      focusNode: focusNode,

      params: listParams,
      builder: (index, focusNode) => ListCard(focusNode: focusNode),
    );
  }
}
