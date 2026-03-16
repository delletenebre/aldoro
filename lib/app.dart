import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/locale_provider.dart';
import 'providers/router_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';
import 'resources/app_theme.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(context, ref) {
    // final device = ref.read(deviceProvider);

    /// контроллер языка приложения
    final locale = ref.watch(localeProvider);

    /// контроллер темы оформления
    final themeMode = ref.watch(themeProvider);

    /// контроллер маршрутов приложения
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(locale),
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
    );
  }
}
