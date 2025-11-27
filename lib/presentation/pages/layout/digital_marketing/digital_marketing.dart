import 'package:flutter/material.dart';

class DigitalMarketingPage extends StatefulWidget {
  const DigitalMarketingPage({super.key});

  @override
  State<DigitalMarketingPage> createState() =>
      _DigitalMarketingPageState();
}

class _DigitalMarketingPageState
    extends State<DigitalMarketingPage> {
  String activeTab = "All Campaigns";
  String selectedChannel = "All Channels";
  String selectedPackage = "All Packages";

  final List<String> campaignTabs = const [
    "All Campaigns",
    "Active",
    "Completed",
    "Draft",
  ];

  final List<String> channels = const [
    "All Channels",
    "Facebook",
    "Instagram",
    "Google Ads",
    "LinkedIn",
    "YouTube",
  ];

  final List<String> packages = const [
    "All Packages",
    "Starter Pack",
    "Growth Pack",
    "Enterprise Pack",
  ];

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

            _buildFiltersSection(),
            const SizedBox(height: 24),

            _buildCampaignPerformance(),

            const SizedBox(height: 40),
            const Center(
              child: Text(
                "© 2025 Saving Mantra — Digital Marketing Module",
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ),
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
                Icons.trending_up_outlined,
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
                    'Digital Marketing Dashboard',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage campaigns, track performance, and analyze marketing metrics',
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
                  text: 'New Campaign',
                  isPrimary: true,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required String text,
    required bool isPrimary,
  }) {
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
          color: isPrimary ? Colors.transparent : const Color(0xFFE5E7EB),
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
          Icon(
            icon,
            color: isPrimary ? Colors.white : const Color(0xFF6B7280),
            size: 16,
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
            'Active Campaigns',
            '12',
            Icons.campaign_outlined,
            const Color(0xFF3B82F6),
            '+2 from last month',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Ad Spend (This Month)',
            '₹ 1,25,000',
            Icons.currency_rupee_outlined,
            const Color(0xFF10B981),
            '15% over budget',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Leads Generated',
            '346',
            Icons.people_outline,
            const Color(0xFFF59E0B),
            '42% conversion rate',
          ),
          const SizedBox(width: 24),
          _buildKPIItem(
            'Avg Cost Per Lead',
            '₹ 361',
            Icons.trending_up_outlined,
            const Color(0xFFEF4444),
            '8% lower than target',
          ),
        ],
      ),
    );
  }

  Widget _buildKPIItem(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
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

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  Icons.filter_alt_outlined,
                  color: Color(0xFF0E5E83),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Filters & Analytics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 900;
              return Column(
                children: [
                  _buildFilterRow(),
                  const SizedBox(height: 16),
                  _buildAnalyticsCards(isNarrow),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          child: _buildFilterDropdown(
            label: "Date Range",
            value: "This Month",
            items: const [
              "This Month",
              "Last Month",
              "Last Quarter",
              "Custom Range",
            ],
            onChanged: (value) {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFilterDropdown(
            label: "Channel",
            value: selectedChannel,
            items: channels,
            onChanged: (value) {
              setState(() => selectedChannel = value!);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildFilterDropdown(
            label: "Package",
            value: selectedPackage,
            items: packages,
            onChanged: (value) {
              setState(() => selectedPackage = value!);
            },
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF0E5E83),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Apply Filter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D5DB)),
          ),
          child: DropdownButton<String>(
            value: value,
            iconSize: 20,
            isExpanded: true,
            underline: const SizedBox(),
            style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsCards(bool isNarrow) {
    return isNarrow
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnalyticsCard(
                title: 'Leads Funnel',
                items: const [
                  ['Interested', '180'],
                  ['In Progress', '95'],
                  ['Not Answered', '40'],
                  ['Converted', '28'],
                  ['Visited', '18'],
                ],
              ),
              const SizedBox(height: 16),
              _buildAnalyticsCard(
                title: 'Channel Performance',
                items: const [
                  ['Facebook', '45%'],
                  ['Instagram', '30%'],
                  ['Google Ads', '15%'],
                  ['Others', '10%'],
                ],
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  title: 'Leads Funnel',
                  items: const [
                    ['Interested', '180'],
                    ['In Progress', '95'],
                    ['Not Answered', '40'],
                    ['Converted', '28'],
                    ['Visited', '18'],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildAnalyticsCard(
                  title: 'Channel Performance',
                  items: const [
                    ['Facebook', '45%'],
                    ['Instagram', '30%'],
                    ['Google Ads', '15%'],
                    ['Others', '10%'],
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildAnalyticsCard({
    required String title,
    required List<List<String>> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((row) {
            final last = row == items.last;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: last
                    ? null
                    : const Border(
                        bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                      ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    row[0],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                  Text(
                    row[1],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCampaignPerformance() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  Icons.bar_chart_outlined,
                  color: Color(0xFF0E5E83),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Campaign Performance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
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
                child: const Text(
                  '12 Campaigns',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0E5E83),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: campaignTabs.map((tab) {
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

          _buildCampaignTable(),
        ],
      ),
    );
  }

  Widget _buildCampaignTable() {
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
            DataColumn(
              label: Text(
                'Campaign',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Client',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Channels',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Duration',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Budget',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Leads',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text('CPL', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            DataColumn(
              label: Text(
                'Action',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
          rows: const [
            DataRow(
              cells: [
                DataCell(Text('Diwali Lead Gen')),
                DataCell(Text('ABC Traders')),
                DataCell(Text('Facebook, Instagram')),
                DataCell(Text('01 Oct – 31 Oct')),
                DataCell(Text('₹ 50,000')),
                DataCell(Text('120')),
                DataCell(Text('₹ 416')),
                DataCell(_StatusBadge(status: 'Running')),
                DataCell(_ActionButton()),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Winter Sale')),
                DataCell(Text('XYZ Stores')),
                DataCell(Text('Google Ads')),
                DataCell(Text('15 Nov – 15 Dec')),
                DataCell(Text('₹ 75,000')),
                DataCell(Text('85')),
                DataCell(Text('₹ 882')),
                DataCell(_StatusBadge(status: 'Draft')),
                DataCell(_ActionButton()),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Brand Awareness')),
                DataCell(Text('Global Corp')),
                DataCell(Text('LinkedIn, YouTube')),
                DataCell(Text('01 Sep – 30 Sep')),
                DataCell(Text('₹ 1,00,000')),
                DataCell(Text('210')),
                DataCell(Text('₹ 476')),
                DataCell(_StatusBadge(status: 'Completed')),
                DataCell(_ActionButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case "Running":
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        icon = Icons.play_arrow_outlined;
        break;
      case "Completed":
        bgColor = const Color(0xFFE0F2FE);
        textColor = const Color(0xFF075985);
        icon = Icons.check_circle_outline;
        break;
      case "Draft":
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        icon = Icons.edit_outlined;
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

class _ActionButton extends StatelessWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
