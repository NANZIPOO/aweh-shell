# AWEH Shell Package

Modular UI framework for consistent application layout across AWEH POS modules.

## Core Principle: Composition Over Rigidity

**Everything is modular, pluggable, and composable.**

Modules control their own UI. No rigid templates. Three levels of flexibility:

1. **Direct Widget Usage** - Maximum control (compose manually)
2. **ModuleConfig + Workspace** - Flexible composition (use builders)
3. **ModuleWorkspace** - Convenience wrapper (quick setup)

## Three Levels of Usage

### Level 1: Direct Widget Usage (Maximum Control)

Compose layout manually using individual widgets:

```dart
Column(
  children: [
    AwehToolbar(
      items: [
        ToolbarItem(id: 'new', label: 'New', icon: Icons.add, onPressed: _add),
        ToolbarItem(id: 'delete', label: 'Delete', icon: Icons.delete, onPressed: _del),
      ],
    ),
    Expanded(child: MyCustomLayout()),
    AwehBottomToolbar(
      items: [
        BottomToolbarItem(label: 'Total', value: '1,250'),
      ],
    ),
  ],
)
```

**Use when:** You need complete layout control or custom composition.

### Level 2: ModuleConfig + Workspace (Flexible Composition)

Define module structure via configuration and builders:

```dart
final config = ModuleConfig(
  moduleId: 'users',
  moduleName: 'Employees',
  
  // Main content builder
  contentBuilder: (context) => AwehGrid(...),
  
  // Optional: Toolbar
  toolbarItems: [
    ToolbarItem(id: 'new', label: 'New', icon: Icons.add, onPressed: _add),
    ToolbarItem(id: 'edit', label: 'Edit', icon: Icons.edit, onPressed: _edit),
  ],
  
  // Optional: Header
  headerBuilder: (context) => CustomHeader(),
  
  // Optional: Sidebar
  sidebarBuilder: (context) => FilterSidebar(),
  
  // Optional: Bottom toolbar
  bottomBuilder: (context) => AwehBottomToolbar(
    items: [BottomToolbarItem(label: 'Total', value: '100')],
  ),
);

// Render with Workspace
Workspace(config: config)
```

**Use when:** You want flexibility with builder pattern for dynamic composition.

### Level 3: ModuleWorkspace (Convenience Wrapper)

Quick setup for simple modules:

```dart
ModuleWorkspace(
  moduleTitle: 'Employees',
  toolbarItems: [
    ToolbarItem(id: 'new', label: 'New', icon: Icons.add, onPressed: _add),
  ],
  content: AwehGrid(...),
  bottomToolbarItems: [
    BottomToolbarItem(label: 'Total', value: '100'),
  ],
)
```

**Use when:** You need quick setup without custom composition.

## Components

### 1. AwehShell
Main application shell with menu bar and tab management.

```dart
AwehShell(
  tabController: _tabController,
  statusIndicator: Icon(Icons.circle, color: Colors.green),
  child: content,
)
```

### 2. TabShellController
Manages tab state (add, activate, close).

```dart
final controller = TabShellController();

// Add or activate tab
controller.addOrActivateTab(
  route: '/users',
  name: 'Users/Employees',
);

// Close tab
controller.closeTab(0);

// Listen to changes
controller.addListener(() {
  print('Active tab: ${controller.activeTabIndex}');
});
```

### 3. ModuleWorkspace
Complete module layout with toolbar, header, content, sidebar, and bottom bar.

```dart
ModuleWorkspace(
  moduleTitle: 'Employee Management',
  toolbarItems: [
    ToolbarItem(
      id: 'new',
      label: 'New',
      icon: Icons.add,
      onPressed: _handleNew,
    ),
  ],
  content: YourContentWidget(),
  bottomToolbarItems: [
    BottomToolbarItem(label: 'Total', value: '1,250'),
  ],
)
```

### 4. AwehToolbar
Standalone toolbar widget.

```dart
AwehToolbar(
  items: [
    ToolbarItem(
      id: 'save',
      label: 'Save',
      icon: Icons.save,
      onPressed: _handleSave,
      isEnabled: true,
      isLoading: false,
      sortOrder: 0,
    ),
  ],
)
```

### 5. AwehHeaderSection
Custom header area for forms, filters, etc.

```dart
AwehHeaderSection(
  children: [
    SupplierPickerWidget(),
    OrderDateWidget(),
    StatusBadge(),
  ],
)
```

### 6. AwehInternalSidebar
Resizable sidebar for navigation or filters.

```dart
AwehInternalSidebar(
  config: InternalSidebarConfig(
    child: NavigationTree(),
    width: 240,
    resizable: true,
    collapsible: true,
    minWidth: 180,
    maxWidth: 420,
  ),
  mainContent: YourMainContent(),
)
```

### 7. AwehBottomToolbar
Bottom status bar for totals and stats.

```dart
AwehBottomToolbar(
  items: [
    BottomToolbarItem(label: 'Total Lines', value: '5'),
    BottomToolbarItem(label: 'Total Amount', value: '\$1,250.00'),
  ],
)
```

## Models

### ToolbarItem
```dart
ToolbarItem(
  id: 'unique_id',
  label: 'Button Label',
  icon: Icons.add,
  onPressed: () {},
  isEnabled: true,
  isLoading: false,
  sortOrder: 0,
)
```

### InternalSidebarConfig
```dart
InternalSidebarConfig(
  child: Widget,
  width: 240,
  resizable: true,
  collapsible: true,
  minWidth: 180,
  maxWidth: 420,
)
```

### BottomToolbarItem
```dart
BottomToolbarItem(
  label: 'Label',
  value: 'Display Value',
  textStyle: TextStyle(...),
)
```

## Usage Example

### Simple Module (Grid with Toolbar)
```dart
class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWorkspace(
      moduleTitle: 'Users',
      toolbarItems: [
        ToolbarItem(id: 'new', label: 'New', icon: Icons.add, onPressed: _handleNew),
        ToolbarItem(id: 'edit', label: 'Edit', icon: Icons.edit, onPressed: _handleEdit),
        ToolbarItem(id: 'delete', label: 'Delete', icon: Icons.delete, onPressed: _handleDelete),
      ],
      content: AwehGrid(...),
    );
  }
}
```

### Complex Module (Header + Sidebar + Bottom)
```dart
class PurchaseOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWorkspace(
      headerWidgets: [
        SupplierPicker(),
        OrderDateField(),
        StatusBadge(),
      ],
      toolbarItems: [
        ToolbarItem(id: 'save', label: 'Save', icon: Icons.save, onPressed: _save),
        ToolbarItem(id: 'pdf', label: 'PDF', icon: Icons.picture_as_pdf, onPressed: _generatePDF),
      ],
      internalSidebar: InternalSidebarConfig(
        child: OrderItemsList(),
        width: 300,
      ),
      content: OrderDetailsForm(),
      bottomToolbarItems: [
        BottomToolbarItem(label: 'Total Lines', value: '12'),
        BottomToolbarItem(label: 'Total', value: '\$5,420.00'),
      ],
    );
  }
}
```

## Benefits

- **Consistency**: All modules look and feel the same
- **Reduced Boilerplate**: 60% less UI code per screen
- **Maintainability**: UI changes in one place
- **Modular**: Use only what you need
- **Flexible**: Compose components as needed

## Migration Guide

### Before (Manual Layout)
```dart
Scaffold(
  body: Column(
    children: [
      // Manual toolbar
      Row(
        children: [
          ElevatedButton.icon(...),
          OutlinedButton.icon(...),
        ],
      ),
      Expanded(child: content),
    ],
  ),
)
```

### After (Shell Pattern)
```dart
ModuleWorkspace(
  toolbarItems: [
    ToolbarItem(...),
    ToolbarItem(...),
  ],
  content: content,
)
```

## Version

0.1.0 - Initial release
