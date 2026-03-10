import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'list_cards/list_card.dart';

final horizontalListProvider = NotifierProvider.autoDispose
    .family<HorizontalListNotifier, List<Widget>, String>(
      HorizontalListNotifier.new,
    );

class HorizontalListNotifier extends Notifier<List<Widget>> {
  final String id;

  HorizontalListNotifier(this.id);

  @override
  List<Widget> build() => [];
}

class HorizontalList extends StatelessWidget {
  final Size itemSize;

  const HorizontalList({super.key, this.itemSize = const Size(196.0, 110.0)});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemExtent: itemSize.width,
      itemBuilder: (context, index) {
        return ListCard();
      },
    );
  }
}
