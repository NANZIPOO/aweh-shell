import 'package:flutter/material.dart';

import '../models/bottom_toolbar_item.dart';
import '../models/internal_sidebar_config.dart';
import '../models/module_config.dart';
import '../models/toolbar_item.dart';
import 'aweh_bottom_toolbar.dart';
import 'aweh_header_section.dart';
import 'aweh_internal_sidebar.dart';
import 'workspace.dart';

/// ModuleWorkspace is a convenience wrapper around Workspace.
/// For simple modules that don't need custom composition.
/// For advanced layouts, use Workspace directly with ModuleConfig.
class ModuleWorkspace extends StatelessWidget {
  /// Main content widget (required)
  final Widget content;

  /// Toolbar items (New, Edit, Delete, etc.)
  final List<ToolbarItem>? toolbarItems;

  /// Custom header section widgets
  final List<Widget>? headerWidgets;

  /// Internal sidebar configuration (for navigation/filters)
  final InternalSidebarConfig? internalSidebar;

  /// Bottom toolbar items (totals, stats, etc.)
  final List<BottomToolbarItem>? bottomToolbarItems;

  /// Module title (displayed in header if provided)
  final String? moduleTitle;

  /// Whether to show loading state
  final bool isLoading;

  /// Error message to display
  final String? errorMessage;

  const ModuleWorkspace({
    super.key,
    required this.content,
    this.toolbarItems,
    this.headerWidgets,
    this.internalSidebar,
    this.bottomToolbarItems,
    this.moduleTitle,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Create ModuleConfig from simple parameters
    final config = ModuleConfig(
      moduleId: 'module',
      moduleName: moduleTitle ?? 'Module',
      
      // Content builder
      contentBuilder: (context) {
        Widget mainContent = content;
        
        // Wrap with internal sidebar if provided
        if (internalSidebar != null) {
          mainContent = AwehInternalSidebar(
            config: internalSidebar!,
            mainContent: mainContent,
          );
        }
        
        return mainContent;
      },
      
      // Toolbar items
      toolbarItems: toolbarItems,
      
      // Header builder
      headerBuilder: (headerWidgets != null && headerWidgets!.isNotEmpty)
          ? (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Module title if provided
                  if (moduleTitle != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            moduleTitle!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Custom header widgets
                  AwehHeaderSection(children: headerWidgets!),
                ],
              );
            }
          : (moduleTitle != null
              ? (context) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          moduleTitle!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
              : null),
      
      // Bottom toolbar builder
      bottomBuilder: (bottomToolbarItems != null &&
              bottomToolbarItems!.isNotEmpty)
          ? (context) => AwehBottomToolbar(items: bottomToolbarItems!)
          : null,
    );

    // Use Workspace to render
    return Workspace(
      config: config,
      isLoading: isLoading,
      errorMessage: errorMessage,
    );
  }
}
