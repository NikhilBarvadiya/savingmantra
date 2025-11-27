import 'package:flutter/material.dart';

class SopPage extends StatefulWidget {
  const SopPage({super.key});

  @override
  State<SopPage> createState() => _SopPageState();
}

class _SopPageState extends State<SopPage> {
  int _currentCategoryIndex = 0;
  int _selectedSOPIndex = -1;
  final List<SOPCategory> _categories = [
    SOPCategory(
      name: 'Accounting',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF0E5E83),
      sops: [
        SOP(id: 'ACC-001', title: 'Monthly Book Closing Process', department: 'Finance', lastUpdated: '15 Oct 2025', status: SOPStatus.active, steps: 12, estimatedTime: '4 hours'),
        SOP(id: 'ACC-002', title: 'GST Return Filing Procedure', department: 'Tax', lastUpdated: '10 Oct 2025', status: SOPStatus.active, steps: 8, estimatedTime: '2 hours'),
        SOP(id: 'ACC-003', title: 'Bank Reconciliation', department: 'Finance', lastUpdated: '05 Oct 2025', status: SOPStatus.draft, steps: 6, estimatedTime: '1.5 hours'),
      ],
    ),
    SOPCategory(
      name: 'HR & Admin',
      icon: Icons.people,
      color: Color(0xFF10B981),
      sops: [
        SOP(id: 'HR-001', title: 'Employee Onboarding', department: 'HR', lastUpdated: '20 Oct 2025', status: SOPStatus.active, steps: 15, estimatedTime: '3 days'),
        SOP(id: 'HR-002', title: 'Leave Application Process', department: 'HR', lastUpdated: '18 Oct 2025', status: SOPStatus.active, steps: 5, estimatedTime: '30 minutes'),
      ],
    ),
    SOPCategory(
      name: 'Sales & Marketing',
      icon: Icons.shopping_cart,
      color: Color(0xFFF59E0B),
      sops: [
        SOP(id: 'SAL-001', title: 'Client Onboarding Process', department: 'Sales', lastUpdated: '12 Oct 2025', status: SOPStatus.active, steps: 10, estimatedTime: '2 hours'),
        SOP(id: 'SAL-002', title: 'Lead Management', department: 'Marketing', lastUpdated: '08 Oct 2025', status: SOPStatus.review, steps: 7, estimatedTime: '1 hour'),
      ],
    ),
    SOPCategory(
      name: 'Operations',
      icon: Icons.settings,
      color: Color(0xFFEF4444),
      sops: [SOP(id: 'OPS-001', title: 'Quality Control Check', department: 'Operations', lastUpdated: '25 Oct 2025', status: SOPStatus.active, steps: 9, estimatedTime: '45 minutes')],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      body: Column(
        children: [
          _buildHeader(),
          _buildStatsRow(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSidebar(),
                const VerticalDivider(width: 1, color: Color(0xffe5e7eb)),
                Expanded(child: _buildMainContent()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateSOPDialog,
        backgroundColor: const Color(0xFF0E5E83),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Standard Operating Procedures',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.grey[900]),
                ),
                const SizedBox(height: 4),
                Text('Create, manage and follow standardized processes', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(Icons.library_books, size: 16, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  'SOP Builder',
                  style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatCard('Total SOPs', '28', Icons.library_books, const Color(0xFF0E5E83)),
          const SizedBox(width: 12),
          _buildStatCard('Active', '18', Icons.check_circle, const Color(0xFF10B981)),
          const SizedBox(width: 12),
          _buildStatCard('In Draft', '6', Icons.edit, const Color(0xFFF59E0B)),
          const SizedBox(width: 12),
          _buildStatCard('Under Review', '4', Icons.visibility, const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: Colors.white,
      child: SingleChildScrollView(child: Column(children: [_buildQuickActions(), _buildCategoriesList()])),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          const SizedBox(height: 12),
          _buildActionButton('Create New SOP', Icons.add),
          const SizedBox(height: 8),
          _buildActionButton('Import Template', Icons.upload),
          const SizedBox(height: 8),
          _buildActionButton('Export All SOPs', Icons.download),
          const SizedBox(height: 8),
          _buildActionButton('SOP Templates', Icons.library_add),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), alignment: Alignment.centerLeft),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF0E5E83)),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          const SizedBox(height: 12),
          ..._categories.asMap().entries.map((entry) => _buildCategoryItem(entry.value, entry.key)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(SOPCategory category, int index) {
    final isSelected = _currentCategoryIndex == index;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? category.color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? category.color : Colors.grey[200]!),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _currentCategoryIndex = index;
            _selectedSOPIndex = -1;
          });
        },
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), alignment: Alignment.centerLeft),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: category.color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Icon(category.icon, size: 16, color: category.color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w500),
                  ),
                  Text('${category.sops.length} SOPs', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildContentHeader(),
        Expanded(child: _buildSOPList()),
      ],
    );
  }

  Widget _buildContentHeader() {
    final category = _categories[_currentCategoryIndex];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: category.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(category.icon, size: 20, color: category.color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
              ),
              Text('${category.sops.length} Standard Operating Procedures', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Text('Search SOPs...', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text('Filter by Status', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[500]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSOPList() {
    final category = _categories[_currentCategoryIndex];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: category.sops.length,
      itemBuilder: (context, index) {
        final sop = category.sops[index];
        return _buildSOPCard(sop, index);
      },
    );
  }

  Widget _buildSOPCard(SOP sop, int index) {
    final isSelected = _selectedSOPIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        border: isSelected ? Border.all(color: const Color(0xFF0E5E83), width: 2) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedSOPIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(color: _getStatusColor(sop.status), borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            sop.id,
                            style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          _buildStatusBadge(sop.status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sop.title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildInfoChip(sop.department, Icons.business),
                          const SizedBox(width: 8),
                          _buildInfoChip('${sop.steps} Steps', Icons.list),
                          const SizedBox(width: 8),
                          _buildInfoChip(sop.estimatedTime, Icons.access_time),
                          const SizedBox(width: 8),
                          _buildInfoChip(sop.lastUpdated, Icons.calendar_today),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () => _viewSOPDetails(sop),
                      icon: Icon(Icons.visibility, size: 18, color: Colors.grey[600]),
                    ),
                    IconButton(
                      onPressed: () => _editSOP(sop),
                      icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(SOPStatus status) {
    final statusConfig = _getStatusConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: statusConfig.color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(
        statusConfig.text,
        style: TextStyle(fontSize: 11, color: statusConfig.color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[500]),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _showCreateSOPDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New SOP'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'SOP Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      items: _categories.map((e) => DropdownMenuItem(value: e.name, child: Text(e.name))).toList(),
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E5E83)),
            child: const Text('Create SOP'),
          ),
        ],
      ),
    );
  }

  void _viewSOPDetails(SOP sop) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(sop.title),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SOP ID: ${sop.id}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Department: ${sop.department}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Last Updated: ${sop.lastUpdated}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(height: 8),
              Text('Estimated Time: ${sop.estimatedTime}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              const SizedBox(height: 16),
              const Text('Procedure Steps:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...List.generate(sop.steps, (index) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text('${index + 1}. Step description for ${sop.title}'))),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E5E83)),
            child: const Text('Edit SOP'),
          ),
        ],
      ),
    );
  }

  void _editSOP(SOP sop) {}

  Color _getStatusColor(SOPStatus status) {
    switch (status) {
      case SOPStatus.active:
        return const Color(0xFF10B981);
      case SOPStatus.draft:
        return const Color(0xFFF59E0B);
      case SOPStatus.review:
        return const Color(0xFFEF4444);
      case SOPStatus.archived:
        return const Color(0xFF6B7280);
    }
  }

  _StatusConfig _getStatusConfig(SOPStatus status) {
    switch (status) {
      case SOPStatus.active:
        return _StatusConfig('Active', const Color(0xFF10B981));
      case SOPStatus.draft:
        return _StatusConfig('Draft', const Color(0xFFF59E0B));
      case SOPStatus.review:
        return _StatusConfig('Under Review', const Color(0xFFEF4444));
      case SOPStatus.archived:
        return _StatusConfig('Archived', const Color(0xFF6B7280));
    }
  }
}

class _StatusConfig {
  final String text;
  final Color color;

  _StatusConfig(this.text, this.color);
}

enum SOPStatus { active, draft, review, archived }

class SOP {
  final String id;
  final String title;
  final String department;
  final String lastUpdated;
  final SOPStatus status;
  final int steps;
  final String estimatedTime;

  SOP({required this.id, required this.title, required this.department, required this.lastUpdated, required this.status, required this.steps, required this.estimatedTime});
}

class SOPCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<SOP> sops;

  SOPCategory({required this.name, required this.icon, required this.color, required this.sops});
}
