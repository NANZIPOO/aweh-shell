# AWEH Shell - Screen Implementation Guide

**Complete guide for implementing screens with toolbars, buttons, headers, sidebars, and bottom bars.**

---

## Quick Start Recipes

### Recipe 1: Simple Grid Screen (Products, Users, Orders)
**Use Case:** Grid with toolbar (New/Edit/Delete buttons)

```dart
import 'package:aweh_shell/aweh_shell.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWorkspace(
      moduleTitle: 'Employee Management',
      toolbarItems: [
        ToolbarItem(
          id: 'new',
          label: 'New',
          icon: Icons.add,
          onPressed: () => _handleNew(context),
          sortOrder: 1,
        ),
        ToolbarItem(
          id: 'edit',
          label: 'Edit',
          icon: Icons.edit,
          onPressed: () => _handleEdit(context),
          sortOrder: 2,
        ),
        ToolbarItem(
          id: 'delete',
          label: 'Delete',
          icon: Icons.delete,
          onPressed: () => _handleDelete(context),
          sortOrder: 3,
        ),
      ],
      content: AwehGrid(
        // Your grid configuration
      ),
    );
  }

  void _handleNew(BuildContext context) {
    // Handle new user
  }

  void _handleEdit(BuildContext context) {
    // Handle edit user
  }

  void _handleDelete(BuildContext context) {
    // Handle delete user
  }
}
```

**That's it!** Level 3 (ModuleWorkspace) gives you:
- ✅ Automatic toolbar rendering
- ✅ Button styling (first button elevated, rest outlined)
- ✅ Delete button auto-styled in red
- ✅ Module title displayed
- ✅ Content area for your grid

---

### Recipe 2: Form Screen with Header (Purchase Order Details)
**Use Case:** Form with header info and action buttons

```dart
import 'package:aweh_shell/aweh_shell.dart';

class PurchaseOrderDetailsScreen extends StatelessWidget {
  final String poId;

  PurchaseOrderDetailsScreen({required this.poId});

  @override
  Widget build(BuildContext context) {
    return ModuleWorkspace(
      moduleTitle: 'Purchase Order #$poId',
      toolbarItems: [
        ToolbarItem(
          id: 'save',
          label: 'Save',
          icon: Icons.save,
          onPressed: () => _handleSave(context),
          sortOrder: 1,
        ),
        ToolbarItem(
          id: 'submit',
          label: 'Submit',
          icon: Icons.send,
          onPressed: () => _handleSubmit(context),
          sortOrder: 2,
        ),
        ToolbarItem(
          id: 'pdf',
          label: 'Export PDF',
          icon: Icons.picture_as_pdf,
          onPressed: () => _handleExportPDF(context),
          sortOrder: 3,
        ),
      ],
      headerWidgets: [
        _buildPOHeader(),
      ],
      content: _buildPOForm(),
      bottomToolbarItems: [
        BottomToolbarItem(
          label: 'Subtotal',
          value: 'R 1,250.00',
        ),
        BottomToolbarItem(
          label: 'VAT (15%)',
          value: 'R 187.50',
        ),
        BottomToolbarItem(
          label: 'Total',
          value: 'R 1,437.50',
          textStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPOHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Supplier: ABC Suppliers', style: TextStyle(fontSize: 16)),
                SizedBox(height: 4),
                Text('Date: 2026-02-17', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Chip(
            label: Text('Draft'),
            backgroundColor: Colors.orange.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildPOForm() {
    return ListView(
      children: [
        // Your form fields here
      ],
    );
  }

  void _handleSave(BuildContext context) {
    // Save PO
  }

  void _handleSubmit(BuildContext context) {
    // Submit PO
  }

  void _handleExportPDF(BuildContext context) {
    // Export to PDF
  }
}
```

**You get:**
- ✅ Header section at top (supplier info, status chip)
- ✅ Toolbar with action buttons
- ✅ Form content area
- ✅ Bottom toolbar showing totals

---

### Recipe 3: Screen with Sidebar (Sales Menu)
**Use Case:** Grid with collapsible filter sidebar

```dart
import 'package:aweh_shell/aweh_shell.dart';

class SalesMenuScreen extends StatefulWidget {
  @override
  _SalesMenuScreenState createState() => _SalesMenuScreenState();
}

class _SalesMenuScreenState extends State<SalesMenuScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final config = ModuleConfig(
      moduleId: 'sales_menu',
      moduleName: 'Sales Menu',
      contentBuilder: (context) => AwehGrid(
        // Grid showing filtered items
      ),
      sidebarBuilder: (context) => _buildCategorySidebar(),
      toolbarItems: [
        ToolbarItem(
          id: 'add_to_order',
          label: 'Add to Order',
          icon: Icons.add_shopping_cart,
          onPressed: () => _handleAddToOrder(),
          sortOrder: 1,
        ),
      ],
      internalSidebarConfig: InternalSidebarConfig(
        width: 250,
        collapsible: true,
        resizable: true,
        minWidth: 200,
        maxWidth: 400,
      ),
    );

    return Workspace(config: config);
  }

  Widget _buildCategorySidebar() {
    return ListView(
      children: [
        ListTile(
          title: Text('All Items'),
          selected: selectedCategory == null,
          onTap: () => setState(() => selectedCategory = null),
        ),
        ListTile(
          title: Text('Beverages'),
          selected: selectedCategory == 'beverages',
          onTap: () => setState(() => selectedCategory = 'beverages'),
        ),
        ListTile(
          title: Text('Food'),
          selected: selectedCategory == 'food',
          onTap: () => setState(() => selectedCategory = 'food'),
        ),
        // More categories...
      ],
    );
  }

  void _handleAddToOrder() {
    // Add selected item to order
  }
}
```

**You get:**
- ✅ Resizable sidebar on the left
- ✅ Collapse/expand button
- ✅ Main content area with grid
- ✅ Toolbar with action button
- ✅ Sidebar state managed by component

---

## Component Deep Dive

### 1. Toolbar Buttons

#### Basic Button
```dart
ToolbarItem(
  id: 'save',           // Unique identifier
  label: 'Save',        // Button text
  icon: Icons.save,     // Icon
  onPressed: () {},     // Callback
  sortOrder: 1,         // Display order (optional)
)
```

#### Disabled Button
```dart
ToolbarItem(
  id: 'submit',
  label: 'Submit',
  icon: Icons.send,
  onPressed: () {},
  isEnabled: false,     // Grayed out, not clickable
)
```

#### Loading Button
```dart
ToolbarItem(
  id: 'save',
  label: 'Save',
  icon: Icons.save,
  onPressed: () {},
  isLoading: true,      // Shows circular progress indicator
)
```

#### Delete Button (Auto-styled in Red)
```dart
ToolbarItem(
  id: 'delete',         // ID contains 'delete'
  label: 'Delete',
  icon: Icons.delete,
  onPressed: () {},
  // Automatically styled with red color
)
```

#### Button Styling Rules
- **First button** (lowest sortOrder): Elevated button style
- **Other buttons**: Outlined button style
- **Delete buttons**: Red color regardless of position
- **Disabled**: Grayed out
- **Loading**: Shows spinner, disabled

---

### 2. Headers

#### Simple Text Header
```dart
headerWidgets: [
  Padding(
    padding: EdgeInsets.all(16),
    child: Text(
      'Order Details',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
]
```

#### Info Card Header
```dart
Widget _buildInfoHeader() {
  return Card(
    margin: EdgeInsets.all(8),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #12345', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Customer: John Doe'),
                Text('Date: 2026-02-17'),
              ],
            ),
          ),
          Chip(label: Text('Pending')),
        ],
      ),
    ),
  );
}

// Use in ModuleWorkspace
headerWidgets: [_buildInfoHeader()]
```

#### Filter Row Header
```dart
Widget _buildFilterHeader() {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => _handleSearch(value),
          ),
        ),
        SizedBox(width: 16),
        DropdownButton<String>(
          value: _selectedStatus,
          items: ['All', 'Active', 'Inactive'].map((status) {
            return DropdownMenuItem(value: status, child: Text(status));
          }).toList(),
          onChanged: (value) => setState(() => _selectedStatus = value),
        ),
      ],
    ),
  );
}

// Use in ModuleWorkspace
headerWidgets: [_buildFilterHeader()]
```

---

### 3. Bottom Toolbar (Totals/Stats)

#### Simple Stats
```dart
bottomToolbarItems: [
  BottomToolbarItem(label: 'Total Items', value: '125'),
  BottomToolbarItem(label: 'Selected', value: '3'),
]
```

#### Financial Totals
```dart
bottomToolbarItems: [
  BottomToolbarItem(
    label: 'Subtotal',
    value: 'R 1,250.00',
  ),
  BottomToolbarItem(
    label: 'VAT (15%)',
    value: 'R 187.50',
  ),
  BottomToolbarItem(
    label: 'Total',
    value: 'R 1,437.50',
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.green,
    ),
  ),
]
```

#### Custom Background Color
```dart
bottomToolbarItems: [...],
bottomToolbarBackgroundColor: Colors.blue.shade50,
```

---

### 4. Sidebars

#### Simple List Sidebar
```dart
// In ModuleConfig
sidebarBuilder: (context) {
  return ListView(
    children: [
      ListTile(title: Text('Option 1'), onTap: () {}),
      ListTile(title: Text('Option 2'), onTap: () {}),
      ListTile(title: Text('Option 3'), onTap: () {}),
    ],
  );
},
internalSidebarConfig: InternalSidebarConfig(
  width: 250,
  collapsible: true,
),
```

#### Filter Sidebar with State
```dart
class _MyScreenState extends State<MyScreen> {
  Set<String> selectedFilters = {};

  Widget _buildFilterSidebar() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        CheckboxListTile(
          title: Text('In Stock'),
          value: selectedFilters.contains('in_stock'),
          onChanged: (val) {
            setState(() {
              if (val!) selectedFilters.add('in_stock');
              else selectedFilters.remove('in_stock');
            });
          },
        ),
        CheckboxListTile(
          title: Text('Low Stock'),
          value: selectedFilters.contains('low_stock'),
          onChanged: (val) {
            setState(() {
              if (val!) selectedFilters.add('low_stock');
              else selectedFilters.remove('low_stock');
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = ModuleConfig(
      moduleId: 'inventory',
      moduleName: 'Inventory',
      contentBuilder: (context) => _buildGrid(),
      sidebarBuilder: (context) => _buildFilterSidebar(),
      internalSidebarConfig: InternalSidebarConfig(
        width: 300,
        collapsible: true,
        resizable: true,
        minWidth: 250,
        maxWidth: 500,
      ),
    );
    return Workspace(config: config);
  }
}
```

#### Sidebar Configuration Options
```dart
InternalSidebarConfig(
  width: 250,             // Default width
  collapsible: true,      // Show collapse button
  resizable: true,        // Allow drag to resize
  minWidth: 200,          // Minimum width when resizing
  maxWidth: 400,          // Maximum width when resizing
)
```

---

## Step-by-Step Implementation Patterns

### Pattern A: CRUD Screen (Create, Read, Update, Delete)

**Step 1: Define the module structure**
```dart
class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isLoading = false;
  Product? _selectedProduct;
  
  // ... state variables
}
```

**Step 2: Create toolbar items**
```dart
List<ToolbarItem> _buildToolbarItems() {
  return [
    ToolbarItem(
      id: 'new',
      label: 'New Product',
      icon: Icons.add,
      onPressed: _handleNewProduct,
      sortOrder: 1,
    ),
    ToolbarItem(
      id: 'edit',
      label: 'Edit',
      icon: Icons.edit,
      onPressed: _handleEditProduct,
      isEnabled: _selectedProduct != null,  // Only enabled when product selected
      sortOrder: 2,
    ),
    ToolbarItem(
      id: 'delete',
      label: 'Delete',
      icon: Icons.delete,
      onPressed: _handleDeleteProduct,
      isEnabled: _selectedProduct != null,
      sortOrder: 3,
    ),
    ToolbarItem(
      id: 'refresh',
      label: 'Refresh',
      icon: Icons.refresh,
      onPressed: _handleRefresh,
      isLoading: _isLoading,
      sortOrder: 4,
    ),
  ];
}
```

**Step 3: Build the content (grid)**
```dart
Widget _buildContent() {
  return AwehGrid(
    // Grid configuration
    onRowSelected: (product) {
      setState(() => _selectedProduct = product);
    },
  );
}
```

**Step 4: Assemble with ModuleWorkspace**
```dart
@override
Widget build(BuildContext context) {
  return ModuleWorkspace(
    moduleTitle: 'Products',
    toolbarItems: _buildToolbarItems(),
    content: _buildContent(),
    bottomToolbarItems: [
      BottomToolbarItem(
        label: 'Total Products',
        value: '${_totalProducts}',
      ),
      BottomToolbarItem(
        label: 'Selected',
        value: _selectedProduct != null ? '1' : '0',
      ),
    ],
  );
}
```

**Step 5: Implement button handlers**
```dart
void _handleNewProduct() {
  // Navigate to new product form
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProductFormScreen()),
  );
}

void _handleEditProduct() {
  if (_selectedProduct == null) return;
  // Navigate to edit form
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductFormScreen(product: _selectedProduct),
    ),
  );
}

void _handleDeleteProduct() async {
  if (_selectedProduct == null) return;
  
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete Product'),
      content: Text('Are you sure you want to delete ${_selectedProduct!.name}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text('Delete'),
        ),
      ],
    ),
  );
  
  if (confirmed == true) {
    setState(() => _isLoading = true);
    // Delete logic
    await _productService.delete(_selectedProduct!.id);
    setState(() {
      _isLoading = false;
      _selectedProduct = null;
    });
    // Refresh grid
  }
}

void _handleRefresh() async {
  setState(() => _isLoading = true);
  // Refresh logic
  await _loadProducts();
  setState(() => _isLoading = false);
}
```

---

### Pattern B: Detail/Form Screen with Header

**Step 1: Define state**
```dart
class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  OrderDetailsScreen({required this.orderId});
  
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Order? _order;
  bool _isSaving = false;
  
  @override
  void initState() {
    super.initState();
    _loadOrder();
  }
  
  Future<void> _loadOrder() async {
    final order = await _orderService.getById(widget.orderId);
    setState(() => _order = order);
  }
}
```

**Step 2: Build header widget**
```dart
Widget _buildOrderHeader() {
  if (_order == null) {
    return Center(child: CircularProgressIndicator());
  }
  
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${_order!.number}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Customer: ${_order!.customerName}'),
              Text('Date: ${_formatDate(_order!.date)}'),
            ],
          ),
        ),
        _buildStatusChip(_order!.status),
      ],
    ),
  );
}

Widget _buildStatusChip(String status) {
  Color color;
  switch (status) {
    case 'pending': color = Colors.orange; break;
    case 'completed': color = Colors.green; break;
    case 'cancelled': color = Colors.red; break;
    default: color = Colors.grey;
  }
  
  return Chip(
    label: Text(status.toUpperCase()),
    backgroundColor: color.shade100,
    labelStyle: TextStyle(color: color.shade900),
  );
}
```

**Step 3: Build bottom toolbar with totals**
```dart
List<BottomToolbarItem> _buildBottomToolbar() {
  if (_order == null) return [];
  
  return [
    BottomToolbarItem(
      label: 'Items',
      value: '${_order!.items.length}',
    ),
    BottomToolbarItem(
      label: 'Subtotal',
      value: _formatCurrency(_order!.subtotal),
    ),
    BottomToolbarItem(
      label: 'VAT',
      value: _formatCurrency(_order!.vat),
    ),
    BottomToolbarItem(
      label: 'Total',
      value: _formatCurrency(_order!.total),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.green.shade700,
      ),
    ),
  ];
}
```

**Step 4: Assemble screen**
```dart
@override
Widget build(BuildContext context) {
  return ModuleWorkspace(
    moduleTitle: 'Order Details',
    toolbarItems: [
      ToolbarItem(
        id: 'save',
        label: 'Save',
        icon: Icons.save,
        onPressed: _handleSave,
        isLoading: _isSaving,
        sortOrder: 1,
      ),
      ToolbarItem(
        id: 'print',
        label: 'Print',
        icon: Icons.print,
        onPressed: _handlePrint,
        sortOrder: 2,
      ),
    ],
    headerWidgets: [_buildOrderHeader()],
    content: _buildOrderForm(),
    bottomToolbarItems: _buildBottomToolbar(),
  );
}
```

---

### Pattern C: Screen with Resizable Sidebar

**Step 1: Use ModuleConfig (Level 2) for sidebar support**
```dart
class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String? _selectedCategory;
  Set<String> _filters = {};
}
```

**Step 2: Build sidebar content**
```dart
Widget _buildSidebar() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            _buildCategoryTile('All Items', null),
            Divider(),
            _buildCategoryTile('Beverages', 'beverages'),
            _buildCategoryTile('Food', 'food'),
            _buildCategoryTile('Supplies', 'supplies'),
            Divider(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('Filters', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            CheckboxListTile(
              title: Text('In Stock'),
              value: _filters.contains('in_stock'),
              onChanged: (val) => _toggleFilter('in_stock', val!),
            ),
            CheckboxListTile(
              title: Text('Low Stock'),
              value: _filters.contains('low_stock'),
              onChanged: (val) => _toggleFilter('low_stock', val!),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCategoryTile(String name, String? categoryId) {
  return ListTile(
    title: Text(name),
    selected: _selectedCategory == categoryId,
    onTap: () => setState(() => _selectedCategory = categoryId),
  );
}

void _toggleFilter(String filter, bool add) {
  setState(() {
    if (add) _filters.add(filter);
    else _filters.remove(filter);
  });
}
```

**Step 3: Use ModuleConfig with sidebar**
```dart
@override
Widget build(BuildContext context) {
  final config = ModuleConfig(
    moduleId: 'inventory',
    moduleName: 'Inventory',
    contentBuilder: (context) => AwehGrid(
      // Grid with filtered data
    ),
    sidebarBuilder: (context) => _buildSidebar(),
    toolbarItems: [
      ToolbarItem(
        id: 'adjust',
        label: 'Adjust Stock',
        icon: Icons.edit,
        onPressed: _handleAdjustStock,
        sortOrder: 1,
      ),
    ],
    internalSidebarConfig: InternalSidebarConfig(
      width: 280,
      collapsible: true,
      resizable: true,
      minWidth: 220,
      maxWidth: 400,
    ),
  );
  
  return Workspace(config: config);
}
```

---

## Common UI Patterns

### Loading States

```dart
// Show loading in toolbar button
ToolbarItem(
  id: 'save',
  label: 'Save',
  icon: Icons.save,
  onPressed: _handleSave,
  isLoading: _isSaving,  // Shows spinner
)

// Show loading in content
Widget _buildContent() {
  if (_isLoading) {
    return Center(child: CircularProgressIndicator());
  }
  return AwehGrid(...);
}
```

### Conditional Button Enabling

```dart
// Enable only when row is selected
ToolbarItem(
  id: 'edit',
  label: 'Edit',
  icon: Icons.edit,
  onPressed: _handleEdit,
  isEnabled: _selectedRow != null,
)

// Enable based on conditions
ToolbarItem(
  id: 'submit',
  label: 'Submit',
  icon: Icons.send,
  onPressed: _handleSubmit,
  isEnabled: _canSubmit(),  // Call validation function
)

bool _canSubmit() {
  return _formIsValid && !_isSubmitting && _hasChanges;
}
```

### Dynamic Bottom Toolbar Updates

```dart
// Update totals when data changes
void _updateTotals() {
  final subtotal = _calculateSubtotal();
  final vat = subtotal * 0.15;
  final total = subtotal + vat;
  
  setState(() {
    _bottomToolbarItems = [
      BottomToolbarItem(label: 'Subtotal', value: _formatCurrency(subtotal)),
      BottomToolbarItem(label: 'VAT', value: _formatCurrency(vat)),
      BottomToolbarItem(label: 'Total', value: _formatCurrency(total)),
    ];
  });
}

// Rebuild with updated items
@override
Widget build(BuildContext context) {
  return ModuleWorkspace(
    // ...
    bottomToolbarItems: _bottomToolbarItems,
  );
}
```

---

## Complete Working Examples

### Example 1: Products Screen (Full Implementation)

```dart
import 'package:flutter/material.dart';
import 'package:aweh_shell/aweh_shell.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isLoading = false;
  Product? _selectedProduct;
  int _totalProducts = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);
    // Load products from API
    // ...
    setState(() => _isLoading = false);
  }

  List<ToolbarItem> _buildToolbarItems() {
    return [
      ToolbarItem(
        id: 'new',
        label: 'New Product',
        icon: Icons.add,
        onPressed: _handleNewProduct,
        sortOrder: 1,
      ),
      ToolbarItem(
        id: 'edit',
        label: 'Edit',
        icon: Icons.edit,
        onPressed: _handleEditProduct,
        isEnabled: _selectedProduct != null,
        sortOrder: 2,
      ),
      ToolbarItem(
        id: 'delete',
        label: 'Delete',
        icon: Icons.delete,
        onPressed: _handleDeleteProduct,
        isEnabled: _selectedProduct != null,
        sortOrder: 3,
      ),
      ToolbarItem(
        id: 'refresh',
        label: 'Refresh',
        icon: Icons.refresh,
        onPressed: _loadProducts,
        isLoading: _isLoading,
        sortOrder: 4,
      ),
    ];
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Products',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
          // Trigger grid filter
        },
      ),
    );
  }

  Widget _buildGrid() {
    return AwehGrid(
      // Grid configuration
      onRowSelected: (product) {
        setState(() => _selectedProduct = product);
      },
    );
  }

  List<BottomToolbarItem> _buildBottomToolbar() {
    return [
      BottomToolbarItem(
        label: 'Total Products',
        value: '$_totalProducts',
      ),
      BottomToolbarItem(
        label: 'Selected',
        value: _selectedProduct != null ? '1' : '0',
      ),
      BottomToolbarItem(
        label: 'Filtered',
        value: _searchQuery.isEmpty ? 'No' : 'Yes',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ModuleWorkspace(
      moduleTitle: 'Products',
      toolbarItems: _buildToolbarItems(),
      headerWidgets: [_buildSearchHeader()],
      content: _buildGrid(),
      bottomToolbarItems: _buildBottomToolbar(),
    );
  }

  void _handleNewProduct() {
    Navigator.pushNamed(context, '/products/new');
  }

  void _handleEditProduct() {
    if (_selectedProduct == null) return;
    Navigator.pushNamed(
      context,
      '/products/edit',
      arguments: _selectedProduct!.id,
    );
  }

  void _handleDeleteProduct() async {
    if (_selectedProduct == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Product'),
        content: Text('Delete ${_selectedProduct!.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Delete logic
      _loadProducts();
    }
  }
}
```

---

### Example 2: Sales Menu with Sidebar (Full Implementation)

```dart
import 'package:flutter/material.dart';
import 'package:aweh_shell/aweh_shell.dart';

class SalesMenuScreen extends StatefulWidget {
  @override
  _SalesMenuScreenState createState() => _SalesMenuScreenState();
}

class _SalesMenuScreenState extends State<SalesMenuScreen> {
  String? _selectedGroup;
  Set<MenuItem> _selectedItems = {};

  Widget _buildCategorySidebar() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Menu Groups',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          title: Text('All Items'),
          selected: _selectedGroup == null,
          onTap: () => setState(() => _selectedGroup = null),
        ),
        Divider(),
        ListTile(
          title: Text('Beverages'),
          subtitle: Text('25 items'),
          selected: _selectedGroup == 'beverages',
          onTap: () => setState(() => _selectedGroup = 'beverages'),
        ),
        ListTile(
          title: Text('Food'),
          subtitle: Text('42 items'),
          selected: _selectedGroup == 'food',
          onTap: () => setState(() => _selectedGroup = 'food'),
        ),
        ListTile(
          title: Text('Desserts'),
          subtitle: Text('12 items'),
          selected: _selectedGroup == 'desserts',
          onTap: () => setState(() => _selectedGroup = 'desserts'),
        ),
      ],
    );
  }

  Widget _buildMenuGrid() {
    return AwehGrid(
      // Grid showing menu items filtered by _selectedGroup
      multiSelect: true,
      onSelectionChanged: (items) {
        setState(() => _selectedItems = items.cast<MenuItem>().toSet());
      },
    );
  }

  List<ToolbarItem> _buildToolbar() {
    return [
      ToolbarItem(
        id: 'add_to_order',
        label: 'Add to Order',
        icon: Icons.add_shopping_cart,
        onPressed: _handleAddToOrder,
        isEnabled: _selectedItems.isNotEmpty,
        sortOrder: 1,
      ),
      ToolbarItem(
        id: 'view_details',
        label: 'View Details',
        icon: Icons.info,
        onPressed: _handleViewDetails,
        isEnabled: _selectedItems.length == 1,
        sortOrder: 2,
      ),
    ];
  }

  List<BottomToolbarItem> _buildBottomToolbar() {
    return [
      BottomToolbarItem(
        label: 'Group',
        value: _selectedGroup ?? 'All',
      ),
      BottomToolbarItem(
        label: 'Selected Items',
        value: '${_selectedItems.length}',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final config = ModuleConfig(
      moduleId: 'sales_menu',
      moduleName: 'Sales Menu',
      contentBuilder: (context) => _buildMenuGrid(),
      sidebarBuilder: (context) => _buildCategorySidebar(),
      toolbarItems: _buildToolbar(),
      internalSidebarConfig: InternalSidebarConfig(
        width: 250,
        collapsible: true,
        resizable: true,
        minWidth: 200,
        maxWidth: 400,
      ),
    );

    return Workspace(config: config);
  }

  void _handleAddToOrder() {
    // Add selected items to current order
    print('Adding ${_selectedItems.length} items to order');
  }

  void _handleViewDetails() {
    // Show details of selected item
    if (_selectedItems.length == 1) {
      final item = _selectedItems.first;
      print('Viewing details for ${item.name}');
    }
  }
}
```

---

## Quick Reference Chart

| Screen Type | Level | Key Components | Use Case |
|-------------|-------|----------------|----------|
| **Simple Grid** | Level 3 (ModuleWorkspace) | Toolbar + Content | CRUD operations |
| **Form with Header** | Level 3 (ModuleWorkspace) | Toolbar + Header + Content + Bottom | Order details, Edit forms |
| **Grid with Sidebar** | Level 2 (ModuleConfig) | Toolbar + Sidebar + Content | Filtered views, Categories |
| **Complex Layout** | Level 1 (Direct Widgets) | Manual composition | Custom requirements |

---

## Checklist for New Screen

- [ ] Choose appropriate level (1, 2, or 3)
- [ ] Define toolbar items with proper sortOrder
- [ ] Implement button handlers
- [ ] Add loading states where needed
- [ ] Enable/disable buttons based on state
- [ ] Add header if needed (search, filters, info)
- [ ] Add bottom toolbar for totals/stats
- [ ] Add sidebar if filtering needed
- [ ] Test responsive behavior
- [ ] Verify button styling (first button elevated, delete red)

---

## Common Mistakes to Avoid

❌ **Forgetting sortOrder**
```dart
// Bad: No sort order, random button order
ToolbarItem(id: 'save', label: 'Save', onPressed: () {})
```

✅ **Always specify sortOrder**
```dart
// Good: Explicit ordering
ToolbarItem(id: 'save', label: 'Save', onPressed: () {}, sortOrder: 1)
```

---

❌ **Not handling null states**
```dart
// Bad: Will crash if _selectedRow is null
onPressed: () => _handleEdit(_selectedRow.id)
```

✅ **Check for null, use isEnabled**
```dart
// Good: Safe handling
ToolbarItem(
  onPressed: _handleEdit,
  isEnabled: _selectedRow != null,
)

void _handleEdit() {
  if (_selectedRow == null) return;
  // Process...
}
```

---

❌ **Mixing levels inappropriately**
```dart
// Bad: Using ModuleWorkspace but manually composing toolbar
ModuleWorkspace(
  content: Column([
    Row([ElevatedButton(...), ElevatedButton(...)]),  // Manual toolbar
    AwehGrid(...),
  ]),
)
```

✅ **Use consistent level**
```dart
// Good: Let ModuleWorkspace handle toolbar
ModuleWorkspace(
  toolbarItems: [...],
  content: AwehGrid(...),
)
```

---

## Next Steps

1. **Pick a screen to implement** from your app
2. **Choose the right level** based on complexity
3. **Follow the recipe** for that screen type
4. **Copy-paste examples** and customize
5. **Test and iterate**

---

## Support

For more examples, see:
- `example/modularity_examples.dart` - Complete examples for all three levels
- `README.md` - Architecture overview
- `MODULAR_ARCHITECTURE.md` - Principles and patterns

**Happy building! 🚀**
