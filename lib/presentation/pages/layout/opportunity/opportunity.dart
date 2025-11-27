import 'package:flutter/material.dart';

class OpportunityPage extends StatefulWidget {
  const OpportunityPage({super.key});

  @override
  State<OpportunityPage> createState() => _OpportunityPageState();
}

class _OpportunityPageState extends State<OpportunityPage> {
  String? _selectedCategory;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildHeader(), const SizedBox(height: 32), _buildKPISection(), const SizedBox(height: 32), _buildMainContent()]),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opportunity Dashboard',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF111827)),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage and track your business opportunities in one place',
          style: TextStyle(fontSize: 16, color: const Color(0xFF6B7280), fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildKPISection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          _buildKPIItem('Open Opportunities', '8', Icons.trending_up_outlined, const Color(0xFF10B981), 'Across services & digital projects'),
          const SizedBox(width: 24),
          _buildKPIItem('In Review', '3', Icons.hourglass_empty_outlined, const Color(0xFFF59E0B), 'Awaiting documents / approval'),
          const SizedBox(width: 24),
          _buildKPIItem('Won / Closed', '5', Icons.check_circle_outlined, const Color(0xFF3B82F6), 'In last 30 days'),
          const SizedBox(width: 24),
          _buildKPIItem('Total Value', '₹2.1L', Icons.attach_money_outlined, const Color(0xFFEF4444), 'Potential revenue'),
        ],
      ),
    );
  }

  Widget _buildKPIItem(String title, String value, IconData icon, Color color, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildApplicationForm()),
        const SizedBox(width: 24),

        Expanded(flex: 3, child: _buildOpportunityListing()),
      ],
    );
  }

  Widget _buildApplicationForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.add_business_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Apply for Opportunity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Submit new business, advisory, franchise or project opportunities using this form.', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 24),

          _buildFormField('Opportunity Title *', TextField(controller: _titleController, decoration: _buildInputDecoration('e.g. Distributor for Finance App'))),
          const SizedBox(height: 16),

          _buildFormField(
            'Category *',
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: _buildInputDecoration('Select Category'),
              items: const [
                DropdownMenuItem(value: 'Business Opportunity', child: Text('Business Opportunity')),
                DropdownMenuItem(value: 'Service / Compliance', child: Text('Service / Compliance')),
                DropdownMenuItem(value: 'Digital / Store', child: Text('Digital / Store')),
                DropdownMenuItem(value: 'Franchise', child: Text('Franchise Opportunity')),
                DropdownMenuItem(value: 'Partnership', child: Text('Partnership')),
              ],
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val;
                });
              },
            ),
          ),
          const SizedBox(height: 16),

          _buildFormField(
            'Short Description *',
            TextField(controller: _descController, maxLines: 4, decoration: _buildInputDecoration('Write about the opportunity, target customers, location, expected revenue...')),
          ),
          const SizedBox(height: 16),

          _buildFormField(
            'Attach documents (optional)',
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  color: const Color(0xFFF9FAFB),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_file, color: const Color(0xFF6B7280), size: 18),
                    const SizedBox(width: 12),
                    const Text('Choose file (PDF, DOC, JPEG)', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
              boxShadow: [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                'Submit Opportunity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0E5E83), width: 2),
      ),
    );
  }

  Widget _buildOpportunityListing() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.list_alt_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Opportunity Listing',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF0E5E83).withOpacity(0.2)),
                ),
                child: const Text(
                  '8 Opportunities',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('All opportunities created or assigned to you', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 24),

          _buildOpportunitiesTable(),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
          columns: const [
            DataColumn(
              label: Text(
                '#',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Opportunity',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Created',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Action',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
          ],
          rows: [
            _buildTableRow('1', 'NRI Compliance & Advisory', 'Service / Compliance', 'In Review', _StatusType.warning, '30 Oct 2025'),
            _buildTableRow('2', 'Open local store for MSME clients', 'Business Opportunity', 'Approved', _StatusType.success, '29 Oct 2025'),
            _buildTableRow('3', 'Digital marketing for service partners', 'Digital / Store', 'Pending Docs', _StatusType.warning, '26 Oct 2025'),
            _buildTableRow('4', 'Franchise - Financial Services', 'Franchise', 'Under Review', _StatusType.warning, '25 Oct 2025'),
            _buildTableRow('5', 'Export Business Setup', 'Business Opportunity', 'Completed', _StatusType.success, '20 Oct 2025'),
          ],
        ),
      ),
    );
  }

  DataRow _buildTableRow(String sn, String title, String category, String status, _StatusType statusType, String created) {
    return DataRow(
      cells: [
        DataCell(Text(sn, style: const TextStyle(fontWeight: FontWeight.w500))),
        DataCell(
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(Text(category, style: const TextStyle(color: Color(0xFF6B7280)))),
        DataCell(_StatusBadge(text: status, type: statusType)),
        DataCell(Text(created, style: const TextStyle(color: Color(0xFF6B7280)))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: const Text(
              'View',
              style: TextStyle(color: Color(0xFF0E5E83), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}

enum _StatusType { success, warning }

class _StatusBadge extends StatelessWidget {
  final String text;
  final _StatusType type;

  const _StatusBadge({required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (type) {
      case _StatusType.success:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case _StatusType.warning:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFF92400E);
        icon = Icons.access_time_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }
}
