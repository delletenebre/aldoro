import 'package:flutter/material.dart';

import '../ui/lists/vertical_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: VerticalList())]);
  }
}
