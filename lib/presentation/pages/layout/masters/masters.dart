import 'package:flutter/material.dart';

class MastersPage extends StatelessWidget {
  const MastersPage({super.key});

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
            _buildMasterCategories(),
            const SizedBox(height: 32),
            _buildRecentActivity(),
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
        Text(
          "Accounting · Masters",
          style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          "Master Data Management",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: const Color(0xFF111827)),
        ),
        const SizedBox(height: 8),
        Text(
          "Manage your chart of accounts, customers, vendors, items and other master records",
          style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.1,
      children: const [
        _StatCard(title: "Total Accounts", value: "142", change: "+5 this month", icon: Icons.account_balance_rounded, color: Color(0xFF10B981)),
        _StatCard(title: "Customers", value: "89", change: "+2 new", icon: Icons.people_alt_rounded, color: Color(0xFF3B82F6)),
        _StatCard(title: "Vendors", value: "67", change: "+1 new", icon: Icons.business_rounded, color: Color(0xFFF59E0B)),
        _StatCard(title: "Items/Products", value: "234", change: "+12 added", icon: Icons.inventory_2_rounded, color: Color(0xFFEF4444)),
      ],
    );
  }

  Widget _buildMasterCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Master Categories",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 2.4,
          children: const [
            _MasterCategoryCard(title: "Chart of Accounts", description: "Manage ledger accounts and groups", icon: Icons.account_tree_rounded, count: "142 accounts", color: Color(0xFF0E5E83)),
            _MasterCategoryCard(title: "Customers", description: "Customer master with credit limits", icon: Icons.people_alt_rounded, count: "89 customers", color: Color(0xFF10B981)),
            _MasterCategoryCard(title: "Vendors/Suppliers", description: "Vendor and supplier management", icon: Icons.business_center_rounded, count: "67 vendors", color: Color(0xFFF59E0B)),
            _MasterCategoryCard(title: "Items & Products", description: "Product and service items", icon: Icons.inventory_2_rounded, count: "234 items", color: Color(0xFFEF4444)),
            _MasterCategoryCard(title: "Tax Masters", description: "GST, TDS and other tax configurations", icon: Icons.receipt_long_rounded, count: "8 tax types", color: Color(0xFF8B5CF6)),
            _MasterCategoryCard(title: "Bank Accounts", description: "Bank and cash account masters", icon: Icons.account_balance_rounded, count: "12 accounts", color: Color(0xFF06B6D4)),
            _MasterCategoryCard(title: "Cost Centers", description: "Department and project tracking", icon: Icons.workspaces_rounded, count: "15 centers", color: Color(0xFF84CC16)),
            _MasterCategoryCard(title: "Currencies", description: "Multi-currency configurations", icon: Icons.currency_exchange_rounded, count: "5 currencies", color: Color(0xFFF97316)),
            _MasterCategoryCard(title: "Number Series", description: "Document numbering sequences", icon: Icons.format_list_numbered_rounded, count: "22 series", color: Color(0xFFEC4899)),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Master Updates",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(color: Color(0xFF0E5E83), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _RecentMasterItem(
            title: "New customer added",
            description: "Suyog Enterprises with GSTIN 27AAECS1234N1ZZ",
            type: "Customer",
            time: "2 hours ago",
            icon: Icons.person_add_alt_1_rounded,
          ),
          const _RecentMasterItem(title: "Bank account updated", description: "SBI Current Account - IFSC SBIN0000123", type: "Bank", time: "5 hours ago", icon: Icons.account_balance_rounded),
          const _RecentMasterItem(title: "New product category", description: "Added 'IT Services' under Services category", type: "Item", time: "Yesterday", icon: Icons.category_rounded),
          const _RecentMasterItem(title: "Tax rate modified", description: "GST 18% rate updated for consulting services", type: "Tax", time: "2 days ago", icon: Icons.receipt_long_rounded),
          const _RecentMasterItem(title: "Vendor credit limit", description: "Updated credit limit for Om Traders to ₹5,00,000", type: "Vendor", time: "3 days ago", icon: Icons.business_rounded),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Masters Management", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.change, required this.icon, required this.color});

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasterCategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String count;
  final IconData icon;
  final Color color;

  const _MasterCategoryCard({required this.title, required this.description, required this.count, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      count,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "Manage",
                    style: TextStyle(fontSize: 14, letterSpacing: .5, fontWeight: FontWeight.w600, color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentMasterItem extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final String time;
  final IconData icon;

  const _RecentMasterItem({required this.title, required this.description, required this.type, required this.time, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 20, color: const Color(0xFF0E5E83)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 2),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        type,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
