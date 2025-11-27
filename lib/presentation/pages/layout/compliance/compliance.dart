import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class CompliancePage extends StatefulWidget {
  const CompliancePage({super.key});

  @override
  State<CompliancePage> createState() => _CompliancePageState();
}

class _CompliancePageState extends State<CompliancePage> {
  String activeTab = "TDS";

  final List<String> complianceTabs = const ["TDS", "GST", "MCA Compliance", "Professional Tax", "PF & ESIC", "Other Laws"];

  final Map<String, List<_ComplianceRow>> sampleData = {
    "TDS": [
      _ComplianceRow(date: "07-Nov-2025", name: "TDS Payment – Oct 2025", status: "Pending", note: "Awaiting challan update"),
      _ComplianceRow(date: "10-Oct-2025", name: "TDS Return Q2 (24Q)", status: "Filed", note: "Challan verified"),
    ],
    "GST": [
      _ComplianceRow(date: "05-Nov-2025", name: "GSTR-3B – Oct 2025", status: "Filed", note: "ARN: 27XXXXXXXXXX"),
      _ComplianceRow(date: "20-Nov-2025", name: "GSTR-1 – Oct 2025", status: "In Progress", note: "Awaiting upload"),
    ],
    "MCA Compliance": [
      _ComplianceRow(date: "02-Oct-2025", name: "DIR-3 KYC – Directors", status: "Filed", note: "Approved"),
      _ComplianceRow(date: "10-Nov-2025", name: "AOC-4 (FY 24-25)", status: "Pending", note: "Awaiting attachment"),
    ],
    "Professional Tax": [_ComplianceRow(date: "15-Oct-2025", name: "PT Payment – Sept 2025", status: "Filed", note: "Challan PT/2025/112")],
    "PF & ESIC": [
      _ComplianceRow(date: "10-Oct-2025", name: "PF Return – Sept 2025", status: "Filed", note: "UAN data uploaded"),
      _ComplianceRow(date: "11-Oct-2025", name: "ESIC Return – Sept 2025", status: "Filed", note: "Acknowledged"),
    ],
    "Other Laws": [_ComplianceRow(date: "01-Oct-2025", name: "FSSAI Annual Return", status: "Filed", note: "Filed via portal")],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Compliances',
        subtitle: 'Ensure regulatory compliance and documentation',
        leadingIcon: Icons.verified_outlined,
        customActions: [AppBarActionButton(label: 'Apply', icon: Icons.add, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildKPISection(), const SizedBox(height: 32), _buildMainContent()]),
      ),
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
          _buildKPIItem('Total Compliances', '150', Icons.list_alt_outlined, const Color(0xFF3B82F6)),
          const SizedBox(width: 24),
          _buildKPIItem('Filed', '112', Icons.check_circle_outlined, const Color(0xFF10B981)),
          const SizedBox(width: 24),
          _buildKPIItem('Pending', '28', Icons.pending_actions_outlined, const Color(0xFFF59E0B)),
          const SizedBox(width: 24),
          _buildKPIItem('Delayed', '10', Icons.warning_amber_outlined, const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _buildKPIItem(String title, String value, IconData icon, Color color) {
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
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildComplianceCategories()),
        const SizedBox(width: 24),
        Expanded(flex: 3, child: _buildComplianceStatus()),
      ],
    );
  }

  Widget _buildComplianceCategories() {
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
                child: const Icon(Icons.category_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Compliance Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Apply for different types of statutory compliances', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          _buildComplianceTable(),
          const SizedBox(height: 20),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Apply for Compliance',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Statutory',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'MCA',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Labor',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Global',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Other',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                  ),
                ),
              ],
            ),
          ),
          _buildTableRow(['GST', 'Director KYC', 'PF', 'US Tax Filing', 'FSSAI Return']),
          _buildTableRow(['TDS', 'MGT-7', 'ESIC', '-', '-']),
          _buildTableRow(['Income Tax', 'AOC-4', 'Professional Tax', '-', '-']),
        ],
      ),
    );
  }

  Widget _buildTableRow(List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: const Color(0xFFE5E7EB), width: 1)),
      ),
      child: Row(
        children: items.map((item) {
          return Expanded(
            child: Text(
              item,
              style: TextStyle(fontSize: 13, color: item == '-' ? const Color(0xFF9CA3AF) : const Color(0xFF374151), fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildComplianceStatus() {
    final rows = sampleData[activeTab] ?? [];
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
                child: const Icon(Icons.timeline_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Compliance Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF0E5E83).withOpacity(0.2)),
                ),
                child: Text(
                  '${rows.length} Items',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: complianceTabs.map((tab) {
                final bool selected = tab == activeTab;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      tab,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : const Color(0xFF374151)),
                    ),
                    selected: selected,
                    onSelected: (bool selected) {
                      setState(() {
                        activeTab = tab;
                      });
                    },
                    checkmarkColor: Colors.white,
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF0E5E83),
                    side: BorderSide(color: selected ? const Color(0xFF0E5E83) : const Color(0xFFD1D5DB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          _buildFilterBar(),
          const SizedBox(height: 20),
          _buildComplianceTableData(rows),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Text(
            'Filter :',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
          ),
          const SizedBox(width: 12),
          _buildFilterDropdown('Month', ['October', 'September']),
          const SizedBox(width: 12),
          _buildFilterDropdown('Quarter', ['Q2', 'Q1']),
          const SizedBox(width: 12),
          _buildFilterDropdown('Year', ['2025-26', '2024-25']),
          const SizedBox(width: 12),
          _buildFilterDropdown('Status', ['All', 'Filed', 'Pending', 'In Progress']),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83), borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'Apply Filter',
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, List<String> options) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: DropdownButton<String>(
        value: options.first,
        iconSize: 16,
        underline: const SizedBox(),
        style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
        items: options.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildComplianceTableData(List<_ComplianceRow> rows) {
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
              label: Text('#', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text('Date of Filing', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text('Name of Compliance', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text('Note', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text('Action', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ],
          rows: rows.asMap().entries.map((entry) {
            final index = entry.key;
            final row = entry.value;
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(row.date)),
                DataCell(Text(row.name)),
                DataCell(_buildStatusBadge(row.status)),
                DataCell(Text(row.note)),
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
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;
    switch (status) {
      case "Filed":
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case "Pending":
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        icon = Icons.pending_outlined;
        break;
      case "In Progress":
        bgColor = const Color(0xFFE0F2FE);
        textColor = const Color(0xFF075985);
        icon = Icons.update_outlined;
        break;
      default:
        bgColor = const Color(0xFFE5E7EB);
        textColor = const Color(0xFF374151);
        icon = Icons.help_outline;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
          ),
        ],
      ),
    );
  }
}

class _ComplianceRow {
  final String date;
  final String name;
  final String status;
  final String note;

  const _ComplianceRow({required this.date, required this.name, required this.status, required this.note});
}
