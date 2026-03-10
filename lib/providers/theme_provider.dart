import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'storage_provider.dart';

/// контроллер темы оформления
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  () => ThemeNotifier(),
);

class ThemeNotifier extends Notifier<ThemeMode> {
  /// ключ в хранилище
  static const prefsKey = 'theme';

  @override
  ThemeMode build() {
    final storage = ref.read(storageProvider);

    /// считываем значение с диска
    final themeMode = storage.read(prefsKey);

    changeByString(themeMode);

    return state;
  }

  void changeTheme(ThemeMode themeMode) {
    final storage = ref.read(storageProvider);

    /// сохраняем значение на диск
    storage.write(prefsKey, themeMode.toString());

    state = themeMode;
  }

  void changeByString(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return changeTheme(ThemeMode.light);
      case 'ThemeMode.dark':
        return changeTheme(ThemeMode.dark);
      case 'ThemeMode.system':
      default:
        return changeTheme(ThemeMode.system);
    }
  }
}
