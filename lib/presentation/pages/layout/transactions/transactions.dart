import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeaderWithFilters(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildQuickStats(), const SizedBox(height: 32), _buildTransactionsList(), const SizedBox(height: 40), _buildFooter()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Accounting · Transactions",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  "Transaction Management",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _FilterButton(icon: Icons.calendar_today_rounded, text: "This Month", onTap: () {}),
              const SizedBox(width: 12),
              _FilterButton(icon: Icons.filter_list_rounded, text: "Filters", onTap: () {}),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.4,
      children: const [
        _TransactionStatCard(title: "Total Transactions", value: "1,248", change: "+42 this week", icon: Icons.receipt_long_rounded, color: Color(0xFF0E5E83)),
        _TransactionStatCard(title: "Income", value: "₹ 2,84,500", change: "+15% from last month", icon: Icons.arrow_downward_rounded, color: Color(0xFF10B981)),
        _TransactionStatCard(title: "Expenses", value: "₹ 1,67,200", change: "+8% from last month", icon: Icons.arrow_upward_rounded, color: Color(0xFFEF4444)),
        _TransactionStatCard(title: "Pending", value: "₹ 45,800", change: "12 transactions", icon: Icons.pending_actions_rounded, color: Color(0xFFF59E0B)),
      ],
    );
  }

  Widget _buildTransactionsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Transaction Details",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Type",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Amount",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Date",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          const _TransactionItem(
            type: "Income",
            description: "Invoice #INV-1025 - Suyog Enterprises",
            amount: "₹ 15,800",
            date: "15 Nov 2025",
            status: "Completed",
            icon: Icons.arrow_downward_rounded,
            color: Color(0xFF10B981),
          ),
          const _TransactionItem(
            type: "Expense",
            description: "Vendor Payment - Om Traders",
            amount: "₹ 8,500",
            date: "14 Nov 2025",
            status: "Completed",
            icon: Icons.arrow_upward_rounded,
            color: Color(0xFFEF4444),
          ),
          const _TransactionItem(
            type: "Income",
            description: "Invoice #INV-1024 - Nandini Ventures",
            amount: "₹ 22,300",
            date: "13 Nov 2025",
            status: "Pending",
            icon: Icons.arrow_downward_rounded,
            color: Color(0xFF10B981),
          ),
          const _TransactionItem(
            type: "Expense",
            description: "Office Supplies - Stationery Mart",
            amount: "₹ 3,200",
            date: "12 Nov 2025",
            status: "Completed",
            icon: Icons.arrow_upward_rounded,
            color: Color(0xFFEF4444),
          ),
          const _TransactionItem(
            type: "Transfer",
            description: "Bank Transfer - SBI to HDFC",
            amount: "₹ 50,000",
            date: "10 Nov 2025",
            status: "Completed",
            icon: Icons.swap_horiz_rounded,
            color: Color(0xFF3B82F6),
          ),
          const _TransactionItem(
            type: "Income",
            description: "Consulting Fees - Project Alpha",
            amount: "₹ 45,000",
            date: "08 Nov 2025",
            status: "Completed",
            icon: Icons.arrow_downward_rounded,
            color: Color(0xFF10B981),
          ),
          const _TransactionItem(
            type: "Expense",
            description: "GST Payment - Q3 2025",
            amount: "₹ 18,750",
            date: "05 Nov 2025",
            status: "Completed",
            icon: Icons.arrow_upward_rounded,
            color: Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Transaction Management", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _FilterButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF374151)),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const _TransactionStatCard({required this.title, required this.value, required this.change, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final String type;
  final String description;
  final String amount;
  final String date;
  final String status;
  final IconData icon;
  final Color color;

  const _TransactionItem({required this.type, required this.description, required this.amount, required this.date, required this.status, required this.icon, required this.color});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return const Color(0xFF10B981);
      case "pending":
        return const Color(0xFFF59E0B);
      case "failed":
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: _getStatusColor(status).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            status,
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _getStatusColor(status)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              type,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color),
            ),
          ),
          Expanded(
            child: Text(
              amount,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: type == "Income"
                    ? const Color(0xFF10B981)
                    : type == "Expense"
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF3B82F6),
              ),
            ),
          ),
          Expanded(
            child: Text(date, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.more_vert_rounded, size: 16, color: Color(0xFF6B7280)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
