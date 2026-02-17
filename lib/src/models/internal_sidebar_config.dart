import 'package:flutter/material.dart';

class InternalSidebarConfig {
  final Widget child;
  final double width;
  final bool collapsible;
  final bool resizable;
  final double minWidth;
  final double maxWidth;

  const InternalSidebarConfig({
    required this.child,
    this.width = 240,
    this.collapsible = true,
    this.resizable = true,
    this.minWidth = 180,
    this.maxWidth = 420,
  });
}
