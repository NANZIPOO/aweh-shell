import 'package:flutter/material.dart';

import '../models/toolbar_item.dart';

class AwehToolbar extends StatelessWidget {
  final List<ToolbarItem> items;
  final EdgeInsets padding;

  const AwehToolbar({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    // Sort items by sortOrder if provided
    final sortedItems = List<ToolbarItem>.from(items);
    sortedItems.sort((a, b) {
      final aOrder = a.sortOrder ?? 999;
      final bOrder = b.sortOrder ?? 999;
      return aOrder.compareTo(bOrder);
    });

    return Padding(
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < sortedItems.length; i++) ...[
            _buildToolbarButton(context, sortedItems[i]),
            if (i < sortedItems.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildToolbarButton(BuildContext context, ToolbarItem item) {
    // First item gets elevated style, rest are outlined
    final isFirst = items.indexOf(item) == 0 || item.sortOrder == 0;

    if (item.isLoading) {
      return OutlinedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        label: Text(item.label),
      );
    }

    if (isFirst) {
      return ElevatedButton.icon(
        onPressed: item.isEnabled ? item.onPressed : null,
        icon: Icon(item.icon),
        label: Text(item.label),
      );
    }

    return OutlinedButton.icon(
      onPressed: item.isEnabled ? item.onPressed : null,
      icon: Icon(item.icon, color: item.id == 'delete' ? Colors.red : null),
      label: Text(
        item.label,
        style: TextStyle(color: item.id == 'delete' ? Colors.red : null),
      ),
    );
  }
}
