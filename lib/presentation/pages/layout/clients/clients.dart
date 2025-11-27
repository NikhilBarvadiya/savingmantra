import 'package:flutter/material.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final List<Map<String, dynamic>> _clients = [
    {
      'id': 'CL001',
      'name': 'Rajesh Kumar',
      'email': 'rajesh@kumarindustries.com',
      'phone': '+91 98765 43210',
      'company': 'Kumar Industries',
      'status': 'Active',
      'value': '₹25,00,000',
      'lastContact': '15 Nov 2025',
      'projects': 5,
      'joinDate': '12 Jan 2024',
    },
    {
      'id': 'CL002',
      'name': 'Priya Sharma',
      'email': 'priya@techsolutions.in',
      'phone': '+91 87654 32109',
      'company': 'Tech Solutions Pvt Ltd',
      'status': 'Active',
      'value': '₹18,50,000',
      'lastContact': '14 Nov 2025',
      'projects': 3,
      'joinDate': '23 Mar 2024',
    },
    {
      'id': 'CL003',
      'name': 'Amit Patel',
      'email': 'amit@patelgroup.com',
      'phone': '+91 76543 21098',
      'company': 'Patel Group',
      'status': 'Inactive',
      'value': '₹12,00,000',
      'lastContact': '05 Oct 2025',
      'projects': 2,
      'joinDate': '15 Aug 2023',
    },
    {
      'id': 'CL004',
      'name': 'Sneha Reddy',
      'email': 'sneha@startupventure.com',
      'phone': '+91 65432 10987',
      'company': 'Startup Venture',
      'status': 'Active',
      'value': '₹8,75,000',
      'lastContact': '12 Nov 2025',
      'projects': 1,
      'joinDate': '30 May 2024',
    },
    {
      'id': 'CL005',
      'name': 'Vikram Singh',
      'email': 'vikram@enterprise.co',
      'phone': '+91 94321 09876',
      'company': 'Enterprise Solutions',
      'status': 'Active',
      'value': '₹32,00,000',
      'lastContact': '10 Nov 2025',
      'projects': 7,
      'joinDate': '08 Feb 2023',
    },
    {
      'id': 'CL006',
      'name': 'Neha Gupta',
      'email': 'neha@guptatextiles.com',
      'phone': '+91 83214 56789',
      'company': 'Gupta Textiles',
      'status': 'Pending',
      'value': '₹5,00,000',
      'lastContact': '08 Nov 2025',
      'projects': 1,
      'joinDate': '20 Sep 2024',
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {'client': 'Rajesh Kumar', 'activity': 'Project Discussion', 'type': 'Meeting', 'time': '2 hours ago', 'user': 'You'},
    {'client': 'Priya Sharma', 'activity': 'Contract Renewal', 'type': 'Email', 'time': '4 hours ago', 'user': 'Amit K.'},
    {'client': 'Vikram Singh', 'activity': 'Payment Received', 'type': 'Payment', 'time': 'Yesterday', 'user': 'System'},
    {'client': 'Sneha Reddy', 'activity': 'New Project Started', 'type': 'Project', 'time': '2 days ago', 'user': 'You'},
  ];

  String _selectedFilter = 'All';
  String _selectedStatus = 'All';
  String _selectedSort = 'Recent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 25),
            _buildStatsCards(),
            const SizedBox(height: 25),
            _buildFilterBar(),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildClientsTable()),
                const SizedBox(width: 20),
                Expanded(flex: 1, child: Column(children: [_buildRecentActivities(), const SizedBox(height: 20), _buildClientDistribution()])),
              ],
            ),
            const SizedBox(height: 30),
            _buildFooter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddClientDialog,
        backgroundColor: const Color(0xff0E5E83),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Clients / All Clients", style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 6),
            Text("All Clients List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Manage and track all your clients in one place.", style: TextStyle(fontSize: 13, color: Colors.black54)),
          ],
        ),
        Row(
          children: [
            _buildSmallButton("Export", Icons.download, border: true),
            const SizedBox(width: 10),
            _buildSmallButton("Bulk Actions", Icons.playlist_add_check, color: const Color(0xffE67E22)),
            const SizedBox(width: 10),
            _buildSmallButton("Add Client", Icons.add, color: const Color(0xff0E5E83)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        _buildStatCard(title: "Total Clients", value: "1,247", change: "+12%", isPositive: true, color: Color(0xff0E5E83), icon: Icons.people),
        const SizedBox(width: 16),
        _buildStatCard(title: "Active Clients", value: "1,089", change: "+8%", isPositive: true, color: Color(0xff27AE60), icon: Icons.check_circle),
        const SizedBox(width: 16),
        _buildStatCard(title: "Total Revenue", value: "₹12.8Cr", change: "+18%", isPositive: true, color: Color(0xff9B59B6), icon: Icons.currency_rupee),
        const SizedBox(width: 16),
        _buildStatCard(title: "Avg. Value", value: "₹10.2L", change: "+5%", isPositive: true, color: Color(0xffE67E22), icon: Icons.trending_up),
      ],
    );
  }

  Widget _buildStatCard({required String title, required String value, required String change, required bool isPositive, required Color color, required IconData icon}) {
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, size: 16, color: color),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, size: 10, color: isPositive ? Colors.green : Colors.red),
                      const SizedBox(width: 2),
                      Text(
                        change,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isPositive ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          _buildFilterDropdown(
            value: _selectedFilter,
            items: ['All', 'Recent', 'High Value', 'New', 'VIP'],
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
            label: 'Filter',
          ),
          const SizedBox(width: 16),
          _buildFilterDropdown(
            value: _selectedStatus,
            items: ['All', 'Active', 'Inactive', 'Pending'],
            onChanged: (value) {
              setState(() {
                _selectedStatus = value!;
              });
            },
            label: 'Status',
          ),
          const SizedBox(width: 16),
          _buildFilterDropdown(
            value: _selectedSort,
            items: ['Recent', 'Name', 'Value', 'Join Date'],
            onChanged: (value) {
              setState(() {
                _selectedSort = value!;
              });
            },
            label: 'Sort By',
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search clients...',
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
    );
  }

  Widget _buildClientsTable() {
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
          const Text("All Clients", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text("Complete list of all your clients", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.8),
              child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 0,
                headingRowHeight: 40,
                dataRowHeight: 60,
                columns: const [
                  DataColumn(
                    label: Text('Client ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Client Details', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Company', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Projects', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Last Contact', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: _clients.map((client) {
                  return DataRow(
                    cells: [
                      DataCell(Text(client['id'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(client['name'], style: const TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 2),
                            Text(client['email'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                            Text(client['phone'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                      DataCell(Text(client['company'], style: const TextStyle(fontSize: 12))),
                      DataCell(_buildStatusBadge(client['status'] as String)),
                      DataCell(
                        Text(
                          client['value'],
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xff27AE60)),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xff0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '${client['projects']}',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xff0E5E83)),
                          ),
                        ),
                      ),
                      DataCell(Text(client['lastContact'], style: const TextStyle(fontSize: 11))),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility, size: 16, color: Colors.blue),
                              onPressed: () => _viewClientDetails(client),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 16, color: Colors.green),
                              onPressed: () => _editClient(client),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                              onPressed: () => _deleteClient(client),
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
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
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
          const Text("Recent Activities", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text("Latest client interactions", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          Column(
            children: _recentActivities.map((activity) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Color(0xff0E5E83), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity['client'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                          Text(activity['activity'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(activity['time'] as String, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        Text(
                          activity['type'] as String,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xff0E5E83)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClientDistribution() {
    final distribution = [
      {'category': 'Active Clients', 'count': 1089, 'percentage': 87, 'color': Colors.green},
      {'category': 'Inactive Clients', 'count': 125, 'percentage': 10, 'color': Colors.orange},
      {'category': 'Pending Clients', 'count': 33, 'percentage': 3, 'color': Colors.blue},
    ];

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
          const Text("Client Distribution", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text("Status overview of all clients", style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          Column(
            children: distribution.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(color: item['color'] as Color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(flex: 2, child: Text(item['category'] as String, style: const TextStyle(fontSize: 12))),
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
                            width: (item['percentage'] as double) * 2,
                            decoration: BoxDecoration(color: item['color'] as Color, borderRadius: BorderRadius.circular(4)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${item['count']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
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

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Active':
        color = Colors.green;
        break;
      case 'Inactive':
        color = Colors.orange;
        break;
      case 'Pending':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(
        status,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget _buildFilterDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged, required String label}) {
    return Container(
      width: 140,
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

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Client Management System.", style: TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  void _showAddClientDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Client"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: const InputDecoration(labelText: "Full Name")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Email")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Phone")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Company")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Add Client")),
        ],
      ),
    );
  }

  void _viewClientDetails(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Client Details - ${client['name']}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Client ID: ${client['id']}"),
              Text("Email: ${client['email']}"),
              Text("Phone: ${client['phone']}"),
              Text("Company: ${client['company']}"),
              Text("Status: ${client['status']}"),
              Text("Total Value: ${client['value']}"),
              Text("Projects: ${client['projects']}"),
              Text("Join Date: ${client['joinDate']}"),
              Text("Last Contact: ${client['lastContact']}"),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
      ),
    );
  }

  void _editClient(Map<String, dynamic> client) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Editing client ${client['name']}")));
  }

  void _deleteClient(Map<String, dynamic> client) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Client"),
        content: Text("Are you sure you want to delete ${client['name']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() {
                _clients.remove(client);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted client ${client['name']}")));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
