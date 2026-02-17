import 'package:flutter/material.dart';

class BottomToolbarItem {
  final String label;
  final String value;
  final TextStyle? textStyle;

  const BottomToolbarItem({
    required this.label,
    required this.value,
    this.textStyle,
  });
}
