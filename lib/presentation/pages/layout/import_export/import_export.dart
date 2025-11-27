import 'package:flutter/material.dart';

class ImportExportPage extends StatefulWidget {
  const ImportExportPage({super.key});

  @override
  State<ImportExportPage> createState() => _ImportExportPageState();
}

class _ImportExportPageState extends State<ImportExportPage> {
  String activeTab = "Import";
  String selectedModule = "All Modules";
  String selectedFormat = "Excel (.xlsx)";

  final List<String> tabs = const ["Import", "Export", "Templates", "History"];

  final List<String> modules = const ["All Modules", "Financial Planner", "Accounting", "CRM", "Digital Marketing", "Legal Services", "Compliance"];

  final List<String> formats = const ["Excel (.xlsx)", "CSV (.csv)", "PDF (.pdf)", "JSON (.json)"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),

            _buildQuickStats(),
            const SizedBox(height: 32),

            _buildMainContent(),

            const SizedBox(height: 40),
            const Center(
              child: Text("© 2025 Saving Mantra — Data Management Module", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.import_export_outlined, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Import & Export',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF111827)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Import, export, and manage data across all modules seamlessly',
                    style: TextStyle(fontSize: 16, color: const Color(0xFF6B7280), fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                _buildHeaderButton(icon: Icons.download_outlined, text: 'Download Templates', isPrimary: false),
                const SizedBox(width: 12),
                _buildHeaderButton(icon: Icons.help_outline, text: 'Help Guide', isPrimary: false),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({required IconData icon, required String text, required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary ? null : Colors.white,
        gradient: isPrimary ? const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)]) : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isPrimary ? Colors.transparent : const Color(0xFFE5E7EB)),
        boxShadow: isPrimary ? [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: isPrimary ? Colors.white : const Color(0xFF6B7280), size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isPrimary ? Colors.white : const Color(0xFF374151)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          _buildStatItem('Total Imports', '156', Icons.file_upload_outlined, const Color(0xFF3B82F6), 'Last 30 days'),
          const SizedBox(width: 24),
          _buildStatItem('Total Exports', '89', Icons.file_download_outlined, const Color(0xFF10B981), 'Last 30 days'),
          const SizedBox(width: 24),
          _buildStatItem('Successful', '238', Icons.check_circle_outlined, const Color(0xFF059669), '95% success rate'),
          const SizedBox(width: 24),
          _buildStatItem('Failed', '7', Icons.error_outline, const Color(0xFFDC2626), 'Need attention'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color, String subtitle) {
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
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
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
            style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildTabsSection(), const SizedBox(height: 24), _buildTabContent()]);
  }

  Widget _buildTabsSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabs.map((tab) {
                final bool selected = tab == activeTab;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(
                      tab,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: selected ? Colors.white : const Color(0xFF374151)),
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
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (activeTab) {
      case "Import":
        return _buildImportSection();
      case "Export":
        return _buildExportSection();
      case "Templates":
        return _buildTemplatesSection();
      case "History":
        return _buildHistorySection();
      default:
        return _buildImportSection();
    }
  }

  Widget _buildImportSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                child: const Icon(Icons.file_upload_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Import Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: "Select Module",
                  value: selectedModule,
                  items: modules,
                  onChanged: (value) {
                    setState(() => selectedModule = value!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown(
                  label: "File Format",
                  value: selectedFormat,
                  items: formats,
                  onChanged: (value) {
                    setState(() => selectedFormat = value!);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildFileUploadArea(),
          const SizedBox(height: 20),

          _buildImportOptions(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                child: const Icon(Icons.file_download_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Export Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: "Select Module",
                  value: selectedModule,
                  items: modules,
                  onChanged: (value) {
                    setState(() => selectedModule = value!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown(
                  label: "Export Format",
                  value: selectedFormat,
                  items: formats,
                  onChanged: (value) {
                    setState(() => selectedFormat = value!);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildDateRangeSelector(),
          const SizedBox(height: 20),

          _buildExportOptions(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTemplatesSection() {
    final templates = [
      _Template('Financial Data', 'Client portfolio, investments, policies', 'Excel'),
      _Template('CRM Contacts', 'Customer data with contact information', 'CSV'),
      _Template('Accounting Records', 'Transactions, invoices, payments', 'Excel'),
      _Template('Marketing Campaigns', 'Campaign data and performance metrics', 'CSV'),
      _Template('Legal Documents', 'Case data and document references', 'Excel'),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                child: const Icon(Icons.description_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Download Templates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Use these templates to ensure your data is properly formatted for import', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),

          Column(children: templates.map((template) => _buildTemplateCard(template)).toList()),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    final history = [
      _History('Financial Data Import', 'Success', '07 Nov 2025, 14:30', '156 records'),
      _History('CRM Export', 'Success', '06 Nov 2025, 11:15', '89 contacts'),
      _History('Marketing Data Import', 'Failed', '05 Nov 2025, 16:45', 'Format error'),
      _History('Accounting Export', 'Success', '04 Nov 2025, 09:20', '230 transactions'),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                child: const Icon(Icons.history_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Import/Export History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          SingleChildScrollView(
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
                    label: Text('Operation', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Date & Time', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Details', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Action', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
                rows: history
                    .map(
                      (item) => DataRow(
                        cells: [
                          DataCell(Text(item.operation)),
                          DataCell(_buildStatusBadge(item.status)),
                          DataCell(Text(item.date)),
                          DataCell(Text(item.details)),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                              child: const Text(
                                'View Log',
                                style: TextStyle(color: Color(0xFF0E5E83), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({required String label, required String value, required List<String> items, required Function(String?) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: DropdownButton<String>(
            value: value,
            iconSize: 20,
            isExpanded: true,
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            items: items.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildFileUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Icon(Icons.cloud_upload_outlined, size: 48, color: const Color(0xFF9CA3AF)),
          const SizedBox(height: 16),
          const Text(
            'Drag & drop your file here',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
          ),
          const SizedBox(height: 8),
          const Text('or click to browse files', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E5E83), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
            child: const Text('Browse Files'),
          ),
        ],
      ),
    );
  }

  Widget _buildImportOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Import Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildCheckbox('Update existing records'),
            const SizedBox(width: 24),
            _buildCheckbox('Skip duplicate records'),
            const SizedBox(width: 24),
            _buildCheckbox('Validate data before import'),
            const Spacer(),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E5E83),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Start Import', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExportOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Export Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildCheckbox('Include all columns'),
            const SizedBox(width: 24),
            _buildCheckbox('Compress file (ZIP)'),
            const SizedBox(width: 24),
            _buildCheckbox('Password protect'),
            const Spacer(),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E5E83),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Generate Export', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRangeSelector() {
    return Row(
      children: [
        Expanded(child: _buildDateField('From Date', '01 Nov 2025')),
        const SizedBox(width: 16),
        Expanded(child: _buildDateField('To Date', '07 Nov 2025')),
      ],
    );
  }

  Widget _buildDateField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: Row(
            children: [
              Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
              const Spacer(),
              const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF6B7280)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: const Icon(Icons.check, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
      ],
    );
  }

  Widget _buildTemplateCard(_Template template) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.description_outlined, size: 20, color: const Color(0xFF0E5E83)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(template.description, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFFE5F3F8), borderRadius: BorderRadius.circular(6)),
            child: Text(
              template.format,
              style: const TextStyle(color: Color(0xFF0E5E83), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined, color: Color(0xFF0E5E83)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case "Success":
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case "Failed":
        bgColor = const Color(0xFFFEE2E2);
        textColor = const Color(0xFFDC2626);
        icon = Icons.error_outline;
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

class _Template {
  final String name;
  final String description;
  final String format;

  const _Template(this.name, this.description, this.format);
}

class _History {
  final String operation;
  final String status;
  final String date;
  final String details;

  const _History(this.operation, this.status, this.date, this.details);
}
