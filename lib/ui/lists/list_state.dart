import 'package:flutter/widgets.dart';

class ListState {
  final int selectedItemIndex;
  final int itemCount;

  ListState({this.selectedItemIndex = 0, this.itemCount = 0});

  ListState copyWith({int? selectedItemIndex, int? itemCount}) {
    return ListState(
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;

    return other is ListState &&
        other.selectedItemIndex == selectedItemIndex &&
        other.itemCount == itemCount;
  }

  @override
  int get hashCode => selectedItemIndex.hashCode ^ itemCount.hashCode;
}

class ListParams {
  final String id;
  final double itemExtent;
  final double spacing;
  final double padding;

  const ListParams({
    required this.id,
    required this.itemExtent,
    this.spacing = 20.0,
    this.padding = 24.0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListParams &&
        other.id == id &&
        other.itemExtent == itemExtent &&
        other.spacing == spacing &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(id, itemExtent, spacing, padding);
}
