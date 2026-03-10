import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: navigationShell);
  }
}
