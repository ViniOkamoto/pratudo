import 'package:flutter/material.dart';

class PageBaseStructurePage extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final MainAxisAlignment mainAxisAlignment;

  PageBaseStructurePage({
    required this.children,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
