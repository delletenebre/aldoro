import 'package:flutter/material.dart';

class AppTheme {
  static final successColor = Colors.green.shade100;
  static final onSuccessColor = Colors.green.shade900;

  /// тип прокрутки содержимого
  static const scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  /// стиль [FilledButton] для кнопок удаления
  static ButtonStyle dangerButtonStyleOf(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton.styleFrom(
      foregroundColor: theme.colorScheme.onError,
      backgroundColor: theme.colorScheme.error,
    );
  }

  static ButtonStyle get filledButtonStyleDanger => FilledButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xffEB4245),
  );

  static ButtonStyle get dangerElevatedButtonStyle => ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xffEB4245),
  );

  /// главный цвет в соответствии с Material You
  static const seedColor = Color(0xff0070ff);

  /// базовая тема оформления
  static final _baseThemeLight = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Golos UI',

    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      primaryContainer: Color(0xffffffff),
    ).copyWith(primary: seedColor),

    /// Define FadeUpwardsPageTransitionsBuilder as the default transition on
    /// iOS also. But again this will break the swipe back gesture on iOS
    /// убирает ненужную тень в macOS между станицами
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      },
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(12.0)),
        padding: .symmetric(vertical: 13.0, horizontal: 29.0),
        textStyle: TextStyle(fontSize: 16.0, fontWeight: .w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(12.0)),
        padding: .symmetric(vertical: 13.0, horizontal: 29.0),
        textStyle: TextStyle(fontSize: 16.0, fontWeight: .w500),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: .circular(16.0)),
        padding: .symmetric(vertical: 13.0, horizontal: 29.0),
        textStyle: TextStyle(fontSize: 16.0, fontWeight: .w500),
      ),
    ),
  );

  // /// светлая тема оформления
  // static final light = _baseThemeLight.copyWith(
  //   brightness: Brightness.light,

  //   filledButtonTheme: FilledButtonThemeData(
  //     style: _baseThemeLight.filledButtonTheme.style?.copyWith(
  //       foregroundColor: WidgetStateProperty.resolveWith((state) {
  //         return _baseThemeLight.colorScheme.primary;
  //       }),
  //     ),
  //   ),

  //   appBarTheme: _baseThemeLight.appBarTheme.copyWith(
  //     titleTextStyle: TextStyle(
  //       fontSize: 16.0,
  //       color: _baseThemeLight.colorScheme.onSurface,
  //     ),
  //   ),

  //   bottomAppBarTheme: BottomAppBarThemeData(color: Color(0xff141936)),
  //   navigationBarTheme: NavigationBarThemeData(
  //     backgroundColor: Color(0xff141936),
  //     indicatorColor: Colors.transparent,

  //     labelTextStyle: WidgetStateTextStyle.resolveWith((state) {
  //       return TextStyle(
  //         color: state.contains(WidgetState.selected)
  //             ? _baseThemeLight.colorScheme.surface
  //             : _baseThemeLight.colorScheme.outline,
  //         fontSize: 12.0,
  //       );
  //     }),

  //     iconTheme: WidgetStateProperty.resolveWith((state) {
  //       return IconThemeData(
  //         color: state.contains(WidgetState.selected)
  //             ? _baseThemeLight.colorScheme.surface
  //             : _baseThemeLight.colorScheme.outline,
  //       );
  //     }),
  //   ),
  // );

  /// тёмная тема оформления
  static final dark = _baseThemeLight.copyWith(brightness: Brightness.dark);
}
