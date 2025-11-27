import 'package:flutter/material.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
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
            _buildNetworkStats(),
            const SizedBox(height: 32),
            _buildNetworkTables(),
            const SizedBox(height: 32),
            _buildSalesWithNetwork(),
            const SizedBox(height: 40),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(
            "NETWORK DASHBOARD",
            style: TextStyle(fontSize: 11, color: const Color(0xFF0E5E83), fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Network Management",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: const Color(0xFF111827), height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Manage your business networks, track members, and monitor network sales performance in real-time",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600], fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                _HeaderActionButton(icon: Icons.add_rounded, text: "Create Network", onTap: () {}, primary: false),
                const SizedBox(width: 12),
                _HeaderActionButton(icon: Icons.person_add_rounded, text: "Invite Member", onTap: () {}, primary: true),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNetworkStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2.0,
      children: const [
        _NetworkStatCard(title: "My Networks", value: "3", change: "+1 this month", icon: Icons.groups_rounded, color: Color(0xFF0E5E83), gradient: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
        _NetworkStatCard(title: "Joined Networks", value: "3", change: "Active members", icon: Icons.group_add_rounded, color: Color(0xFF10B981), gradient: [Color(0xFF10B981), Color(0xFF059669)]),
        _NetworkStatCard(title: "Total Members", value: "33", change: "+5 new", icon: Icons.people_alt_rounded, color: Color(0xFFF59E0B), gradient: [Color(0xFFF59E0B), Color(0xFFD97706)]),
        _NetworkStatCard(
          title: "Network Sales",
          value: "₹2.31L",
          change: "+18% this month",
          icon: Icons.trending_up_rounded,
          color: Color(0xFFEF4444),
          gradient: [Color(0xFFEF4444), Color(0xFFDC2626)],
        ),
      ],
    );
  }

  Widget _buildNetworkTables() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _NetworkTableCard(
                title: "My Networks",
                subtitle: "Networks where I am the owner",
                actionText: "View All",
                icon: Icons.business_rounded,
                color: Color(0xFF0E5E83),
                rows: [
                  _buildNetworkRow('SM Garments Channel', 'Manufacturer → Distributor → Retailer', '18 members', '₹1,20,000', Icons.storefront_rounded, Color(0xFF0E5E83)),
                  _buildNetworkRow('ElectroParts Dealer Net', 'Manufacturer → Dealer', '9 members', '₹72,500', Icons.electrical_services_rounded, Color(0xFF10B981)),
                  _buildNetworkRow('Service Franchise West', 'Service Network', '6 members', '₹38,200', Icons.miscellaneous_services_rounded, Color(0xFFF59E0B)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _NetworkTableCard(
                title: "Joined Networks",
                subtitle: "Networks where I am a member",
                actionText: "2 Requests",
                icon: Icons.group_work_rounded,
                color: Color(0xFFE67E22),
                rows: [
                  _buildJoinedNetworkRow('Alpha Home Appliances', 'Distributor', 'Sumit Sharma', '₹26,800', Icons.kitchen_rounded, Color(0xFF8B5CF6)),
                  _buildJoinedNetworkRow('SM Construction Supply', 'Retailer', 'Saving Mantra', '₹14,200', Icons.construction_rounded, Color(0xFF0E5E83)),
                  _buildJoinedNetworkRow('Ayurveda Wellness Sellers', 'Reseller', 'Aditi Legal & Biz', '₹9,700', Icons.spa_rounded, Color(0xFF10B981)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNetworkRow(String name, String type, String members, String sales, IconData icon, Color color) {
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
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
                const SizedBox(height: 4),
                Text(type, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.people_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(members, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    const SizedBox(width: 12),
                    Icon(Icons.attach_money_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      sales,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF059669)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'Manage',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinedNetworkRow(String network, String role, String owner, String lastOrder, IconData icon, Color color) {
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
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  network,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0xFFE67E22).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFFE67E22)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'by $owner',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.shopping_cart_rounded, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      'Last order: $lastOrder',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF059669)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text(
              'View',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesWithNetwork() {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Network Transactions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                    ),
                    const SizedBox(height: 4),
                    Text("Sales, purchases and accounting activities within your networks", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    _ActionButton(icon: Icons.receipt_long_rounded, text: "New Invoice", onTap: () {}),
                    _ActionButton(icon: Icons.shopping_cart_rounded, text: "Sales Order", onTap: () {}),
                    _ActionButton(icon: Icons.analytics_rounded, text: "View Ledger", onTap: () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._buildTransactionItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransactionItems() {
    final transactions = [
      _TransactionItem(
        date: "30 Oct 2025",
        network: "SM Garments Channel",
        member: "Star Distributors Pune",
        type: "Sales Invoice",
        amount: "₹48,000",
        status: "Posted",
        reference: "INV-25-1030",
        icon: Icons.receipt_long_rounded,
        color: Color(0xFF0E5E83),
      ),
      _TransactionItem(
        date: "29 Oct 2025",
        network: "ElectroParts Dealer Net",
        member: "Gujarat Electricals",
        type: "Sales Order",
        amount: "₹23,500",
        status: "Pending",
        reference: "SO-25-128",
        icon: Icons.shopping_cart_rounded,
        color: Color(0xFFF59E0B),
      ),
      _TransactionItem(
        date: "28 Oct 2025",
        network: "Service Franchise West",
        member: "Thane Service Point",
        type: "Receipt",
        amount: "₹9,500",
        status: "Posted",
        reference: "RCPT-25-090",
        icon: Icons.payment_rounded,
        color: Color(0xFF10B981),
      ),
    ];

    return transactions.map((transaction) => transaction).toList();
  }

  Widget _buildFooter() {
    return Center(
      child: Text('© ${DateTime.now().year} Saving Mantra — Network Module', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool primary;

  const _HeaderActionButton({required this.icon, required this.text, required this.onTap, required this.primary});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary ? const Color(0xFFE67E22) : Colors.white,
        foregroundColor: primary ? Colors.white : const Color(0xFF0E5E83),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: primary ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
        ),
        elevation: primary ? 2 : 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _NetworkStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
  final List<Color> gradient;

  const _NetworkStatCard({required this.title, required this.value, required this.change, required this.icon, required this.color, required this.gradient});

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

class _NetworkTableCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String actionText;
  final IconData icon;
  final Color color;
  final List<Widget> rows;

  const _NetworkTableCard({required this.title, required this.subtitle, required this.actionText, required this.icon, required this.color, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                      Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    actionText,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF0E5E83)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String date;
  final String network;
  final String member;
  final String type;
  final String amount;
  final String status;
  final String reference;
  final IconData icon;
  final Color color;

  const _TransactionItem({
    required this.date,
    required this.network,
    required this.member,
    required this.type,
    required this.amount,
    required this.status,
    required this.reference,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                    ),
                    const Spacer(),
                    Text(
                      amount,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF059669)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('$network • $member', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(date, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                    const SizedBox(width: 12),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      reference,
                      style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: status == "Posted" ? const Color(0xFFE5F6ED) : const Color(0xFFFFF7E5), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        status,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: status == "Posted" ? const Color(0xFF15803D) : const Color(0xFF92400E)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
