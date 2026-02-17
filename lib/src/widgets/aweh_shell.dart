import 'package:flutter/material.dart';

import '../controllers/tab_shell_controller.dart';

class AwehShell extends StatefulWidget {
  final Widget child;
  final TabShellController? tabController;
  final List<Map<String, String>> tabs;
  final int activeTabIndex;
  final ValueChanged<int>? onTabTap;
  final ValueChanged<int>? onTabClose;
  final Widget? statusIndicator;
  final List<String> menuItems;

  const AwehShell({
    super.key,
    required this.child,
    this.tabController,
    this.tabs = const [],
    this.activeTabIndex = 0,
    this.onTabTap,
    this.onTabClose,
    this.statusIndicator,
    this.menuItems = const ['File', 'Edit', 'Reports', 'Settings', 'Help'],
  });

  @override
  State<AwehShell> createState() => _AwehShellState();
}

class _AwehShellState extends State<AwehShell> {
  late List<Map<String, String>> _tabs;
  late int _activeTabIndex;

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs;
    _activeTabIndex = widget.activeTabIndex;
  }

  @override
  void didUpdateWidget(AwehShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabController == null) {
      _tabs = widget.tabs;
      _activeTabIndex = widget.activeTabIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabController != null) {
      return AnimatedBuilder(
        animation: widget.tabController!,
        builder: (context, _) {
          return _buildShell(
            context,
            tabs: widget.tabController!.tabs,
            activeIndex: widget.tabController!.activeTabIndex,
            useController: true,
          );
        },
      );
    }

    return _buildShell(
      context,
      tabs: _tabs,
      activeIndex: _activeTabIndex,
      useController: false,
    );
  }

  Widget _buildShell(
    BuildContext context, {
    required List<Map<String, String>> tabs,
    required int activeIndex,
    required bool useController,
  }) {
    return Scaffold(
      body: Column(
        children: [
          _buildMenuBar(),
          _buildTabBar(
            context,
            tabs: tabs,
            activeIndex: activeIndex,
            useController: useController,
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  Widget _buildMenuBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              for (final item in widget.menuItems) ...[
                _buildMenuButton(item),
                const SizedBox(width: 12),
              ],
            ],
          ),
          if (widget.statusIndicator != null) widget.statusIndicator!,
        ],
      ),
    );
  }

  Widget _buildTabBar(
    BuildContext context, {
    required List<Map<String, String>> tabs,
    required int activeIndex,
    required bool useController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var i = 0; i < tabs.length; i++)
                _buildTab(
                  context,
                  tabs[i]['name'] ?? '',
                  i == activeIndex,
                  onTap: () => _handleTabTap(i, useController: useController),
                  onClose:
                      (widget.onTabClose != null ||
                          (useController && widget.tabController != null))
                      ? () => _handleTabClose(i, useController: useController)
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTabTap(int index, {required bool useController}) {
    if (widget.onTabTap != null) {
      widget.onTabTap!(index);
      if (!useController) {
        setState(() => _activeTabIndex = index);
      }
      return;
    }

    if (useController && widget.tabController != null) {
      widget.tabController!.activateTab(index);
      return;
    }

    setState(() => _activeTabIndex = index);
  }

  void _handleTabClose(int index, {required bool useController}) {
    if (widget.onTabClose != null) {
      widget.onTabClose!(index);
      return;
    }

    if (useController && widget.tabController != null) {
      widget.tabController!.closeTab(index);
    }
  }

  Widget _buildMenuButton(String label) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String label,
    bool isActive, {
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.black,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                if (onClose != null) const SizedBox(width: 6),
                if (onClose != null)
                  GestureDetector(
                    onTap: onClose,
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: isActive ? Colors.white : Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
