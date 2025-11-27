import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class LegalPage extends StatelessWidget {
  const LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Legal',
        subtitle: 'Legal services and contract management',
        leadingIcon: Icons.gavel_outlined,
        customActions: [AppBarActionButton(label: 'Apply Service', icon: Icons.add, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildQuickStats(), const SizedBox(height: 32), _buildMainContent()]),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          _buildStatItem('Active Cases', '8', Icons.cases_outlined, const Color(0xFF3B82F6)),
          const SizedBox(width: 24),
          _buildStatItem('Pending Review', '3', Icons.pending_actions_outlined, const Color(0xFFF59E0B)),
          const SizedBox(width: 24),
          _buildStatItem('Completed', '15', Icons.check_circle_outlined, const Color(0xFF10B981)),
          const SizedBox(width: 24),
          _buildStatItem('Urgent', '2', Icons.warning_amber_outlined, const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildLegalServices()),
        const SizedBox(width: 24),

        Expanded(flex: 2, child: _buildAppliedServices()),
      ],
    );
  }

  Widget _buildLegalServices() {
    final services = [
      _LegalService(category: 'Agreements', description: 'Draft, review and update standard business agreements and MoUs.', useCase: 'Vendor agreement, partnership MoU, NDA.'),
      _LegalService(category: 'Contract', description: 'Detailed contracts for long-term business relationships and projects.', useCase: 'Service contracts, supply contracts, retainers.'),
      _LegalService(category: 'Trending', description: 'New-age legal needs linked to startups and digital businesses.', useCase: 'ESOP agreements, investor term sheets, SaaS policies.'),
      _LegalService(category: 'Real Estate', description: 'Property-related documentation, review and registration support.', useCase: 'Sale deed, lease agreement, leave & license, gift deed.'),
      _LegalService(category: 'Other', description: 'Any customized legal requirement not covered above.', useCase: 'Notice drafting, reply to notice, custom documentation.'),
    ];

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
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.add_circle_outline, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Apply for Legal Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Choose a category to apply for a new legal service. Your Saving Mantra advisor will review the request and contact you.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 24),
          ...services.map((service) => _buildServiceCard(service)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(_LegalService service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.description_outlined, size: 16, color: Color(0xFF0E5E83)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  service.category,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFFE67E22), borderRadius: BorderRadius.circular(6)),
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(service.description, style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4)),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(color: Color(0xFF6B7280), shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Typical Use: ${service.useCase}',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppliedServices() {
    final applications = [
      _LegalApplication(sn: 1, date: '11-11-2025', name: 'Draft Shareholders Agreement', status: 'Pending Review', statusType: _StatusType.warning),
      _LegalApplication(sn: 2, date: '05-11-2025', name: 'Property Sale Deed Review', status: 'In Progress', statusType: _StatusType.info),
      _LegalApplication(sn: 3, date: '01-11-2025', name: 'Vendor Contract Vetting', status: 'Awaiting Documents', statusType: _StatusType.info),
      _LegalApplication(sn: 4, date: '25-10-2025', name: 'Leave & License Agreement', status: 'Completed', statusType: _StatusType.success),
      _LegalApplication(sn: 5, date: '20-10-2025', name: 'ESOP Policy Drafting', status: 'On Hold', statusType: _StatusType.info),
    ];

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
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.timeline_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Status of Applied Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF0E5E83).withOpacity(0.2)),
                ),
                child: Text(
                  '${applications.length} Applications',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Track the progress of your legal service requests, documents and deliverables.', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 24),

          SingleChildScrollView(
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
                    label: Text('#', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Date', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Name of Legal Service', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  DataColumn(
                    label: Text('Action', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ],
                rows: applications.map((app) => _buildApplicationRow(app)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildApplicationRow(_LegalApplication app) {
    return DataRow(
      cells: [
        DataCell(Text(app.sn.toString())),
        DataCell(Text(app.date)),
        DataCell(
          SizedBox(
            width: 200,
            child: Text(
              app.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(_buildStatusBadge(app.status, app.statusType)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: const Text(
              'Track',
              style: TextStyle(color: Color(0xFF0E5E83), fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status, _StatusType type) {
    Color bgColor;
    Color textColor;
    IconData icon;

    switch (type) {
      case _StatusType.success:
        bgColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case _StatusType.warning:
        bgColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        icon = Icons.pending_outlined;
        break;
      case _StatusType.info:
        bgColor = const Color(0xFFE0F2FE);
        textColor = const Color(0xFF075985);
        icon = Icons.update_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
          ),
        ],
      ),
    );
  }
}

class _LegalService {
  final String category;
  final String description;
  final String useCase;

  const _LegalService({required this.category, required this.description, required this.useCase});
}

class _LegalApplication {
  final int sn;
  final String date;
  final String name;
  final String status;
  final _StatusType statusType;

  const _LegalApplication({required this.sn, required this.date, required this.name, required this.status, required this.statusType});
}

enum _StatusType { success, warning, info }
