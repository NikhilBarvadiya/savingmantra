import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeaderWithExport(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFinancialMetrics(),
                  const SizedBox(height: 32),
                  _buildReportsCategories(),
                  const SizedBox(height: 32),
                  _buildRecentReports(),
                  const SizedBox(height: 40),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithExport() {
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
                  "Accounting · Reports & Analytics",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  "Financial Reports & Insights",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _ReportActionButton(icon: Icons.calendar_today_rounded, text: "Nov 2025", onTap: () {}),
              const SizedBox(width: 12),
              _ReportActionButton(icon: Icons.download_rounded, text: "Export", onTap: () {}),
              const SizedBox(width: 12),
              _ReportActionButton(icon: Icons.print_rounded, text: "Print", onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetrics() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.4,
      children: const [
        _FinancialMetricCard(title: "Total Revenue", value: "₹ 8,42,150", change: "+12.5% vs last month", trend: "up", icon: Icons.trending_up_rounded, color: Color(0xFF10B981)),
        _FinancialMetricCard(title: "Net Profit", value: "₹ 1,84,320", change: "+8.2% vs last month", trend: "up", icon: Icons.attach_money_rounded, color: Color(0xFF059669)),
        _FinancialMetricCard(title: "Operating Expenses", value: "₹ 6,57,830", change: "+5.1% vs last month", trend: "up", icon: Icons.trending_up_rounded, color: Color(0xFFEF4444)),
        _FinancialMetricCard(title: "Profit Margin", value: "21.9%", change: "+2.3% vs last month", trend: "up", icon: Icons.percent_rounded, color: Color(0xFF8B5CF6)),
      ],
    );
  }

  Widget _buildReportsCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Financial Reports",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 2.1,
          children: const [
            _ReportCategoryCard(
              title: "Profit & Loss",
              description: "Income statement and profitability analysis",
              icon: Icons.bar_chart_rounded,
              count: "Last 12 months",
              color: Color(0xFF0E5E83),
              reportType: "P&L",
            ),
            _ReportCategoryCard(
              title: "Balance Sheet",
              description: "Assets, liabilities and equity statement",
              icon: Icons.pie_chart_rounded,
              count: "As of 30 Nov 2025",
              color: Color(0xFF10B981),
              reportType: "Balance",
            ),
            _ReportCategoryCard(
              title: "Cash Flow",
              description: "Operating, investing and financing activities",
              icon: Icons.show_chart_rounded,
              count: "Monthly summary",
              color: Color(0xFF3B82F6),
              reportType: "Cash",
            ),
            _ReportCategoryCard(
              title: "GST Reports",
              description: "GSTR-1, GSTR-3B and reconciliation",
              icon: Icons.receipt_long_rounded,
              count: "Q3 2025",
              color: Color(0xFFF59E0B),
              reportType: "GST",
            ),
            _ReportCategoryCard(
              title: "TDS Reports",
              description: "TDS deductions and challan details",
              icon: Icons.description_rounded,
              count: "Quarterly",
              color: Color(0xFFEF4444),
              reportType: "TDS",
            ),
            _ReportCategoryCard(
              title: "Trial Balance",
              description: "Debit and credit balance summary",
              icon: Icons.balance_rounded,
              count: "Current period",
              color: Color(0xFF8B5CF6),
              reportType: "Trial",
            ),
            _ReportCategoryCard(
              title: "Aging Analysis",
              description: "Receivables and payables aging",
              icon: Icons.schedule_rounded,
              count: "Overdue: ₹45,800",
              color: Color(0xFFEC4899),
              reportType: "Aging",
            ),
            _ReportCategoryCard(
              title: "Bank Reconciliation",
              description: "Bank statements vs book balances",
              icon: Icons.account_balance_rounded,
              count: "3 accounts pending",
              color: Color(0xFF06B6D4),
              reportType: "Bank",
            ),
            _ReportCategoryCard(
              title: "Tax Reports",
              description: "Income tax and compliance reports",
              icon: Icons.account_balance_wallet_rounded,
              count: "FY 2024-25",
              color: Color(0xFF84CC16),
              reportType: "Tax",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentReports() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recently Generated Reports",
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
          const _RecentReportItem(
            title: "Profit & Loss Statement",
            period: "November 2025",
            generatedBy: "Amit Mishra",
            time: "2 hours ago",
            format: "PDF",
            size: "2.4 MB",
            icon: Icons.picture_as_pdf_rounded,
            color: Color(0xFFEF4444),
          ),
          const _RecentReportItem(
            title: "GSTR-3B Return",
            period: "Quarter 3, 2025",
            generatedBy: "System Auto",
            time: "Yesterday",
            format: "Excel",
            size: "1.8 MB",
            icon: Icons.table_chart_rounded,
            color: Color(0xFF10B981),
          ),
          const _RecentReportItem(
            title: "Balance Sheet",
            period: "As of 30 Nov 2025",
            generatedBy: "Amit Mishra",
            time: "2 days ago",
            format: "PDF",
            size: "3.1 MB",
            icon: Icons.picture_as_pdf_rounded,
            color: Color(0xFFEF4444),
          ),
          const _RecentReportItem(
            title: "Aging Analysis - Receivables",
            period: "Current",
            generatedBy: "System Auto",
            time: "3 days ago",
            format: "Excel",
            size: "1.2 MB",
            icon: Icons.table_chart_rounded,
            color: Color(0xFF10B981),
          ),
          const _RecentReportItem(
            title: "TDS Quarterly Return",
            period: "Q2 2025-26",
            generatedBy: "Amit Mishra",
            time: "1 week ago",
            format: "PDF",
            size: "2.7 MB",
            icon: Icons.picture_as_pdf_rounded,
            color: Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Reports & Analytics", style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _ReportActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ReportActionButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF374151)),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FinancialMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final String trend;
  final IconData icon;
  final Color color;

  const _FinancialMetricCard({required this.title, required this.value, required this.change, required this.trend, required this.icon, required this.color});

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
                Icon(trend == "up" ? Icons.trending_up_rounded : Icons.trending_down_rounded, color: trend == "up" ? const Color(0xFF10B981) : const Color(0xFFEF4444), size: 16),
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
              style: TextStyle(fontSize: 10, color: trend == "up" ? const Color(0xFF10B981) : const Color(0xFFEF4444), fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String count;
  final IconData icon;
  final Color color;
  final String reportType;

  const _ReportCategoryCard({required this.title, required this.description, required this.count, required this.icon, required this.color, required this.reportType});

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
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      reportType,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
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
              const SizedBox(height: 12),
              Text(
                count,
                style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Generate",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.visibility_rounded, color: color, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentReportItem extends StatelessWidget {
  final String title;
  final String period;
  final String generatedBy;
  final String time;
  final String format;
  final String size;
  final IconData icon;
  final Color color;

  const _RecentReportItem({
    required this.title,
    required this.period,
    required this.generatedBy,
    required this.time,
    required this.format,
    required this.size,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 20, color: color),
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
                Text(period, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("By $generatedBy", style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(time, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(6)),
            child: Text(
              format,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
          ),
          const SizedBox(width: 8),
          Text(size, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.download_rounded, size: 18, color: Color(0xFF0E5E83)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
