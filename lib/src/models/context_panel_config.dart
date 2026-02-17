import 'package:flutter/material.dart';

class ContextPanelConfig {
  final double widthFraction;
  final Widget content;
  final bool resizable;

  const ContextPanelConfig({
    required this.content,
    this.widthFraction = 0.4,
    this.resizable = true,
  });
}
