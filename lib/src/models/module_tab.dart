import 'package:flutter/material.dart';

class ModuleTab {
  final String id;
  final String title;
  final Widget content;
  final IconData? icon;

  const ModuleTab({
    required this.id,
    required this.title,
    required this.content,
    this.icon,
  });
}
