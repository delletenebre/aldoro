import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/locale_provider.dart';
import '../../ui/lists/aldoro_lists.dart';
import '../../ui/lists/list_cards/list_row.dart';
import 'ui/new_item_row_view.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = LocaleNotifier.of(context);

    const listParams = ListParams(id: 'vertical_list', itemExtent: 96.0);
    final listController = ref.read(verticalListProvider(listParams).notifier);

    useEffect(() {
      // Имитируем загрузку данных и добавляем элементы в список
      WidgetsBinding.instance.addPostFrameCallback((_) {
        listController.addItems([1]);
      });

      return null;
    }, []);

    return Column(
      children: [
        Expanded(
          child: VerticalList(
            params: listParams,
            builder: (index, focusNode) {
              return NewItemsRowView();
            },
          ),
        ),
      ],
    );
  }
}
