import 'package:aldoro/ui/lists/horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final verticalListProvider = NotifierProvider.autoDispose
    .family<VerticalListNotifier, List<Widget>, String>(
      VerticalListNotifier.new,
    );

class VerticalListNotifier extends Notifier<List<Widget>> {
  final String id;

  VerticalListNotifier(this.id);

  @override
  List<Widget> build() => [];
}

class VerticalList extends StatelessWidget {
  const VerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemExtent: 120.0,
      itemBuilder: (context, index) {
        return const HorizontalList();
      },
    );
  }
}
