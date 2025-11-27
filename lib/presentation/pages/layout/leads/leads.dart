import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  final List<Map<String, dynamic>> _leads = [
    {
      'id': '1',
      'name': 'Rajesh Kumar',
      'email': 'rajesh@email.com',
      'phone': '+91 98765 43210',
      'status': 'Hot Lead',
      'source': 'Website',
      'value': '₹50,000',
      'lastContact': '12 Nov 2025',
      'notes': 'Interested in business loan',
    },
    {
      'id': '2',
      'name': 'Priya Sharma',
      'email': 'priya@company.com',
      'phone': '+91 87654 32109',
      'status': 'Warm',
      'source': 'Referral',
      'value': '₹75,000',
      'lastContact': '11 Nov 2025',
      'notes': 'Follow up next week',
    },
  ];

  final List<Map<String, dynamic>> _pipelineData = [
    {'stage': 'New', 'count': 45, 'color': Colors.blue, 'percentage': 36},
    {'stage': 'Contacted', 'count': 32, 'color': Colors.green, 'percentage': 26},
    {'stage': 'Qualified', 'count': 18, 'color': Colors.orange, 'percentage': 14},
    {'stage': 'Proposal', 'count': 15, 'color': Colors.purple, 'percentage': 12},
    {'stage': 'Negotiation', 'count': 8, 'color': Colors.red, 'percentage': 6},
    {'stage': 'Closed Won', 'count': 7, 'color': Colors.green, 'percentage': 6},
  ];

  final List<Map<String, dynamic>> _customers = [
    {'id': 'C001', 'name': 'Rajesh Kumar', 'email': 'rajesh@email.com', 'phone': '+91 98765 43210', 'status': 'Active', 'value': '₹50,000', 'lastPurchase': '12 Nov 2025'},
    {'id': 'C002', 'name': 'Priya Sharma', 'email': 'priya@company.com', 'phone': '+91 87654 32109', 'status': 'Active', 'value': '₹75,000', 'lastPurchase': '11 Nov 2025'},
  ];

  final List<Map<String, dynamic>> _communications = [
    {'type': 'Email', 'to': 'Rajesh Kumar', 'subject': 'Proposal Sent', 'date': '12 Nov 2025', 'status': 'Sent'},
    {'type': 'Call', 'to': 'Priya Sharma', 'subject': 'Follow-up Call', 'date': '11 Nov 2025', 'status': 'Completed'},
  ];

  final List<Map<String, dynamic>> _conversionData = [
    {'month': 'Jan', 'conversion': 65},
    {'month': 'Feb', 'conversion': 72},
    {'month': 'Mar', 'conversion': 68},
    {'month': 'Apr', 'conversion': 80},
    {'month': 'May', 'conversion': 75},
    {'month': 'Jun', 'conversion': 85},
  ];

  final List<Map<String, dynamic>> _performanceData = [
    {'metric': 'Response Time', 'value': '2.3 hrs', 'target': '4 hrs'},
    {'metric': 'Conversion Rate', 'value': '23.5%', 'target': '20%'},
    {'metric': 'Lead Quality', 'value': '8.2/10', 'target': '7.5/10'},
    {'metric': 'Customer Satisfaction', 'value': '4.5/5', 'target': '4.2/5'},
  ];

  final List<Map<String, dynamic>> _reports = [
    {'name': 'Monthly Lead Report', 'date': 'Nov 2025', 'type': 'PDF'},
    {'name': 'Conversion Analysis', 'date': 'Oct 2025', 'type': 'Excel'},
    {'name': 'Sales Performance', 'date': 'Nov 2025', 'type': 'PDF'},
    {'name': 'Customer Feedback', 'date': 'Sep 2025', 'type': 'Word'},
  ];

  String _selectedMenu = 'Leads Dashboard';
  String _filterStatus = 'All';
  String _sortBy = 'Date Added';

  Widget _buildCurrentView() {
    switch (_selectedMenu) {
      case 'Lead Pipeline':
        return _buildLeadPipelineView();
      case 'Customer Management':
        return _buildCustomerManagementView();
      case 'Communication Log':
        return _buildCommunicationLogView();
      case 'Lead Conversion':
        return _buildLeadConversionView();
      case 'Performance Metrics':
        return _buildPerformanceMetricsView();
      case 'Reports':
        return _buildReportsView();
      case 'Leads Dashboard':
      default:
        return _buildLeadsDashboardView();
    }
  }

  Widget _buildLeadsDashboardView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Leads / Dashboard", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Leads Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Manage your leads pipeline, track conversions, and analyze performance metrics.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export Data", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Add New Lead", Icons.add, color: const Color(0xff0E5E83)),
                const SizedBox(width: 10),
                _buildSmallButton("Filter Leads", Icons.filter_list, color: const Color(0xffE67E22)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            _buildStatCard(title: "Total Leads", value: "1,247", change: "+12%", isPositive: true, color: Color(0xff0E5E83)),
            const SizedBox(width: 16),
            _buildStatCard(title: "Conversion Rate", value: "23.5%", change: "+5.2%", isPositive: true, color: Color(0xff27AE60)),
            const SizedBox(width: 16),
            _buildStatCard(title: "Pending Follow-ups", value: "48", change: "-8%", isPositive: false, color: Color(0xffE67E22)),
            const SizedBox(width: 16),
            _buildStatCard(title: "Revenue Generated", value: "₹12.8L", change: "+18%", isPositive: true, color: Color(0xff9B59B6)),
          ],
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Row(
            children: [
              _buildFilterDropdown(
                value: _filterStatus,
                items: ['All', 'Hot', 'Warm', 'Cold', 'Converted', 'Lost'],
                onChanged: (value) {
                  setState(() {
                    _filterStatus = value!;
                  });
                },
                label: 'Status',
              ),
              const SizedBox(width: 16),
              _buildFilterDropdown(
                value: _sortBy,
                items: ['Date Added', 'Name', 'Value', 'Last Contact'],
                onChanged: (value) {
                  setState(() {
                    _sortBy = value!;
                  });
                },
                label: 'Sort By',
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search leads...',
                    border: InputBorder.none,
                    isDense: true,
                    prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300, width: .8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildDashboardCard(title: "Recent Leads", subtitle: "Manage and track your lead pipeline", child: _buildLeadsTable()),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _buildDashboardCard(title: "Lead Pipeline", subtitle: "Distribution across stages", child: _buildPipelineChart()),
                  const SizedBox(height: 20),
                  _buildDashboardCard(title: "Quick Actions", subtitle: "Frequently used operations", child: _buildQuickActions()),
                  const SizedBox(height: 20),
                  _buildDashboardCard(title: "Lead Sources", subtitle: "Where your leads come from", child: _buildLeadSources()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeadPipelineView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Leads / Pipeline", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Lead Pipeline", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Track and manage your leads through different pipeline stages.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export Pipeline", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Add Stage", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Pipeline Overview",
          subtitle: "Visual representation of your lead pipeline",
          child: Column(
            children: [
              _buildPipelineChart(),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStatCard(title: "Total in Pipeline", value: "1,247", change: "+12%", isPositive: true, color: Color(0xff0E5E83)),
                  const SizedBox(width: 16),
                  _buildStatCard(title: "Avg. Time in Pipeline", value: "15 days", change: "-2 days", isPositive: true, color: Color(0xff27AE60)),
                  const SizedBox(width: 16),
                  _buildStatCard(title: "Conversion Rate", value: "23.5%", change: "+5.2%", isPositive: true, color: Color(0xffE67E22)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerManagementView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Leads / Customers", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Customer Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Manage your existing customers and their relationships.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export Customers", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Add Customer", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Customer List",
          subtitle: "All your existing customers",
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5),
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 0,
                headingRowHeight: 40,
                dataRowHeight: 50,
                columns: const [
                  DataColumn(
                    label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Contact', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Last Purchase', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: _customers.map((customer) {
                  return DataRow(
                    cells: [
                      DataCell(Text(customer['id'])),
                      DataCell(Text(customer['name'], style: const TextStyle(fontWeight: FontWeight.w500))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(customer['email'], style: const TextStyle(fontSize: 11)),
                            Text(customer['phone'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                      DataCell(_buildBadge(customer['status'], Colors.green)),
                      DataCell(Text(customer['lastPurchase'], style: const TextStyle(fontSize: 11))),
                      DataCell(Text(customer['value'], style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility, size: 16, color: Colors.blue),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 16, color: Colors.green),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunicationLogView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Leads / Communications", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Communication Log", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Track all your communications with leads and customers.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export Log", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("New Communication", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Communication History",
          subtitle: "All your communications with leads and customers",
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5),
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 0,
                headingRowHeight: 40,
                dataRowHeight: 50,
                columns: const [
                  DataColumn(
                    label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('To', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: _communications.map((comm) {
                  return DataRow(
                    cells: [
                      DataCell(_buildBadge(comm['type'], Colors.blue)),
                      DataCell(Text(comm['to'], style: const TextStyle(fontWeight: FontWeight.w500))),
                      DataCell(Text(comm['subject'])),
                      DataCell(Text(comm['date'], style: const TextStyle(fontSize: 11))),
                      DataCell(_buildBadge(comm['status'], Colors.green)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility, size: 16, color: Colors.blue),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.replay, size: 16, color: Colors.orange),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeadConversionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Analytics / Conversion", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Lead Conversion", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Analyze your lead conversion rates and trends.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("Export Report", Icons.download, border: true),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: _buildDashboardCard(
                title: "Conversion Trends",
                subtitle: "Monthly conversion rate trends",
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _conversionData.length,
                    itemBuilder: (context, index) {
                      final data = _conversionData[index];
                      return Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: 30,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(color: const Color(0xff0E5E83), borderRadius: BorderRadius.circular(4)),
                                height: (data['conversion'] as int).toDouble() * 2,
                              ),
                            ),
                            Text(data['month'] as String, style: const TextStyle(fontSize: 12)),
                            Text('${data['conversion']}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildDashboardCard(
                title: "Conversion Stats",
                subtitle: "Key conversion metrics",
                child: Column(
                  children: [
                    _buildConversionStat("Overall Conversion Rate", "23.5%", "+5.2%", true),
                    _buildConversionStat("Hot Lead Conversion", "45.2%", "+8.1%", true),
                    _buildConversionStat("Warm Lead Conversion", "28.7%", "+3.4%", true),
                    _buildConversionStat("Cold Lead Conversion", "12.3%", "+1.2%", true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceMetricsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Analytics / Performance", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Performance Metrics", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Track and analyze your team's performance metrics.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("Export Metrics", Icons.download, border: true),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Performance Overview",
          subtitle: "Key performance indicators and metrics",
          child: Column(
            children: _performanceData.map((metric) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(metric['metric'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        metric['value'] as String,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff0E5E83)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Target: ${metric['target']}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "On Track",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReportsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Analytics / Reports", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Reports", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Access and manage all your sales and lead reports.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("Generate Report", Icons.add, color: const Color(0xff0E5E83)),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Available Reports",
          subtitle: "All your generated reports",
          child: Column(
            children: _reports.map((report) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Icon(_getReportIcon(report['type'] as String), size: 24, color: const Color(0xff0E5E83)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(report['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                          Text(report['date'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    _buildBadge(report['type'] as String, Colors.blue),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.download, size: 18, color: Color(0xff0E5E83)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, size: 18, color: Colors.green),
                      onPressed: () {},
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildConversionStat(String title, String value, String change, bool isPositive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(title, style: const TextStyle(fontSize: 12))),
          Expanded(
            flex: 1,
            child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(
                change,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isPositive ? Colors.green : Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getReportIcon(String type) {
    switch (type) {
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'Excel':
        return Icons.table_chart;
      case 'Word':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      appBar: CustomAppBar(
        title: 'Leads',
        subtitle: 'Manage and track potential clients',
        leadingIcon: Icons.leaderboard_outlined,
        customActions: [
          AppBarActionButton(label: 'Import Leads', icon: Icons.upload, onPressed: () {}),
          const SizedBox(width: 8),
          AppBarActionButton(label: 'Add Lead', icon: Icons.add, onPressed: () {}, isPrimary: true),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tools & Services",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0E5E83)),
                ),
                const SizedBox(height: 25),
                const Text("LEADS & CRM", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildMenuItem("Leads Dashboard", Icons.dashboard, active: _selectedMenu == "Leads Dashboard"),
                _buildMenuItem("Lead Pipeline", Icons.timeline, active: _selectedMenu == "Lead Pipeline"),
                _buildMenuItem("Customer Management", Icons.people, active: _selectedMenu == "Customer Management"),
                _buildMenuItem("Communication Log", Icons.chat, active: _selectedMenu == "Communication Log"),
                const SizedBox(height: 30),
                const Text("ANALYTICS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildMenuItem("Lead Conversion", Icons.trending_up, active: _selectedMenu == "Lead Conversion"),
                _buildMenuItem("Performance Metrics", Icons.analytics, active: _selectedMenu == "Performance Metrics"),
                _buildMenuItem("Reports", Icons.description, active: _selectedMenu == "Reports"),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrentView(),
                  const SizedBox(height: 30),
                  const Center(
                    child: Text("© 2025 Saving Mantra — Leads Management System.", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedMenu == "Leads Dashboard"
          ? FloatingActionButton(
              onPressed: _showAddLeadDialog,
              backgroundColor: const Color(0xff0E5E83),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildMenuItem(String text, IconData icon, {bool active = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMenu = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xff0E5E83).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: active ? Border.all(color: const Color(0xff0E5E83).withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: active ? const Color(0xff0E5E83) : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 13, color: active ? const Color(0xff0E5E83) : Colors.black87, fontWeight: active ? FontWeight.bold : FontWeight.normal),
              ),
            ),
            if (active) const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xff0E5E83)),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallButton(String text, IconData icon, {Color color = Colors.white, bool border = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: border ? Border.all(color: Colors.black26) : null,
        boxShadow: [if (!border) BoxShadow(color: color.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: border ? Colors.black87 : Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: border ? Colors.black87 : Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required String change, required bool isPositive, required Color color}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, size: 12, color: isPositive ? Colors.green : Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        change,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isPositive ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({required String title, required String subtitle, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildLeadsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.8),
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 0,
          headingRowHeight: 40,
          dataRowHeight: 50,
          columns: const [
            DataColumn(
              label: Text('#', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Contact', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Source', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Last Contact', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DataColumn(
              label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
          rows: _leads.map((lead) {
            Color statusColor = Colors.grey;
            if (lead['status'] == 'Hot Lead') statusColor = Colors.red;
            if (lead['status'] == 'Warm') statusColor = Colors.orange;
            if (lead['status'] == 'Cold') statusColor = Colors.blue;

            return DataRow(
              cells: [
                DataCell(Text(lead['id'])),
                DataCell(Text(lead['name'], style: const TextStyle(fontWeight: FontWeight.w500))),
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lead['email'], style: const TextStyle(fontSize: 11)),
                      Text(lead['phone'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                DataCell(_buildBadge(lead['status'], statusColor)),
                DataCell(Text(lead['source'])),
                DataCell(Text(lead['value'], style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(lead['lastContact'], style: const TextStyle(fontSize: 11))),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility, size: 16, color: Colors.blue),
                        onPressed: () => _viewLeadDetails(lead),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16, color: Colors.green),
                        onPressed: () => _editLead(lead),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                        onPressed: () => _deleteLead(lead),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPipelineChart() {
    return Column(
      children: _pipelineData.map((stage) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: stage['color'] as Color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: Text(stage['stage'] as String, style: const TextStyle(fontSize: 12))),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      height: 8,
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
                    ),
                    Container(
                      height: 8,
                      width: (stage['percentage'] as double) * 2,
                      decoration: BoxDecoration(color: stage['color'] as Color, borderRadius: BorderRadius.circular(4)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text('${stage['count']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.add, 'label': 'Add Lead', 'color': Color(0xff0E5E83), 'onTap': _showAddLeadDialog},
      {'icon': Icons.email, 'label': 'Send Email', 'color': Color(0xff27AE60), 'onTap': _sendBulkEmail},
      {'icon': Icons.phone, 'label': 'Make Call', 'color': Color(0xffE67E22), 'onTap': _makeCall},
      {'icon': Icons.calendar_today, 'label': 'Schedule', 'color': Color(0xff9B59B6), 'onTap': _scheduleMeeting},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: actions.map((action) {
        return InkWell(
          onTap: action['onTap'] as void Function()?,
          child: Container(
            width: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (action['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: (action['color'] as Color).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(action['icon'] as IconData, size: 20, color: action['color'] as Color),
                const SizedBox(height: 6),
                Text(
                  action['label'] as String,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: action['color'] as Color),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLeadSources() {
    final sources = [
      {'source': 'Website', 'count': 45, 'percentage': 36},
      {'source': 'Referral', 'count': 32, 'percentage': 26},
      {'source': 'Social Media', 'count': 25, 'percentage': 20},
      {'source': 'Email Campaign', 'count': 15, 'percentage': 12},
      {'source': 'Other', 'count': 8, 'percentage': 6},
    ];

    return Column(
      children: sources.map((source) {
        Color sourceColor = Colors.grey;
        if (source['source'] == 'Website') sourceColor = Colors.blue;
        if (source['source'] == 'Referral') sourceColor = Colors.green;
        if (source['source'] == 'Social Media') sourceColor = Colors.purple;
        if (source['source'] == 'Email Campaign') sourceColor = Colors.orange;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(source['source'] as String, style: const TextStyle(fontSize: 12))),
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
                    ),
                    Container(
                      height: 6,
                      width: (source['percentage'] as double) * 2,
                      decoration: BoxDecoration(color: sourceColor, borderRadius: BorderRadius.circular(3)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text('${source['count']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFilterDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged, required String label}) {
    return Container(
      width: 150,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fb),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 16),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  void _showAddLeadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Lead"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: const InputDecoration(labelText: "Name")),
              TextField(decoration: const InputDecoration(labelText: "Email")),
              TextField(decoration: const InputDecoration(labelText: "Phone")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Add Lead")),
        ],
      ),
    );
  }

  void _viewLeadDetails(Map<String, dynamic> lead) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Lead Details - ${lead['name']}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${lead['email']}"),
              Text("Phone: ${lead['phone']}"),
              Text("Status: ${lead['status']}"),
              Text("Source: ${lead['source']}"),
              Text("Value: ${lead['value']}"),
              Text("Notes: ${lead['notes']}"),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }

  void _editLead(Map<String, dynamic> lead) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Editing ${lead['name']}")));
  }

  void _deleteLead(Map<String, dynamic> lead) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Lead"),
        content: Text("Are you sure you want to delete ${lead['name']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() {
                _leads.remove(lead);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted ${lead['name']}")));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _sendBulkEmail() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Bulk email functionality")));
  }

  void _makeCall() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Call functionality")));
  }

  void _scheduleMeeting() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Schedule meeting functionality")));
  }
}
