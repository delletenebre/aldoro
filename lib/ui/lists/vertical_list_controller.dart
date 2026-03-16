import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'list_state.dart';

final verticalListProvider = NotifierProvider.autoDispose
    .family<VerticalListNotifier, ListState, ListParams>(
      VerticalListNotifier.new,
    );

class VerticalListNotifier<T> extends Notifier<ListState> {
  final ListParams params;
  final scrollController = ScrollController();
  final _focusNodes = <FocusNode>[];

  VerticalListNotifier(this.params);

  @override
  ListState build() {
    ref.onDispose(() {
      scrollController.dispose();
      for (final node in _focusNodes) {
        node.dispose();
      }
    });

    return ListState(selectedItemIndex: 0, itemCount: 0, focusNodes: _focusNodes);
  }

  /// смещение для прокрутки к выбранному элементу
  double get _scrollOffset {
    final itemWidth = params.itemExtent;
    final spacing = params.spacing;

    return state.selectedItemIndex * (itemWidth + spacing);
  }

  /// индекс последнего элемента в списке
  int get _lastIndex => state.itemCount - 1;

  /// запрос фокуса на выбранном элементе списка
  void requestCurrentFocus() {
    state.focusNodes[state.selectedItemIndex].children.firstOrNull
        ?.requestFocus();
  }

  void addItems(List<T> items) {
    final newNodes = List.generate(items.length, (_) => FocusNode());
    _focusNodes.addAll(newNodes);

    state = state.copyWith(
      itemCount: state.itemCount + items.length,
      focusNodes: List.of(_focusNodes),
    );
  }

  void animateToCurrent() {
    final position = _scrollOffset;
    //_animationComplete = false;
    print(_scrollOffset);

    scrollController.position
        .moveTo(
          position,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        )
        .then((value) {
          //_animationComplete = true;
        });

    final focusableItem =
        state.focusNodes[state.selectedItemIndex].children.firstOrNull;
    print('focusableItem: $focusableItem');

    // if (focusableItem == null) {
    //   if (direction == Direction.previous) {
    //     goPrevious();
    //   }
    //   if (direction == Direction.next) {
    //     goNext();
    //   }
    // } else {
    focusableItem?.requestFocus();
    // }
  }

  /// переходим к предыдущему элементу
  KeyEventResult goPrevious() {
    if (state.selectedItemIndex > 0) {
      state = state.copyWith(selectedItemIndex: state.selectedItemIndex - 1);
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      // if (widget.onMoveUp == null) {
      //   FocusScope.of(context).focusInDirection(TraversalDirection.up);
      // } else {
      //   widget.onMoveUp?.call();
      // }
      // return widget.onMoveUp != null
      //     ? KeyEventResult.handled
      //     : KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  /// переходим к следующему элементу
  KeyEventResult goNext() {
    debugPrint('goNext');
    if (state.selectedItemIndex < state.itemCount - 1) {
      state = state.copyWith(selectedItemIndex: state.selectedItemIndex + 1);
      animateToCurrent();
      return KeyEventResult.handled;
    } else {
      // if (widget.onMoveDown == null) {
      //   FocusScope.of(context).focusInDirection(TraversalDirection.down);
      // } else {
      //   widget.onMoveDown?.call();
      // }
      // return widget.onMoveDown != null
      //     ? KeyEventResult.handled
      //     : KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }
}
