import 'package:flutter/material.dart';

class FinancialServicesPage extends StatefulWidget {
  const FinancialServicesPage({super.key});

  @override
  State<FinancialServicesPage> createState() =>
      _FinancialServicesPageState();
}

class _FinancialServicesPageState extends State<FinancialServicesPage> {
  String activeTab = "Child Plan";

  final List<String> financialTabs = const [
    "Child Plan",
    "Investments",
    "Insurance",
    "Loans",
    "Retirement Plan",
    "Mutual Funds",
  ];

  final Map<String, List<_FinancialProduct>> sampleData = {
    "Child Plan": [
      _FinancialProduct(
        date: "15-Mar-2025",
        name: "HDFC YoungStar Super",
        status: "Active",
        amount: "₹ 1,20,000",
        provider: "HDFC Life",
      ),
      _FinancialProduct(
        date: "01-Apr-2025",
        name: "LIC Jeevan Tarun",
        status: "Active",
        amount: "₹ 90,000",
        provider: "LIC",
      ),
    ],
    "Investments": [
      _FinancialProduct(
        date: "10-Oct-2025",
        name: "Fixed Deposit",
        status: "Active",
        amount: "₹ 5,00,000",
        provider: "HDFC Bank",
      ),
      _FinancialProduct(
        date: "15-Sep-2025",
        name: "Corporate Bonds",
        status: "Matured",
        amount: "₹ 3,00,000",
        provider: "AAA PSU",
      ),
    ],
    "Insurance": [
      _FinancialProduct(
        date: "20-Nov-2025",
        name: "Term Life Insurance",
        status: "Active",
        amount: "₹ 50,00,000",
        provider: "ICICI Pru",
      ),
    ],
  };

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

            _buildKPISection(),
            const SizedBox(height: 32),

            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.savings_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Financial Planner Dashboard',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your investments, insurance, and financial goals in one place',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Row(
              children: [
                _buildHeaderButton(
                  icon: Icons.download_outlined,
                  text: 'Export Report',
                  isPrimary: false,
                ),
                const SizedBox(width: 12),
                _buildHeaderButton(
                  icon: Icons.add,
                  text: 'New Investment',
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({required IconData icon, required String text, required bool isPrimary}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isPrimary ? null : Colors.white,
        gradient: isPrimary 
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)],
              )
            : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPrimary ? Colors.transparent : const Color(0xFFE5E7EB)
        ),
        boxShadow: isPrimary 
            ? [
                BoxShadow(
                  color: const Color(0xFF0E5E83).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, 
            color: isPrimary ? Colors.white : const Color(0xFF6B7280), 
            size: 16
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isPrimary ? Colors.white : const Color(0xFF374151),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPISection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildKPIItem(
            'Portfolio Value',
            '₹ 28.5L',
            Icons.trending_up_outlined,
            const Color(0xFF10B981),
            '+4.2% this quarter',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Active Policies',
            '17',
            Icons.description_outlined,
            const Color(0xFF3B82F6),
            '3 renewals due',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Upcoming Maturities',
            '4',
            Icons.calendar_today_outlined,
            const Color(0xFFF59E0B),
            '₹ 2.4L expected',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Goals Tracking',
            '3',
            Icons.flag_outlined,
            const Color(0xFF8B5CF6),
            '58% completed',
          ),
        ],
      ),
    );
  }

  Widget _buildKPIItem(String title, String value, IconData icon, Color color, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildFinancialCategories()),
        const SizedBox(width: 24),

        Expanded(flex: 3, child: _buildFinancialProductsStatus()),
      ],
    );
  }

  Widget _buildFinancialCategories() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E5E83).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.category_outlined,
                  color: Color(0xFF0E5E83),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Financial Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Explore and apply for different financial products',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 20),

          _buildProductsGrid(),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0E5E83).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Apply for Financial Service',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    final products = [
      _ProductCategory('Child Plan', Icons.child_care_outlined),
      _ProductCategory('Investments', Icons.trending_up_outlined),
      _ProductCategory('Insurance', Icons.security_outlined),
      _ProductCategory('Loans', Icons.credit_card_outlined),
      _ProductCategory('Retirement', Icons.emoji_people_outlined),
      _ProductCategory('Mutual Funds', Icons.attach_money_outlined),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E5E83).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(product.icon, size: 16, color: const Color(0xFF0E5E83)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFinancialProductsStatus() {
    final products = sampleData[activeTab] ?? [];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E5E83).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.timeline_outlined,
                  color: Color(0xFF0E5E83),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Financial Products Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF0E5E83).withOpacity(0.2),
                  ),
                ),
                child: Text(
                  '${products.length} Products',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0E5E83),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: financialTabs.map((tab) {
                final bool selected = tab == activeTab;
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      tab,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF374151),
                      ),
                    ),
                    selected: selected,
                    onSelected: (bool selected) {
                      setState(() {
                        activeTab = tab;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF0E5E83),
                    side: BorderSide(
                      color: selected
                          ? const Color(0xFF0E5E83)
                          : const Color(0xFFD1D5DB),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          _buildFinancialTable(products),
        ],
      ),
    );
  }

  Widget _buildFinancialTable(List<_FinancialProduct> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
          columns: const [
            DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Start Date', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Product Name', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Provider', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.w700))),
          ],
          rows: products.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;
            return DataRow(
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(product.date)),
                DataCell(Text(product.name)),
                DataCell(Text(product.provider)),
                DataCell(Text(product.amount)),
                DataCell(_buildStatusBadge(product.status)),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E5E83).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Color(0xFF0E5E83),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case "Active":
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case "Pending":
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        icon = Icons.pending_outlined;
        break;
      case "Matured":
        bgColor = const Color(0xFFE0F2FE);
        textColor = const Color(0xFF075985);
        icon = Icons.event_available_outlined;
        break;
      default:
        bgColor = const Color(0xFFE5E7EB);
        textColor = const Color(0xFF374151);
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FinancialProduct {
  final String date;
  final String name;
  final String status;
  final String amount;
  final String provider;

  const _FinancialProduct({
    required this.date,
    required this.name,
    required this.status,
    required this.amount,
    required this.provider,
  });
}

class _ProductCategory {
  final String name;
  final IconData icon;

  const _ProductCategory(this.name, this.icon);
}