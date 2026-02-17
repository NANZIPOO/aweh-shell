# AWEH Shell - Modular Architecture

## ✅ Core Principles Implemented

### 1. **Composition Over Rigidity** ✅
- No rigid templates that force layout structure
- Modules compose their own UI from pluggable components
- Three levels of flexibility for different needs

### 2. **Everything is Modular** ✅
- Individual widgets work standalone (AwehToolbar, AwehHeaderSection, etc.)
- Widgets can be composed manually or via configuration
- No forced dependencies between components

### 3. **Injectable Components** ✅
- Toolbar items
- Header sections
- Sidebars
- Bottom toolbars
- All optional - use only what you need

### 4. **Builder Pattern** ✅
- `ModuleConfig` uses builders for dynamic composition
- `Widget Function(BuildContext)` for content, header, sidebar, bottom
- Supports stateful and stateless content

### 5. **Modules Control Their UI** ✅
- Module defines what appears
- Module controls layout order (via direct usage)
- Module injects functionality via callbacks

---

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                    Level 1: Direct Usage                     │
│              (Maximum Control - Manual Composition)          │
│  ┌───────────┐  ┌──────────────┐  ┌─────────────────────┐  │
│  │AwehToolbar│  │AwehHeaderSect│  │AwehInternalSidebar  │  │
│  └───────────┘  └──────────────┘  └─────────────────────┘  │
│  ┌────────────────┐  ┌──────────────────────────────────┐  │
│  │AwehBottomToolba│  │  Your Custom Layout Composition  │  │
│  └────────────────┘  └──────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│             Level 2: ModuleConfig + Workspace                │
│          (Flexible - Builder Pattern Composition)            │
│  ┌────────────────────────────────────────────────────────┐ │
│  │              ModuleConfig                               │ │
│  │  - contentBuilder: (context) => Widget                 │ │
│  │  - headerBuilder: (context) => Widget                  │ │
│  │  - sidebarBuilder: (context) => Widget                 │ │
│  │  - bottomBuilder: (context) => Widget                  │ │
│  │  - toolbarItems: List<ToolbarItem>                     │ │
│  └────────────────────────────────────────────────────────┘ │
│                            ↓                                 │
│  ┌────────────────────────────────────────────────────────┐ │
│  │         Workspace (Renders from Config)                 │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│            Level 3: ModuleWorkspace                          │
│         (Convenience - Quick Setup Wrapper)                  │
│  ┌────────────────────────────────────────────────────────┐ │
│  │      ModuleWorkspace (Simple Parameters)                │ │
│  │  - content: Widget                                      │ │
│  │  - toolbarItems: List<ToolbarItem>                      │ │
│  │  - headerWidgets: List<Widget>                          │ │
│  │  - bottomToolbarItems: List<BottomToolbarItem>          │ │
│  │  (internally creates ModuleConfig + uses Workspace)     │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

---

## Component Modularity

### Individual Widgets (Level 1)
Each widget is **fully independent** and can be used standalone:

| Widget | Purpose | Dependencies |
|--------|---------|--------------|
| `AwehToolbar` | Renders toolbar buttons | `List<ToolbarItem>` |
| `AwehHeaderSection` | Custom header area | `List<Widget>` |
| `AwehInternalSidebar` | Resizable sidebar | `InternalSidebarConfig` |
| `AwehBottomToolbar` | Status/totals bar | `List<BottomToolbarItem>` |
| `AwehShell` | App shell with tabs | `TabShellController` |

**Modularity:** ✅ Each works independently, no forced coupling

### Configuration-Based (Level 2)
Compose via **builders** for flexibility:

```dart
ModuleConfig(
  moduleId: 'example',
  moduleName: 'Example',
  contentBuilder: (context) => YourContent(),  // Required
  headerBuilder: (context) => YourHeader(),    // Optional
  sidebarBuilder: (context) => YourSidebar(),  // Optional
  bottomBuilder: (context) => YourBottom(),    // Optional
  toolbarItems: [...],                          // Optional
)
```

**Modularity:** ✅ Builders enable dynamic composition, no rigid structure

### Convenience Wrapper (Level 3)
Quick setup for **common patterns**:

```dart
ModuleWorkspace(
  content: YourGrid(),
  toolbarItems: [...],
  // Internally creates ModuleConfig and uses Workspace
)
```

**Modularity:** ✅ Wrapper for convenience, doesn't limit Level 1 or 2

---

## Real-World Module Patterns

### Pattern 1: Simple Grid (Users, Products, Orders)
**Use:** Level 3 (ModuleWorkspace)
```dart
ModuleWorkspace(
  moduleTitle: 'Users',
  toolbarItems: [New, Edit, Delete],
  content: AwehGrid(...),
)
```

### Pattern 2: Form with Header (PO Details)
**Use:** Level 2 (ModuleConfig)
```dart
ModuleConfig(
  headerBuilder: (context) => OrderHeader(),
  contentBuilder: (context) => OrderForm(),
  toolbarItems: [Save, PDF],
  bottomBuilder: (context) => TotalsBar(),
)
```

### Pattern 3: Complex Custom Layout
**Use:** Level 1 (Direct)
```dart
Column(
  children: [
    CustomHeader(),
    Row(
      children: [
        AwehToolbar(...),
        Expanded(child: CustomLayout()),
      ],
    ),
  ],
)
```

### Pattern 4: Sidebar Navigation (Sales Menu)
**Use:** Level 2 (ModuleConfig)
```dart
ModuleConfig(
  sidebarBuilder: (context) => MenuGroupList(),
  contentBuilder: (context) => SalesGrid(),
  toolbarItems: [...],
)
```

---

## Module Independence Checklist

- ✅ Modules don't depend on shell structure
- ✅ Modules define their own toolbar buttons
- ✅ Modules inject their own header content
- ✅ Modules add sidebars when needed
- ✅ Modules control bottom bar visibility
- ✅ Widgets work standalone without shell
- ✅ No rigid templates forcing layout order
- ✅ Builder pattern enables dynamic composition
- ✅ Three levels for different complexity needs

---

## Benefits Achieved

| Benefit | How It's Achieved |
|---------|-------------------|
| **Modularity** | Each widget standalone, no forced coupling |
| **Flexibility** | Three usage levels from simple to complex |
| **Composition** | Builder pattern + manual composition |
| **No Templates** | No rigid layout structures enforced |
| **Reusability** | Widgets work across different modules |
| **Maintainability** | Change one widget without touching others |
| **Scalability** | Add new modules without modifying shell |
| **Developer Choice** | Pick the level that fits your needs |

---

## Migration Path

### Existing Screen → Three Options:

**Option A: Keep it simple (Level 3)**
```dart
// Before: Manual layout
Scaffold(body: Column([toolbar, content]))

// After: Wrapper
ModuleWorkspace(toolbarItems: [...], content: content)
```

**Option B: Add flexibility (Level 2)**
```dart
// Use builders for dynamic composition
ModuleConfig(
  contentBuilder: (context) => buildContent(context),
  toolbarItems: buildToolbar(),
)
```

**Option C: Full control (Level 1)**
```dart
// Compose manually
Column([
  AwehToolbar(...),
  CustomLayout(),
])
```

---

## Summary

✅ **Modular:** Every component is independent  
✅ **Composable:** Three levels of composition  
✅ **Flexible:** No rigid templates  
✅ **Injectable:** Modules control their UI  
✅ **Builder-based:** Dynamic composition support  
✅ **Choice:** Pick the level you need  

**The shell is a toolbox, not a template.**
