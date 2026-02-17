import 'package:flutter/material.dart';

import '../models/module_config.dart';
import 'aweh_toolbar.dart';

/// Workspace renders a module based on its ModuleConfig.
/// This provides flexible composition - modules control their own layout.
class Workspace extends StatelessWidget {
  final ModuleConfig config;
  final bool isLoading;
  final String? errorMessage;

  const Workspace({
    super.key,
    required this.config,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Error state
    if (errorMessage != null && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Loading state
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Build layout from config
    return Column(
      children: [
        // Optional: Toolbar
        if (config.toolbarItems != null && config.toolbarItems!.isNotEmpty)
          AwehToolbar(items: config.toolbarItems!),

        // Optional: Header section
        if (config.headerBuilder != null) config.headerBuilder!(context),

        // Main content area (with optional sidebar)
        Expanded(
          child: _buildContentArea(context),
        ),

        // Optional: Bottom toolbar
        if (config.bottomBuilder != null) config.bottomBuilder!(context),
      ],
    );
  }

  Widget _buildContentArea(BuildContext context) {
    // If sidebar provided, create split layout
    if (config.sidebarBuilder != null) {
      return Row(
        children: [
          // Sidebar
          config.sidebarBuilder!(context),
          
          // Main content
          Expanded(
            child: config.contentBuilder(context),
          ),
        ],
      );
    }

    // Just content
    return config.contentBuilder(context);
  }
}
