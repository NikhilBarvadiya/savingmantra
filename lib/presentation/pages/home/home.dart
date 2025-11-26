import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/home/opportunity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F5),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Sidebar(),
            Expanded(child: _DashboardContent()),
          ],
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(blurRadius: 16, offset: Offset(2, 0), color: Color(0x11000000))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(color: const Color(0xFF0E5E83), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.savings_outlined, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Saving Mantra',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SidebarSection(title: 'OVERVIEW', items: ['Client Dashboard', 'Opportunities']),
                  _SidebarSection(title: 'SERVICES', items: ['Registrations', 'Compliances', 'Legal', 'Tax']),
                  _SidebarSection(title: 'ACCOUNTING', items: ['Books', 'Invoicing', 'Payroll']),
                  _SidebarSection(title: 'NETWORKING', items: ['Business Network', 'Referrals']),
                  _SidebarSection(title: 'CRM', items: ['Leads', 'Follow-ups']),
                  _SidebarSection(title: 'BOOKING', items: ['Appointments', 'Events']),
                  _SidebarSection(title: 'DAILY TOOLS', items: ['Tasks', 'Notes', 'Calculators']),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Anupam',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.logout, size: 18),
                  onPressed: null, // TODO: hook logout later
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _SidebarSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 11, letterSpacing: 0.8, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF)),
            ),
          ),
          const SizedBox(height: 4),
          ...items.map((label) => _SidebarItem(label: label)),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;

  const _SidebarItem({required this.label});

  @override
  Widget build(BuildContext context) {
    final bool isActive = label == 'Client Dashboard';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (label == "Opportunities") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OpportunityPage()));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: isActive ? const Color(0xFFE5F3F8) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Icon(Icons.circle, size: 6, color: isActive ? const Color(0xFF0E5E83) : const Color(0xFFCBD5E1)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 13, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400, color: isActive ? const Color(0xFF0E5E83) : const Color(0xFF111827)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MAIN CONTENT =================

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F4F5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back, Anupam 👋', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Choose an advisor or service to get started.', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
            const SizedBox(height: 24),

            // Advisor row
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _AdvisorCard(label: 'HR Advisor', icon: Icons.people_alt),
                  _AdvisorCard(label: 'Financial Planner', icon: Icons.account_balance_wallet_outlined),
                  _AdvisorCard(label: 'Digital Marketing', icon: Icons.campaign_outlined),
                  _AdvisorCard(label: 'Import-Export', icon: Icons.public_outlined),
                  _AdvisorCard(label: 'E-com', icon: Icons.storefront_outlined),
                  _AdvisorCard(label: 'Business Coach', icon: Icons.record_voice_over_outlined),
                  _AdvisorCard(label: 'Virtual CFO', icon: Icons.work_outline),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text('Business Services & Solutions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),

            // Services grid – approximate the table from your screenshot
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _ServiceCategoryCard(title: 'Services in India', items: ['Registrations', 'Compliances', 'Legal', 'Tax']),
                _ServiceCategoryCard(title: 'Business Verticals', items: ['Proprietor', 'Partnership & LLP', 'Private Limited']),
                _ServiceCategoryCard(title: 'NRI Services', items: ['Financial Services', 'Legal', 'Tax']),
                _ServiceCategoryCard(title: 'Global Services', items: ['Import Services', 'Export Services', 'Refund Abroad']),
                _ServiceCategoryCard(title: 'GrowthX Services', items: ['Business Expansion', 'Franchise Setup', 'Marketing']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvisorCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const _AdvisorCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 1.5,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: open respective module
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFE5F3F8),
                  child: Icon(icon, color: const Color(0xFF0E5E83), size: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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

  const _ServiceCategoryCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              ...items.map(
                (label) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 6, color: Color(0xFF0E5E83)),
                      const SizedBox(width: 6),
                      Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
                    ],
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
