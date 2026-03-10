import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
