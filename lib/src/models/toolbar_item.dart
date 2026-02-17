import 'package:flutter/material.dart';

class ToolbarItem {
  final String id;
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final int? sortOrder;

  const ToolbarItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.sortOrder,
  });
}
