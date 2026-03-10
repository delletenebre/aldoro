import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'storage_provider.dart';

/// контроллер формата даты и времени
final dateFormatProvider = NotifierProvider<DateFormatNotifier, bool>(
  () => DateFormatNotifier(),
);

class DateFormatNotifier extends Notifier<bool> {
  /// ключ в хранилище
  static const prefsKey = 'is_human_date_format';

  @override
  bool build() {
    final storage = ref.read(storageProvider);

    /// считываем значение с диска
    return storage.readBool(prefsKey);
  }

  void update(bool value) {
    final storage = ref.read(storageProvider);

    /// сохраняем значение на диск
    storage.write(prefsKey, value);

    state = value;
  }
}
