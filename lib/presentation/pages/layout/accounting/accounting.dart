import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class AccountingPage extends StatelessWidget {
  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Accounting Workspace',
        subtitle: 'Financial management and accounting tools',
        leadingIcon: Icons.account_balance_wallet_outlined,
        customActions: [AppBarActionButton(label: 'New Entry', icon: Icons.add, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildKPIGrid(), const SizedBox(height: 32), _buildMainContentCard(), const SizedBox(height: 40), _buildFooter()]),
      ),
    );
  }

  Widget _buildKPIGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      padding: EdgeInsets.zero,
      children: const [
        _KPICard(title: "Receivables (This Month)", value: "₹ 1,20,400", meta: "Top overdue: Om Traders, Shivam Steel", icon: Icons.arrow_downward_rounded, color: Color(0xFF10B981)),
        _KPICard(title: "Payables (This Month)", value: "₹ 82,150", meta: "Vendor bills pending: 3", icon: Icons.arrow_upward_rounded, color: Color(0xFFEF4444)),
        _KPICard(title: "Bank Reconciliation", value: "3 accounts", meta: "Last upload: 29-Oct-2025", icon: Icons.account_balance_rounded, color: Color(0xFF3B82F6)),
      ],
    );
  }

  Widget _buildMainContentCard() {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF0E5E83), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Accounting Workspace",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Pick a master to maintain ledgers, items and customers, then record transactions. "
                        "Use GST & TDS panels for statutory entries.",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 32),
            Text(
              "Recently Worked On",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
            ),
            const SizedBox(height: 16),
            _buildRecentItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF111827)),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _QuickActionButton(text: "Create Invoice", icon: Icons.receipt_rounded, onTap: () {}),
            _QuickActionButton(text: "Record Payment", icon: Icons.payment_rounded, onTap: () {}),
            _QuickActionButton(text: "Bank Reconciliation", icon: Icons.account_balance_rounded, onTap: () {}),
            _QuickActionButton(text: "GST Filing", icon: Icons.description_rounded, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentItems() {
    return Column(
      children: const [
        _RecentItem(text: "Invoice #SM/INV/1025 — ₹ 15,800 — Customer: Suyog Enterprises", time: "2 hours ago"),
        _RecentItem(text: "Customer: Nandini Ventures (updated GSTIN)", time: "5 hours ago"),
        _RecentItem(text: "Bank: SBI Current — 52 entries pending mapping", time: "Yesterday"),
      ],
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Accounting Module", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String meta;
  final IconData icon;
  final Color color;

  const _KPICard({required this.title, required this.value, required this.meta, required this.icon, required this.color});

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
              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 8),
            Text(
              meta,
              style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionButton({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0E5E83).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF0E5E83).withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF0E5E83)),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String text;
  final String time;

  const _RecentItem({required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: Color(0xFF0E5E83), shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF111827), fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
