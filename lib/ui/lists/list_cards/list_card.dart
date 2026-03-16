import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final Size size;

  const ListCard({super.key, this.size = const Size(196.0, 110.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.green.shade200,
      ),
    );
  }
}
