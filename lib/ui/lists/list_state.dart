import 'package:flutter/widgets.dart';

class ListState {
  final int selectedItemIndex;
  final int itemCount;
  final List<FocusNode> focusNodes;

  ListState({
    this.selectedItemIndex = 0,
    this.itemCount = 0,
    this.focusNodes = const [],
  });

  ListState copyWith({
    int? selectedItemIndex,
    int? itemCount,
    List<FocusNode>? focusNodes,
  }) {
    return ListState(
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      itemCount: itemCount ?? this.itemCount,
      focusNodes: focusNodes ?? this.focusNodes,
    );
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;

    return other is ListState &&
        other.selectedItemIndex == selectedItemIndex &&
        other.itemCount == itemCount &&
        identical(other.focusNodes, focusNodes);
  }

  @override
  int get hashCode =>
      selectedItemIndex.hashCode ^ itemCount.hashCode ^ focusNodes.hashCode;
}

class ListParams {
  final String id;
  final double itemExtent;
  final double spacing;

  const ListParams({
    required this.id,
    required this.itemExtent,
    this.spacing = 24.0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListParams &&
        other.id == id &&
        other.itemExtent == itemExtent &&
        other.spacing == spacing;
  }

  @override
  int get hashCode => Object.hash(id, itemExtent, spacing);
}
