# Changelog

All notable changes to the AWEH Shell package will be documented in this file.

## [0.1.0] - 2026-02-17

### Added
- Initial release of aweh_shell package
- `AwehShell` - Main application shell with menu bar and tab management
- `TabShellController` - Centralized tab state management
- `ModuleWorkspace` - Complete module layout wrapper
- `AwehToolbar` - Reusable toolbar widget with consistent styling
- `AwehHeaderSection` - Custom header area for module content
- `AwehInternalSidebar` - Resizable and collapsible sidebar widget
- `AwehBottomToolbar` - Status bar for totals and statistics
- Models: `ToolbarItem`, `InternalSidebarConfig`, `BottomToolbarItem`, `ModuleConfig`
- Comprehensive documentation and usage examples

### Features
- Tab state management with add/activate/close operations
- Modular composition pattern (no rigid templates)
- Consistent UI/UX across all modules
- Resizable sidebars with drag handles
- Collapsible sidebar support
- Auto-styled toolbar buttons (elevated first, outlined rest)
- Special delete button styling (red text/icon)
- Loading and disabled states for toolbar items
- Error state handling in ModuleWorkspace
- Responsive layouts
