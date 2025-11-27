import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class MyMembersPage extends StatefulWidget {
  const MyMembersPage({super.key});

  @override
  State<MyMembersPage> createState() => _MyMembersPageState();
}

class _MyMembersPageState extends State<MyMembersPage> {
  String _selectedFilter = 'All', _selectedNetwork = 'All Networks';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'My Members',
        subtitle: 'Team members and their activities',
        leadingIcon: Icons.people_alt_outlined,
        customActions: [AppBarActionButton(label: 'Add Member', icon: Icons.person_add, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildStatsOverview(), const SizedBox(height: 32), _buildFiltersAndSearch(), const SizedBox(height: 24), _buildMembersList(), const SizedBox(height: 40), _buildFooter()],
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2.0,
      children: const [
        _MemberStatCard(title: "Total Members", value: "33", change: "+5 this month", icon: Icons.people_alt_rounded, color: Color(0xFF0E5E83), gradient: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
        _MemberStatCard(title: "Active", value: "28", change: "85% active rate", icon: Icons.check_circle_rounded, color: Color(0xFF10B981), gradient: [Color(0xFF10B981), Color(0xFF059669)]),
        _MemberStatCard(title: "Pending", value: "3", change: "Awaiting approval", icon: Icons.pending_actions_rounded, color: Color(0xFFF59E0B), gradient: [Color(0xFFF59E0B), Color(0xFFD97706)]),
        _MemberStatCard(title: "New This Week", value: "5", change: "2 invites sent", icon: Icons.trending_up_rounded, color: Color(0xFF8B5CF6), gradient: [Color(0xFF8B5CF6), Color(0xFF7C3AED)]),
      ],
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 48,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300, width: .8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Search members by name, email, or role...",
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedNetwork,
                  icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[500]),
                  items: const [
                    DropdownMenuItem(value: 'All Networks', child: Text('All Networks')),
                    DropdownMenuItem(value: 'SM Garments', child: Text('SM Garments')),
                    DropdownMenuItem(value: 'ElectroParts', child: Text('ElectroParts')),
                    DropdownMenuItem(value: 'Service Franchise', child: Text('Service Franchise')),
                  ],
                  onChanged: (value) => setState(() => _selectedNetwork = value!),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  icon: Icon(Icons.filter_list_rounded, color: Colors.grey[500]),
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All Members')),
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'Recent', child: Text('Recent')),
                  ],
                  onChanged: (value) => setState(() => _selectedFilter = value!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Network Members",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "33 Members",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0E5E83)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildMembersHeader(),
            const SizedBox(height: 16),
            ..._buildMemberItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Member",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          Expanded(
            child: Text(
              "Network",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          Expanded(
            child: Text(
              "Role",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          Expanded(
            child: Text(
              "Join Date",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          Expanded(
            child: Text(
              "Status",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                "Actions",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMemberItems() {
    final members = [
      _MemberItem(
        name: "Rajesh Kumar",
        email: "rajesh.kumar@email.com",
        network: "SM Garments",
        role: "Distributor",
        joinDate: "15 Nov 2023",
        status: "Active",
        sales: "₹42,500",
        avatarText: "RK",
        onTap: () {},
        onMessage: () {},
        onCall: () {},
      ),
      _MemberItem(
        name: "Priya Sharma",
        email: "priya.sharma@email.com",
        network: "ElectroParts",
        role: "Retailer",
        joinDate: "22 Oct 2023",
        status: "Active",
        sales: "₹28,300",
        avatarText: "PS",
        onTap: () {},
        onMessage: () {},
        onCall: () {},
      ),
      _MemberItem(
        name: "Amit Patel",
        email: "amit.patel@email.com",
        network: "Service Franchise",
        role: "Service Partner",
        joinDate: "05 Dec 2023",
        status: "Pending",
        sales: "₹0",
        avatarText: "AP",
        onTap: () {},
        onMessage: () {},
        onCall: () {},
      ),
      _MemberItem(
        name: "Sneha Gupta",
        email: "sneha.gupta@email.com",
        network: "SM Garments",
        role: "Retailer",
        joinDate: "18 Sep 2023",
        status: "Active",
        sales: "₹35,800",
        avatarText: "SG",
        onTap: () {},
        onMessage: () {},
        onCall: () {},
      ),
      _MemberItem(
        name: "Vikram Singh",
        email: "vikram.singh@email.com",
        network: "ElectroParts",
        role: "Distributor",
        joinDate: "30 Nov 2023",
        status: "Active",
        sales: "₹51,200",
        avatarText: "VS",
        onTap: () {},
        onMessage: () {},
        onCall: () {},
      ),
    ];

    return members.map((member) => member).toList();
  }

  Widget _buildFooter() {
    return Center(
      child: Text('© ${DateTime.now().year} Saving Mantra — Member Management', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _MemberStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final List<Color> gradient;

  const _MemberStatCard({required this.title, required this.value, required this.change, required this.icon, required this.color, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradient),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: gradient.first.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberItem extends StatelessWidget {
  final String name;
  final String email;
  final String network;
  final String role;
  final String joinDate;
  final String status;
  final String sales;
  final String avatarText;
  final VoidCallback onTap;
  final VoidCallback onMessage;
  final VoidCallback onCall;

  const _MemberItem({
    required this.name,
    required this.email,
    required this.network,
    required this.role,
    required this.joinDate,
    required this.status,
    required this.sales,
    required this.avatarText,
    required this.onTap,
    required this.onMessage,
    required this.onCall,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF10B981);
      case 'pending':
        return const Color(0xFFF59E0B);
      case 'inactive':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'distributor':
        return const Color(0xFF0E5E83);
      case 'retailer':
        return const Color(0xFF8B5CF6);
      case 'service partner':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: const Color(0x0A000000), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      avatarText,
                      style: const TextStyle(color: Color(0xFF0E5E83), fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 2),
                      Text(email, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.attach_money_rounded, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Text(
                            "Sales: $sales",
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF059669)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(6)),
              child: Text(
                network,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: _getRoleColor(role).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(
                role,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _getRoleColor(role)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Text(
              joinDate,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: _getStatusColor(status).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(
                status,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _getStatusColor(status)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _MemberActionButton(icon: Icons.chat_rounded, tooltip: 'Send Message', onTap: onMessage, color: Color(0xFF0E5E83)),
                const SizedBox(width: 8),
                _MemberActionButton(icon: Icons.phone_rounded, tooltip: 'Call Member', onTap: onCall, color: Color(0xFF10B981)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;

  const _MemberActionButton({required this.icon, required this.tooltip, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
