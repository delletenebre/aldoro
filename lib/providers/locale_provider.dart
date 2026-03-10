import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import 'storage_provider.dart';

/// контроллер языка приложения
final localeProvider = NotifierProvider<LocaleNotifier, String>(
  () => LocaleNotifier(),
);

class LocaleNotifier extends Notifier<String> {
  /// ключ в хранилище
  static const prefsKey = 'locale';

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  /// список поддерживаемых языков
  static final locales = {'ky': 'Кыргызча', 'ru': 'Русский', 'en': 'English'};

  /// язык по умолчанию
  static String get defaultLocale {
    return 'ru';
    // final systemLocale = Intl.systemLocale.substring(0, 2);

    // /// Проверяем есть ли в списке системный язык...
    // if (locales.containsKey(systemLocale)) {
    //   /// ...если есть - возвращаем системный
    //   return systemLocale;
    // } else {
    //   /// ...если нет - возвращаем первый из поддерживаемых
    //   return locales.keys.first;
    // }
  }

  @override
  String build() {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// считываем значение с диска
    final locale = storage.read(prefsKey, defaultValue: defaultLocale);

    return locale;
  }

  Future<void> changeLocale(String locale) async {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// обновляем локализацию для формата дат и прочего
    Intl.defaultLocale = locale;

    /// сохраняем значение на диск
    storage.write(prefsKey, locale);

    state = locale;
  }
}
