import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/home_page.dart';
import '../pages/navigation_layout.dart';
import 'auth_provider.dart';
import 'storage_provider.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final servicesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'services');
final requestsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'requests');
final otherNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'other');

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: RouteRefreshListenable(ref),
    redirect: (context, state) {
      /// текущий маршрут приложения
      final location = state.uri.path.toString();

      /// контроллер авторизации
      final account = ref.read(authProvider);

      if (account.value != null) {
        /// ^ если пользователь авторизован
        if (location.startsWith('/signin')) {
          return '/';
        }
      } else {
        /// ^ если пользователь НЕ авторизован
      }

      return null;
    },
    // errorBuilder: (context, state) => const ErrorPage(),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationLayout(navigationShell: navigationShell);
        },
        branches: [
          /// Главная
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => const HomePage(),
                routes: [],
              ),
            ],
          ),
        ],
      ),

      /// страница авторизации
      // GoRoute(
      //   path: '/sign_in',
      //   name: 'sign_in',
      //   builder: (context, state) {
      //     return const SignInPage();
      //   },
      // ),
    ],
  ),
);

class RouteRefreshListenable extends Listenable {
  VoidCallback? _listener;

  RouteRefreshListenable(Ref ref) {
    ref.listen(authProvider, (previous, next) {
      _listener?.call();
    });
  }

  @override
  void addListener(VoidCallback listener) {
    _listener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _listener = null;
  }
}
