import 'package:flutter/material.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

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
            _buildAdvisorSection(),
            const SizedBox(height: 32),
            _buildServicesSection(),
            const SizedBox(height: 32),
            _buildRecentActivity(),
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
          'Welcome back, Anupam 👋',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Here\'s what\'s happening with your business today',
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
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
          _buildStatItem(
            'Active Clients',
            '24',
            Icons.people_outline,
            const Color(0xFF10B981),
          ),
          const SizedBox(width: 24),
          _buildStatItem(
            'Pending Tasks',
            '12',
            Icons.task_outlined,
            const Color(0xFFF59E0B),
          ),
          const SizedBox(width: 24),
          _buildStatItem(
            'Revenue',
            '₹1.2L',
            Icons.trending_up_outlined,
            const Color(0xFFEF4444),
          ),
          const SizedBox(width: 24),
          _buildStatItem(
            'Completion',
            '85%',
            Icons.check_circle_outline,
            const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    IconData icon,
    Color color,
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
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvisorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expert Advisors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF0E5E83),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _AdvisorCard(
                label: 'HR Advisor',
                icon: Icons.people_alt,
                description: 'HR & Team Management',
              ),
              _AdvisorCard(
                label: 'Financial Planner',
                icon: Icons.account_balance_wallet_outlined,
                description: 'Financial Planning',
              ),
              _AdvisorCard(
                label: 'Digital Marketing',
                icon: Icons.campaign_outlined,
                description: 'Online Marketing',
              ),
              _AdvisorCard(
                label: 'Import-Export',
                icon: Icons.public_outlined,
                description: 'International Trade',
              ),
              _AdvisorCard(
                label: 'E-commerce',
                icon: Icons.storefront_outlined,
                description: 'Online Business',
              ),
              _AdvisorCard(
                label: 'Business Coach',
                icon: Icons.record_voice_over_outlined,
                description: 'Strategy & Growth',
              ),
              _AdvisorCard(
                label: 'Virtual CFO',
                icon: Icons.work_outline,
                description: 'Financial Management',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Business Services & Solutions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Explore All',
                style: TextStyle(
                  color: Color(0xFF0E5E83),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: const [
            _ServiceCategoryCard(
              title: 'Services in India',
              items: ['Registrations', 'Compliances', 'Legal', 'Tax'],
              icon: Icons.business_outlined,
            ),
            _ServiceCategoryCard(
              title: 'Business Verticals',
              items: ['Proprietor', 'Partnership & LLP', 'Private Limited'],
              icon: Icons.architecture_outlined,
            ),
            _ServiceCategoryCard(
              title: 'NRI Services',
              items: ['Financial Services', 'Legal', 'Tax'],
              icon: Icons.flight_outlined,
            ),
            _ServiceCategoryCard(
              title: 'Global Services',
              items: ['Import Services', 'Export Services', 'Refund Abroad'],
              icon: Icons.public_outlined,
            ),
            _ServiceCategoryCard(
              title: 'GrowthX Services',
              items: ['Business Expansion', 'Franchise Setup', 'Marketing'],
              icon: Icons.trending_up_outlined,
            ),
            _ServiceCategoryCard(
              title: 'Compliance Services',
              items: ['GST Filing', 'Income Tax', 'ROC Compliance'],
              icon: Icons.verified_outlined,
            ),
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
          Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'New client registration completed',
            '2 hours ago',
            Icons.person_add_alt_1,
          ),
          _buildActivityItem(
            'GST filing submitted',
            '5 hours ago',
            Icons.description_outlined,
          ),
          _buildActivityItem(
            'Meeting with financial advisor',
            'Yesterday',
            Icons.calendar_today,
          ),
          _buildActivityItem(
            'Business compliance updated',
            '2 days ago',
            Icons.verified_outlined,
          ),
          _buildActivityItem(
            'New lead from website',
            '3 days ago',
            Icons.leaderboard_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0E5E83).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF0E5E83)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvisorCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final String description;

  const _AdvisorCard({
    required this.label,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Container(
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
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E5E83).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: const Color(0xFF0E5E83), size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceCategoryCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;

  const _ServiceCategoryCard({
    required this.title,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                    child: Icon(icon, size: 20, color: const Color(0xFF0E5E83)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...items.map(
                (label) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0E5E83),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF374151),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF0E5E83).withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text(
                    'Explore Services',
                    style: TextStyle(
                      color: Color(0xFF0E5E83),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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
