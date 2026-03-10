import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  /// ожидаем инициализации модуля взаимодействия с нативным кодом
  WidgetsFlutterBinding.ensureInitialized();

  // /// инициализируем локальное хранилище
  // final sharedStorage = await SharedPreferences.getInstance();

  // /// инициализируем защищённое хранилище
  // const secureStorage = FlutterSecureStorage();

  runApp(
    ProviderScope(
      retry: null,
      overrides: [
        // storageProvider.overrideWithValue(
        //   Storage(sharedStorage: sharedStorage, secureStorage: secureStorage),
        // ),
      ],
      child: const App(),
    ),
  );
}
