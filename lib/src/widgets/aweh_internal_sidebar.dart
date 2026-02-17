import 'package:flutter/material.dart';

import '../models/internal_sidebar_config.dart';

class AwehInternalSidebar extends StatefulWidget {
  final InternalSidebarConfig config;
  final Widget mainContent;

  const AwehInternalSidebar({
    super.key,
    required this.config,
    required this.mainContent,
  });

  @override
  State<AwehInternalSidebar> createState() => _AwehInternalSidebarState();
}

class _AwehInternalSidebarState extends State<AwehInternalSidebar> {
  late double _sidebarWidth;
  bool _isCollapsed = false;
  bool _isResizing = false;

  @override
  void initState() {
    super.initState();
    _sidebarWidth = widget.config.width;
  }

  void _toggleCollapse() {
    if (!widget.config.collapsible) return;
    setState(() => _isCollapsed = !_isCollapsed);
  }

  void _onResizeStart(DragStartDetails details) {
    if (!widget.config.resizable) return;
    setState(() => _isResizing = true);
  }

  void _onResizeUpdate(DragUpdateDetails details) {
    if (!widget.config.resizable) return;
    setState(() {
      _sidebarWidth = (_sidebarWidth + details.delta.dx).clamp(
        widget.config.minWidth,
        widget.config.maxWidth,
      );
    });
  }

  void _onResizeEnd(DragEndDetails details) {
    if (!widget.config.resizable) return;
    setState(() => _isResizing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isCollapsed ? 0 : _sidebarWidth,
          child: _isCollapsed
              ? null
              : Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: widget.config.child,
                ),
        ),

        // Resize Handle
        if (widget.config.resizable && !_isCollapsed)
          GestureDetector(
            onHorizontalDragStart: _onResizeStart,
            onHorizontalDragUpdate: _onResizeUpdate,
            onHorizontalDragEnd: _onResizeEnd,
            child: MouseRegion(
              cursor: SystemMouseCursors.resizeColumn,
              child: Container(
                width: 4,
                color: _isResizing
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Colors.transparent,
              ),
            ),
          ),

        // Main Content
        Expanded(child: widget.mainContent),

        // Collapse/Expand Button
        if (widget.config.collapsible)
          Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey.shade300)),
            ),
            child: IconButton(
              icon: Icon(
                _isCollapsed ? Icons.chevron_right : Icons.chevron_left,
                size: 16,
              ),
              onPressed: _toggleCollapse,
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
            ),
          ),
      ],
    );
  }
}
