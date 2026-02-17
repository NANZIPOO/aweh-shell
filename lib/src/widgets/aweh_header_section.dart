import 'package:flutter/material.dart';

class AwehHeaderSection extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final Color? backgroundColor;

  const AwehHeaderSection({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}
