import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class InvitationsRequestsPage extends StatefulWidget {
  const InvitationsRequestsPage({super.key});

  @override
  State<InvitationsRequestsPage> createState() => _InvitationsRequestsPageState();
}

class _InvitationsRequestsPageState extends State<InvitationsRequestsPage> {
  int _currentTab = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Invitations / Requests',
        subtitle: 'Manage network invitations and requests',
        leadingIcon: Icons.mail_outline,
        customActions: [AppBarActionButton(label: 'Send Invitation', icon: Icons.send, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsOverview(),
            const SizedBox(height: 32),
            _buildTabSelector(),
            const SizedBox(height: 24),
            _buildSearchAndFilters(),
            const SizedBox(height: 24),
            _currentTab == 0
                ? _buildPendingRequests()
                : _currentTab == 1
                ? _buildAcceptedRequests()
                : _buildRejectedRequests(),
            const SizedBox(height: 40),
            _buildFooter(),
          ],
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
        _RequestStatCard(title: "Pending", value: "8", change: "Awaiting response", icon: Icons.pending_actions_rounded, color: Color(0xFFF59E0B), gradient: [Color(0xFFF59E0B), Color(0xFFD97706)]),
        _RequestStatCard(title: "Accepted", value: "24", change: "This month", icon: Icons.check_circle_rounded, color: Color(0xFF10B981), gradient: [Color(0xFF10B981), Color(0xFF059669)]),
        _RequestStatCard(title: "Rejected", value: "3", change: "2 this week", icon: Icons.cancel_rounded, color: Color(0xFFEF4444), gradient: [Color(0xFFEF4444), Color(0xFFDC2626)]),
        _RequestStatCard(title: "Expired", value: "5", change: "Auto-expired", icon: Icons.timer_off_rounded, color: Color(0xFF6B7280), gradient: [Color(0xFF6B7280), Color(0xFF374151)]),
      ],
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(text: "Pending (8)", isActive: _currentTab == 0, onTap: () => setState(() => _currentTab = 0)),
          ),
          Expanded(
            child: _TabButton(text: "Accepted (24)", isActive: _currentTab == 1, onTap: () => setState(() => _currentTab = 1)),
          ),
          Expanded(
            child: _TabButton(text: "Rejected (3)", isActive: _currentTab == 2, onTap: () => setState(() => _currentTab = 2)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
                  hintText: "Search by name, email, or network...",
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300, width: .8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                  value: 'All Networks',
                  icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[500]),
                  items: const [
                    DropdownMenuItem(value: 'All Networks', child: Text('All Networks')),
                    DropdownMenuItem(value: 'SM Garments', child: Text('SM Garments')),
                    DropdownMenuItem(value: 'ElectroParts', child: Text('ElectroParts')),
                    DropdownMenuItem(value: 'Service Franchise', child: Text('Service Franchise')),
                  ],
                  onChanged: (value) {},
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
                  value: 'All Types',
                  icon: Icon(Icons.filter_list_rounded, color: Colors.grey[500]),
                  items: const [
                    DropdownMenuItem(value: 'All Types', child: Text('All Types')),
                    DropdownMenuItem(value: 'Invitations', child: Text('Invitations')),
                    DropdownMenuItem(value: 'Requests', child: Text('Requests')),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingRequests() {
    return Column(
      children: [
        _buildSectionHeader(title: "Pending Requests & Invitations", subtitle: "8 requests awaiting your action"),
        const SizedBox(height: 20),
        _InvitationCard(
          type: "Membership Request",
          name: "Amit Patel",
          email: "amit.patel@email.com",
          network: "Service Franchise West",
          role: "Service Partner",
          sentDate: "2 days ago",
          status: "Pending",
          avatarText: "AP",
          isRequest: true,
          onAccept: () {},
          onReject: () {},
          onView: () {},
        ),
        _InvitationCard(
          type: "Your Invitation",
          name: "Neha Verma",
          email: "neha.verma@email.com",
          network: "SM Garments Channel",
          role: "Retailer",
          sentDate: "1 day ago",
          status: "Sent",
          avatarText: "NV",
          isRequest: false,
          onAccept: () {},
          onReject: () {},
          onView: () {},
        ),
        _InvitationCard(
          type: "Membership Request",
          name: "Rahul Mehta",
          email: "rahul.mehta@email.com",
          network: "ElectroParts Dealer Net",
          role: "Distributor",
          sentDate: "3 days ago",
          status: "Pending",
          avatarText: "RM",
          isRequest: true,
          onAccept: () {},
          onReject: () {},
          onView: () {},
        ),
        _InvitationCard(
          type: "Your Invitation",
          name: "Sanjay Joshi",
          email: "sanjay.joshi@email.com",
          network: "SM Garments Channel",
          role: "Distributor",
          sentDate: "6 hours ago",
          status: "Sent",
          avatarText: "SJ",
          isRequest: false,
          onAccept: () {},
          onReject: () {},
          onView: () {},
        ),
      ],
    );
  }

  Widget _buildAcceptedRequests() {
    return Column(
      children: [
        _buildSectionHeader(title: "Accepted Requests & Invitations", subtitle: "24 members joined your networks"),
        const SizedBox(height: 20),
        _AcceptedInvitationCard(
          name: "Priya Sharma",
          email: "priya.sharma@email.com",
          network: "ElectroParts Dealer Net",
          role: "Retailer",
          acceptedDate: "Today, 10:30 AM",
          avatarText: "PS",
          sales: "₹28,300",
          onMessage: () {},
          onView: () {},
        ),
        _AcceptedInvitationCard(
          name: "Vikram Singh",
          email: "vikram.singh@email.com",
          network: "ElectroParts Dealer Net",
          role: "Distributor",
          acceptedDate: "Yesterday, 3:15 PM",
          avatarText: "VS",
          sales: "₹51,200",
          onMessage: () {},
          onView: () {},
        ),
        _AcceptedInvitationCard(
          name: "Sneha Gupta",
          email: "sneha.gupta@email.com",
          network: "SM Garments Channel",
          role: "Retailer",
          acceptedDate: "2 days ago",
          avatarText: "SG",
          sales: "₹35,800",
          onMessage: () {},
          onView: () {},
        ),
      ],
    );
  }

  Widget _buildRejectedRequests() {
    return Column(
      children: [
        _buildSectionHeader(title: "Rejected Requests & Invitations", subtitle: "3 requests were not approved"),
        const SizedBox(height: 20),
        _RejectedInvitationCard(
          name: "Rohit Malhotra",
          email: "rohit.malhotra@email.com",
          network: "Service Franchise West",
          role: "Service Partner",
          rejectedDate: "2 days ago",
          reason: "Insufficient experience",
          avatarText: "RM",
          onView: () {},
        ),
        _RejectedInvitationCard(
          name: "Anita Desai",
          email: "anita.desai@email.com",
          network: "SM Garments Channel",
          role: "Retailer",
          rejectedDate: "1 week ago",
          reason: "Location not suitable",
          avatarText: "AD",
          onView: () {},
        ),
      ],
    );
  }

  Widget _buildSectionHeader({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(
              _currentTab == 0
                  ? Icons.pending_actions_rounded
                  : _currentTab == 1
                  ? Icons.check_circle_rounded
                  : Icons.cancel_rounded,
              color: const Color(0xFF0E5E83),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
          if (_currentTab == 0)
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                  child: const Text(
                    "Accept All",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                  child: const Text("Reject All", style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Text('© ${DateTime.now().year} Saving Mantra — Invitations & Requests', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _RequestStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final List<Color> gradient;

  const _RequestStatCard({required this.title, required this.value, required this.change, required this.icon, required this.color, required this.gradient});

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

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.text, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive ? [BoxShadow(color: const Color(0x0F000000), blurRadius: 10, offset: const Offset(0, 2))] : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
          ),
        ),
      ),
    );
  }
}

class _InvitationCard extends StatelessWidget {
  final String type;
  final String name;
  final String email;
  final String network;
  final String role;
  final String sentDate;
  final String status;
  final String avatarText;
  final bool isRequest;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onView;

  const _InvitationCard({
    required this.type,
    required this.name,
    required this.email,
    required this.network,
    required this.role,
    required this.sentDate,
    required this.status,
    required this.avatarText,
    required this.isRequest,
    required this.onAccept,
    required this.onReject,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: const Color(0x0A000000), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                avatarText,
                style: const TextStyle(color: Color(0xFF0E5E83), fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: isRequest ? const Color(0xFFE67E22).withOpacity(0.1) : const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        type,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isRequest ? const Color(0xFFE67E22) : const Color(0xFF0E5E83)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFF59E0B).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        status,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(email, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.business_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(network, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.work_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.schedule_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(sentDate, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              _ActionButton(icon: Icons.check_rounded, text: "Accept", onTap: onAccept, color: Color(0xFF10B981)),
              const SizedBox(width: 8),
              _ActionButton(icon: Icons.close_rounded, text: "Reject", onTap: onReject, color: Color(0xFFEF4444)),
              const SizedBox(width: 8),
              _ActionButton(icon: Icons.visibility_rounded, text: "View", onTap: onView, color: Color(0xFF0E5E83)),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcceptedInvitationCard extends StatelessWidget {
  final String name;
  final String email;
  final String network;
  final String role;
  final String acceptedDate;
  final String avatarText;
  final String sales;
  final VoidCallback onMessage;
  final VoidCallback onView;

  const _AcceptedInvitationCard({
    required this.name,
    required this.email,
    required this.network,
    required this.role,
    required this.acceptedDate,
    required this.avatarText,
    required this.sales,
    required this.onMessage,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: const Color(0x0A000000), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                avatarText,
                style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        "Accepted",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF10B981)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(email, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.business_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(network, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.work_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.attach_money_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      "Sales: $sales",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF059669)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text("Accepted on $acceptedDate", style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          Row(
            children: [
              _ActionButton(icon: Icons.chat_rounded, text: "Message", onTap: onMessage, color: Color(0xFF0E5E83)),
              const SizedBox(width: 8),
              _ActionButton(icon: Icons.visibility_rounded, text: "View", onTap: onView, color: Color(0xFF6B7280)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RejectedInvitationCard extends StatelessWidget {
  final String name;
  final String email;
  final String network;
  final String role;
  final String rejectedDate;
  final String reason;
  final String avatarText;
  final VoidCallback onView;

  const _RejectedInvitationCard({
    required this.name,
    required this.email,
    required this.network,
    required this.role,
    required this.rejectedDate,
    required this.reason,
    required this.avatarText,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: const Color(0x0A000000), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                avatarText,
                style: const TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: const Text(
                        "Rejected",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFEF4444)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(email, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.business_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(network, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    const SizedBox(width: 16),
                    Icon(Icons.work_rounded, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.info_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      "Reason: $reason",
                      style: TextStyle(fontSize: 11, color: Colors.grey[600], fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Text("Rejected on $rejectedDate", style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          _ActionButton(icon: Icons.visibility_rounded, text: "View", onTap: onView, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const _ActionButton({required this.icon, required this.text, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
