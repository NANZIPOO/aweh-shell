import 'package:flutter/material.dart';

import '../models/bottom_toolbar_item.dart';

class AwehBottomToolbar extends StatelessWidget {
  final List<BottomToolbarItem> items;
  final Color? backgroundColor;
  final EdgeInsets padding;

  const AwehBottomToolbar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildItem(context, items[i]),
            if (i < items.length - 1) const SizedBox(width: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, BottomToolbarItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${item.label}: ',
          style:
              item.textStyle ??
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        Text(
          item.value,
          style:
              item.textStyle ??
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
