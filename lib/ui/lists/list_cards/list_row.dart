import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  final Widget title;
  final double height;
  final Widget child;

  const ListRow({
    super.key,
    required this.title,
    this.height = 0.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const titleHeight = 28.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: titleHeight,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: title,
          ),
        ),

        SizedBox(height: height - titleHeight, child: child),
      ],
    );
  }
}
