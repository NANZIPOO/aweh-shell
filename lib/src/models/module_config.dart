import 'package:flutter/material.dart';

import 'bottom_toolbar_item.dart';
import 'context_panel_config.dart';
import 'internal_sidebar_config.dart';
import 'module_tab.dart';
import 'toolbar_item.dart';

/// ModuleConfig defines how a module should be rendered in the workspace.
/// Uses builder pattern for maximum flexibility and composition.
class ModuleConfig {
  /// Unique module identifier
  final String moduleId;
  
  /// Display name for the module
  final String moduleName;
  
  /// Main content builder (required)
  final Widget Function(BuildContext context) contentBuilder;
  
  /// Optional toolbar items (New, Edit, Delete, etc.)
  final List<ToolbarItem>? toolbarItems;
  
  /// Optional header section builder
  final Widget Function(BuildContext context)? headerBuilder;
  
  /// Optional internal sidebar builder
  final Widget Function(BuildContext context)? sidebarBuilder;
  
  /// Optional bottom toolbar builder
  final Widget Function(BuildContext context)? bottomBuilder;
  
  /// Optional context panel configuration
  final ContextPanelConfig? contextPanel;
  
  /// Optional module tabs
  final List<ModuleTab>? moduleTabs;
  
  /// Optional custom theme
  final ThemeData? customTheme;
  
  /// Optional layout constraints
  final double? minWidth;
  final double? preferredWidth;
  
  /// Metadata for module-specific data
  final Map<String, dynamic>? metadata;

  const ModuleConfig({
    required this.moduleId,
    required this.moduleName,
    required this.contentBuilder,
    this.toolbarItems,
    this.headerBuilder,
    this.sidebarBuilder,
    this.bottomBuilder,
    this.contextPanel,
    this.moduleTabs,
    this.customTheme,
    this.minWidth,
    this.preferredWidth,
    this.metadata,
  });
}
