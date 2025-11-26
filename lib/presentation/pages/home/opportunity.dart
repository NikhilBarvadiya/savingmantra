import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/home/home.dart';

class OpportunityPage extends StatefulWidget {
  const OpportunityPage({super.key});

  @override
  State<OpportunityPage> createState() => _OpportunityPageState();
}

class _OpportunityPageState extends State<OpportunityPage> {
  String? _selectedCategory;

  // simple controllers just for UI – hook to API later
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
      backgroundColor: const Color(0xFFF7F8FB),
      body: Row(
        children: [
          _Sidebar(),
          Expanded(
            child: Column(
              children: [
                // HEADER
                _Header(),
                const Divider(height: 1),
                // MAIN CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TOP KPI CARDS
                        Row(
                          children: const [
                            Expanded(
                              child: _KpiCard(title: 'Open Opportunities', value: '8', subtitle: 'Across services & digital projects'),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _KpiCard(title: 'In Review', value: '3', subtitle: 'Awaiting documents / approval'),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _KpiCard(title: 'Won / Closed', value: '5', subtitle: 'In last 30 days'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // APPLY + LISTING
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // LEFT – APPLY FORM
                            Expanded(
                              flex: 3,
                              child: _Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _CardHeader(title: 'Apply for Opportunity'),
                                    const SizedBox(height: 4),
                                    const Text('Submit new business / advisory / franchise / project opportunities using this form.', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                                    const SizedBox(height: 16),

                                    // Title
                                    _LabeledField(
                                      label: 'Opportunity Title *',
                                      child: TextField(controller: _titleController, decoration: _inputDecoration('e.g. Distributor for Finance App')),
                                    ),
                                    const SizedBox(height: 12),

                                    // Category
                                    _LabeledField(
                                      label: 'Category *',
                                      child: DropdownButtonFormField<String>(
                                        value: _selectedCategory,
                                        decoration: _inputDecoration('Select'),
                                        items: const [
                                          DropdownMenuItem(value: 'Business Opportunity', child: Text('Business Opportunity')),
                                          DropdownMenuItem(value: 'Service / Compliance', child: Text('Service / Compliance')),
                                          DropdownMenuItem(value: 'Digital / Store', child: Text('Digital / Store')),
                                        ],
                                        onChanged: (val) {
                                          setState(() {
                                            _selectedCategory = val;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Description
                                    _LabeledField(
                                      label: 'Short Description *',
                                      child: TextField(
                                        controller: _descController,
                                        maxLines: 4,
                                        decoration: _inputDecoration('Write about the opportunity, target customers, location, expected revenue...'),
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // File (just visual placeholder)
                                    _LabeledField(
                                      label: 'Attach documents (optional)',
                                      child: InkWell(
                                        onTap: () {
                                          // TODO: integrate file picker for web
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: const Color(0xFFD1D5DB)),
                                            color: Colors.white,
                                          ),
                                          child: const Text('Choose file (optional)', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF0E5E83),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                                        ),
                                        onPressed: () {
                                          // TODO: hook to API
                                        },
                                        child: const Text('Submit Opportunity', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // RIGHT – LISTING
                            Expanded(
                              flex: 3,
                              child: _Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _CardHeader(title: 'Opportunity Listing', subtitle: 'All opportunities created or assigned to you'),
                                    const SizedBox(height: 8),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('#')),
                                          DataColumn(label: Text('Opportunity')),
                                          DataColumn(label: Text('Status')),
                                          DataColumn(label: Text('Created')),
                                          DataColumn(label: Text('Action')),
                                        ],
                                        rows: [
                                          _historyRow(sn: '1', title: 'NRI Compliance & Advisory', status: 'In Review', statusType: _StatusType.warning, created: '30 Oct 2025'),
                                          _historyRow(sn: '2', title: 'Open local store for MSME clients', status: 'Approved', statusType: _StatusType.success, created: '29 Oct 2025'),
                                          _historyRow(sn: '3', title: 'Digital marketing for service partners', status: 'Pending Docs', statusType: _StatusType.warning, created: '26 Oct 2025'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // FOOTER
                Container(
                  height: 44,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  child: const Text('© 2025 Saving Mantra — Opportunity Module', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF0E5E83), width: 1.2),
      ),
    );
  }

  DataRow _historyRow({required String sn, required String title, required String status, required _StatusType statusType, required String created}) {
    return DataRow(
      cells: [
        DataCell(Text(sn)),
        DataCell(Text(title)),
        DataCell(_StatusBadge(text: status, type: statusType)),
        DataCell(Text(created)),
        const DataCell(
          Text(
            'View',
            style: TextStyle(color: Color(0xFF0E5E83), decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

/* ====== SMALL REUSABLE WIDGETS ====== */

class _Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: const [
                // you can swap this with Image.asset('assets/logo.png')
                Icon(Icons.savings, color: Color(0xFF0E5E83)),
                SizedBox(width: 8),
                Text('Saving Mantra', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Client Workspace', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: const [
                _SidebarSection(title: 'Overview', items: [_SidebarItem('Client Dashboard'), _SidebarItem('Opportunity Dashboard', active: true)]),
                _SidebarSection(
                  title: 'Services',
                  items: [
                    _SidebarItem('Registrations'),
                    _SidebarItem('Compliances'),
                    _SidebarItem('Legal'),
                    _SidebarItem('Financial Services'),
                    _SidebarItem('Digital Marketing'),
                    _SidebarItem('Import / Export'),
                  ],
                ),
                _SidebarSection(title: 'Accounting', items: [_SidebarItem('Accounting Workspace'), _SidebarItem('Masters'), _SidebarItem('Transactions'), _SidebarItem('Reports')]),
                _SidebarSection(
                  title: 'Networking',
                  items: [_SidebarItem('Network Dashboard'), _SidebarItem('Create / Manage Network'), _SidebarItem('My Members'), _SidebarItem('Invitations / Requests')],
                ),
                _SidebarSection(title: 'CRM', items: [_SidebarItem('Leads'), _SidebarItem('Follow-ups'), _SidebarItem('Clients')]),
                _SidebarSection(title: 'Booking', items: [_SidebarItem('Booking Dashboard'), _SidebarItem('Manage Bookings')]),
                _SidebarSection(title: 'Daily Tools', items: [_SidebarItem('To-Do'), _SidebarItem('Task Management'), _SidebarItem('SOP'), _SidebarItem('Biz Plan')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarSection extends StatelessWidget {
  final String title;
  final List<_SidebarItem> items;

  const _SidebarSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      initiallyExpanded: title == 'Overview',
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4B5563)),
      ),
      children: items,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String text;
  final bool active;

  const _SidebarItem(this.text, {this.active = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: TextStyle(fontSize: 13, color: active ? const Color(0xFF0E5E83) : const Color(0xFF111827), fontWeight: active ? FontWeight.w600 : FontWeight.w400),
      ),
      onTap: () {
        print(text);
        if (text == "Client Dashboard") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Client Dashboard · Opportunity', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              SizedBox(height: 2),
              Text('Opportunity Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _KpiCard({required this.title, required this.value, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Color(0x0F020817), offset: Offset(0, 8), blurRadius: 24)],
      ),
      child: child,
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _CardHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            if (subtitle != null) ...[const SizedBox(height: 2), Text(subtitle!, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)))],
          ],
        ),
      ],
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        child,
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

    switch (type) {
      case _StatusType.success:
        bg = const Color(0x1422C55E);
        fg = const Color(0xFF15803D);
        break;
      case _StatusType.warning:
        bg = const Color(0xFFFDE68A);
        fg = const Color(0xFF92400E);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }
}
