import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class BusinessPlansPage extends StatelessWidget {
  const BusinessPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      appBar: CustomAppBar(
        title: 'Biz Plan',
        subtitle: 'Business planning and strategy',
        leadingIcon: Icons.lightbulb_outline,
        customActions: [
          AppBarActionButton(label: 'Download Report', icon: Icons.download, onPressed: () {}),
          const SizedBox(width: 8),
          AppBarActionButton(label: 'New Business Plan', icon: Icons.add, onPressed: () {}, isPrimary: true),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: SingleChildScrollView(padding: EdgeInsets.all(16), child: _Content()),
          ),
          _Footer(),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(children: const [_StatsOverview(), SizedBox(height: 24), _QuickActions(), SizedBox(height: 24), _BusinessPlansSection(), SizedBox(height: 24), _AnalyticsSection()]);
  }
}

class _StatsOverview extends StatelessWidget {
  const _StatsOverview();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      childAspectRatio: 2.4,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _StatCard(title: 'Total Plans', value: '24', color: Color(0xFF0E5E83), icon: Icons.assignment, trend: '+12%'),
        _StatCard(title: 'Active Plans', value: '18', color: Color(0xFF10B981), icon: Icons.check_circle, trend: '+5%'),
        _StatCard(title: 'In Progress', value: '5', color: Color(0xFFF59E0B), icon: Icons.trending_up, trend: '+2'),
        _StatCard(title: 'Completed', value: '12', color: Color(0xFF8B5CF6), icon: Icons.flag, trend: '+8'),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final String trend;

  const _StatCard({required this.title, required this.value, required this.color, required this.icon, required this.trend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(
                  trend,
                  style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _QuickActionItem(icon: Icons.add_chart, label: 'Create Plan', color: Color(0xFF0E5E83), onTap: () {}),
              const SizedBox(width: 16),
              _QuickActionItem(icon: Icons.analytics, label: 'View Analytics', color: Color(0xFF10B981), onTap: () {}),
              const SizedBox(width: 16),
              _QuickActionItem(icon: Icons.assignment, label: 'Templates', color: Color(0xFFF59E0B), onTap: () {}),
              const SizedBox(width: 16),
              _QuickActionItem(icon: Icons.share, label: 'Share Plans', color: Color(0xFF8B5CF6), onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionItem({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BusinessPlansSection extends StatelessWidget {
  const _BusinessPlansSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Business Plans',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
              ),
            ),
            _ActionButton(label: 'Filter Plans', icon: Icons.filter_list, onPressed: () {}, small: true),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 4.0,
          children: const [
            _BusinessPlanCard(
              title: 'Market Expansion Plan',
              description: 'Expand operations to 3 new cities with detailed market analysis',
              progress: 75,
              status: 'Execution',
              timeline: 'Q4 2025',
              budget: '₹25,00,000',
              members: 5,
            ),
            _BusinessPlanCard(
              title: 'Product Launch Strategy',
              description: 'Launch new SaaS product with go-to-market strategy',
              progress: 40,
              status: 'Planning',
              timeline: 'Q1 2026',
              budget: '₹18,00,000',
              members: 8,
            ),
            _BusinessPlanCard(
              title: 'Revenue Growth Plan',
              description: 'Achieve 50% revenue growth through new client acquisition',
              progress: 90,
              status: 'Review',
              timeline: 'Q3 2025',
              budget: '₹12,00,000',
              members: 3,
            ),
            _BusinessPlanCard(
              title: 'Operational Efficiency',
              description: 'Reduce operational costs by 20% through process optimization',
              progress: 60,
              status: 'Execution',
              timeline: 'Q2 2026',
              budget: '₹8,00,000',
              members: 6,
            ),
          ],
        ),
      ],
    );
  }
}

class _BusinessPlanCard extends StatelessWidget {
  final String title;
  final String description;
  final int progress;
  final String status;
  final String timeline;
  final String budget;
  final int members;

  const _BusinessPlanCard({required this.title, required this.description, required this.progress, required this.status, required this.timeline, required this.budget, required this.members});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                    ),
                  ),
                  _StatusBadge(status: status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$progress% Complete', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  const SizedBox(height: 6),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(3)),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress / 100,
                      child: Container(
                        decoration: BoxDecoration(color: _getProgressColor(progress), borderRadius: BorderRadius.circular(3)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _PlanDetailItem(icon: Icons.people, value: '$members'),
                  const SizedBox(width: 16),
                  _PlanDetailItem(icon: Icons.calendar_today, value: timeline),
                  const SizedBox(width: 16),
                  _PlanDetailItem(icon: Icons.attach_money, value: budget),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(int progress) {
    if (progress >= 75) return const Color(0xFF10B981);
    if (progress >= 50) return const Color(0xFF0E5E83);
    if (progress >= 25) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}

class _PlanDetailItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _PlanDetailItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF6B7280)),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      ],
    );
  }
}

class _AnalyticsSection extends StatelessWidget {
  const _AnalyticsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Analytics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          childAspectRatio: 2.0,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _AnalyticsCard(title: 'Plan Completion Rate', value: '78%', subtitle: 'Across all business plans', color: Color(0xFF10B981), icon: Icons.check_circle_outline),
            _AnalyticsCard(title: 'Avg. Timeline', value: '4.2 Months', subtitle: 'Per business plan', color: Color(0xFF0E5E83), icon: Icons.schedule),
            _AnalyticsCard(title: 'Team Engagement', value: '92%', subtitle: 'Active participation rate', color: Color(0xFF8B5CF6), icon: Icons.people_alt),
            _AnalyticsCard(title: 'Budget Adherence', value: '88%', subtitle: 'Within planned budget', color: Color(0xFFF59E0B), icon: Icons.attach_money),
          ],
        ),
      ],
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final IconData icon;

  const _AnalyticsCard({required this.title, required this.value, required this.subtitle, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('© 2025 Saving Mantra — Business Planning Module', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Help', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Feedback', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text('Support', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool small;
  final VoidCallback onPressed;

  const _ActionButton({required this.label, required this.icon, required this.onPressed, this.small = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0E5E83),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFF0E5E83)),
        padding: small ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      icon: Icon(icon, size: small ? 14 : 16),
      label: Text(
        label,
        style: TextStyle(fontSize: small ? 12 : 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: config.color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, color: config.color, fontWeight: FontWeight.w600),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status) {
    switch (status.toLowerCase()) {
      case 'execution':
        return _StatusConfig('Execution', const Color(0xFF0E5E83));
      case 'planning':
        return _StatusConfig('Planning', const Color(0xFFF59E0B));
      case 'review':
        return _StatusConfig('Review', const Color(0xFF8B5CF6));
      case 'completed':
        return _StatusConfig('Completed', const Color(0xFF10B981));
      default:
        return _StatusConfig(status, const Color(0xFF6B7280));
    }
  }
}

class _StatusConfig {
  final String text;
  final Color color;

  _StatusConfig(this.text, this.color);
}
