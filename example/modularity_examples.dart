import 'package:flutter/material.dart';
import 'package:aweh_shell/aweh_shell.dart';

/// This file demonstrates the three levels of modularity in aweh_shell.
/// Choose the level that best fits your module's needs.

// ============================================================================
// LEVEL 1: Direct Widget Usage - Maximum Control
// ============================================================================

class Level1_DirectUsage extends StatelessWidget {
  const Level1_DirectUsage({super.key});

  @override
  Widget build(BuildContext context) {
    // Compose layout manually with full control
    return Column(
      children: [
        // Custom header with specific styling
        Container(
          color: Colors.blue.shade50,
          padding: const EdgeInsets.all(16),
          child: const Row(
            children: [
              Icon(Icons.people, size: 32),
              SizedBox(width: 12),
              Text('Custom Header', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),

        // Toolbar
        AwehToolbar(
          items: [
            ToolbarItem(
              id: 'new',
              label: 'New User',
              icon: Icons.add,
              onPressed: () {},
              sortOrder: 0,
            ),
          ],
        ),

        // Custom layout - two columns
        Expanded(
          child: Row(
            children: [
              // Left panel
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey.shade100,
                  child: const Center(child: Text('Main Content')),
                ),
              ),

              // Right panel
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: Text('Side Panel')),
                ),
              ),
            ],
          ),
        ),

        // Bottom toolbar
        AwehBottomToolbar(
          items: const [
            BottomToolbarItem(label: 'Total Users', value: '42'),
            BottomToolbarItem(label: 'Active', value: '38'),
          ],
        ),
      ],
    );
  }
}

// ============================================================================
// LEVEL 2: ModuleConfig + Workspace - Flexible Composition
// ============================================================================

class Level2_ModuleConfig extends StatelessWidget {
  const Level2_ModuleConfig({super.key});

  @override
  Widget build(BuildContext context) {
    // Define module structure via configuration
    final config = ModuleConfig(
      moduleId: 'users',
      moduleName: 'User Management',

      // Content builder - required
      contentBuilder: (context) => Container(
        color: Colors.grey.shade100,
        child: const Center(child: Text('User Grid Goes Here')),
      ),

      // Toolbar items - optional
      toolbarItems: [
        ToolbarItem(
          id: 'new',
          label: 'New',
          icon: Icons.add,
          onPressed: () {},
          sortOrder: 0,
        ),
        ToolbarItem(
          id: 'edit',
          label: 'Edit',
          icon: Icons.edit,
          onPressed: () {},
          sortOrder: 1,
        ),
        ToolbarItem(
          id: 'delete',
          label: 'Delete',
          icon: Icons.delete,
          onPressed: () {},
          sortOrder: 2,
        ),
      ],

      // Header builder - optional
      headerBuilder: (context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            const Text('Filter: '),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: 'All',
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All Users')),
                DropdownMenuItem(value: 'Active', child: Text('Active Only')),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ),

      // Sidebar builder - optional
      sidebarBuilder: (context) => Container(
        width: 200,
        color: Colors.grey.shade200,
        child: const Center(child: Text('Filters')),
      ),

      // Bottom builder - optional
      bottomBuilder: (context) => AwehBottomToolbar(
        items: const [BottomToolbarItem(label: 'Total', value: '42')],
      ),
    );

    // Render with Workspace
    return Workspace(config: config);
  }
}

// ============================================================================
// LEVEL 3: ModuleWorkspace - Convenience Wrapper
// ============================================================================

class Level3_ConvenienceWrapper extends StatelessWidget {
  const Level3_ConvenienceWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Quick setup for simple modules
    return ModuleWorkspace(
      moduleTitle: 'Employees',
      toolbarItems: [
        ToolbarItem(
          id: 'new',
          label: 'New Employee',
          icon: Icons.add,
          onPressed: () {},
          sortOrder: 0,
        ),
        ToolbarItem(
          id: 'edit',
          label: 'Edit',
          icon: Icons.edit,
          onPressed: () {},
          sortOrder: 1,
        ),
        ToolbarItem(
          id: 'delete',
          label: 'Delete',
          icon: Icons.delete,
          onPressed: () {},
          sortOrder: 2,
        ),
      ],
      content: Container(
        color: Colors.grey.shade100,
        child: const Center(child: Text('Employee Grid')),
      ),
      bottomToolbarItems: const [
        BottomToolbarItem(label: 'Total Employees', value: '156'),
        BottomToolbarItem(label: 'Active', value: '142'),
      ],
    );
  }
}

// ============================================================================
// REAL-WORLD EXAMPLE: Purchase Order Details
// ============================================================================

class PurchaseOrderDetailsModule extends StatelessWidget {
  const PurchaseOrderDetailsModule({super.key});

  @override
  Widget build(BuildContext context) {
    // Complex module using Level 2 for maximum flexibility
    final config = ModuleConfig(
      moduleId: 'po-details',
      moduleName: 'Purchase Order',

      // Header with supplier info, dates, status
      headerBuilder: (context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            const Text('Supplier: ABC Supplies'),
            const SizedBox(width: 24),
            const Text('Date: 2026-02-17'),
            const SizedBox(width: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PENDING',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),

      // Toolbar with Save and PDF buttons
      toolbarItems: [
        ToolbarItem(
          id: 'save',
          label: 'Save Order',
          icon: Icons.save,
          onPressed: () {},
          sortOrder: 0,
        ),
        ToolbarItem(
          id: 'pdf',
          label: 'Generate PDF',
          icon: Icons.picture_as_pdf,
          onPressed: () {},
          sortOrder: 1,
        ),
      ],

      // Main content - order line items grid
      contentBuilder: (context) => Container(
        color: Colors.white,
        child: const Center(child: Text('Order Line Items Grid')),
      ),

      // Bottom bar with totals
      bottomBuilder: (context) => AwehBottomToolbar(
        items: const [
          BottomToolbarItem(label: 'Total Lines', value: '12'),
          BottomToolbarItem(label: 'Total Excl', value: 'R 5,200.00'),
          BottomToolbarItem(label: 'Tax', value: 'R 780.00'),
          BottomToolbarItem(label: 'Total Incl', value: 'R 5,980.00'),
        ],
        backgroundColor: Colors.blue.shade50,
      ),
    );

    return Workspace(config: config);
  }
}

// ============================================================================
// CHOICE GUIDE
// ============================================================================

/// When to use each level:
///
/// LEVEL 1 (Direct Widget Usage):
/// - Need custom layout order
/// - Complex nested layouts
/// - Special styling requirements
/// - Full control over composition
///
/// LEVEL 2 (ModuleConfig + Workspace):
/// - Standard module structure
/// - Dynamic content via builders
/// - Need flexibility with common patterns
/// - Want to define module configuration separately
///
/// LEVEL 3 (ModuleWorkspace):
/// - Simple CRUD screens
/// - Quick prototyping
/// - Standard grid + toolbar layout
/// - Don't need custom composition
