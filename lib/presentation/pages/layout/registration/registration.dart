import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Registrations',
        subtitle: 'Manage client registrations and onboarding',
        leadingIcon: Icons.app_registration_outlined,
        customActions: [AppBarActionButton(label: 'New Registration', icon: Icons.add, onPressed: () {}, isPrimary: true)],
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
          _buildStatItem('Active Registrations', '8', Icons.verified_outlined, const Color(0xFF10B981)),
          const SizedBox(width: 24),
          _buildStatItem('Pending Approvals', '3', Icons.pending_actions_outlined, const Color(0xFFF59E0B)),
          const SizedBox(width: 24),
          _buildStatItem('Renewals Due', '2', Icons.calendar_today_outlined, const Color(0xFFEF4444)),
          const SizedBox(width: 24),
          _buildStatItem('Completed', '15', Icons.check_circle_outlined, const Color(0xFF3B82F6)),
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
        Expanded(flex: 2, child: Column(children: [_buildExistingRegistrations(), const SizedBox(height: 24), _buildRegistrationCategories()])),
        const SizedBox(width: 24),

        Expanded(flex: 2, child: Column(children: [_buildApplyNewRegistration(), const SizedBox(height: 24), _buildAppliedRegistrations()])),
      ],
    );
  }

  Widget _buildExistingRegistrations() {
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
                child: const Icon(Icons.list_alt_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Existing Registrations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._existingRegistrations.map((registration) => _buildRegistrationItem(registration)),
        ],
      ),
    );
  }

  Widget _buildRegistrationItem(ExistingRegistration registration) {
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
                child: const Icon(Icons.business_center_outlined, size: 16, color: Color(0xFF0E5E83)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  registration.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: const Text(
                  'Active',
                  style: TextStyle(fontSize: 12, color: Color(0xFF065F46), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Registration ID', registration.registerId),
          _buildDetailRow('Start Date', registration.startDate),
          _buildDetailRow('End Date', registration.endDate == '—' ? 'Permanent' : registration.endDate),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 12, color: Color(0xFF111827), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationCategories() {
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
                child: const Icon(Icons.category_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Registration Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 12, runSpacing: 12, children: _registrationCategories.map((category) => _buildCategoryCard(category)).toList()),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(RegistrationCategory category) {
    return Container(
      width: 280,
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
                child: const Icon(Icons.fact_check_outlined, size: 16, color: Color(0xFF0E5E83)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(category.description, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.4)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 36,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                'Apply Now',
                style: TextStyle(color: Color(0xFF0E5E83), fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyNewRegistration() {
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
                'Apply for New Registration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Start a new registration process for your business requirements', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
              boxShadow: [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Start New Registration',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppliedRegistrations() {
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
                child: const Icon(Icons.pending_actions_outlined, color: Color(0xFF0E5E83), size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Applied Registrations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                  label: Text('Registration', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                DataColumn(
                  label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                DataColumn(
                  label: Text('Action', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
              rows: _appliedRegistrations.map((applied) => _buildAppliedRow(applied)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildAppliedRow(AppliedRegistration applied) {
    return DataRow(
      cells: [
        DataCell(Text(applied.sn.toString())),
        DataCell(Text(applied.date)),
        DataCell(Text(applied.name)),
        DataCell(_buildStatusBadge(applied.status, applied.statusType)),
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

  Widget _buildStatusBadge(String status, String type) {
    Color bgColor;
    Color textColor;
    IconData icon;

    if (type == 'success') {
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF166534);
      icon = Icons.check_circle_outline;
    } else {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFF92400E);
      icon = Icons.access_time_outlined;
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

class ExistingRegistration {
  final String name;
  final String registerId;
  final String startDate;
  final String endDate;

  const ExistingRegistration({required this.name, required this.registerId, required this.startDate, required this.endDate});
}

class RegistrationCategory {
  final String name;
  final String description;

  const RegistrationCategory({required this.name, required this.description});
}

class AppliedRegistration {
  final int sn;
  final String date;
  final String name;
  final String status;
  final String statusType;

  const AppliedRegistration({required this.sn, required this.date, required this.name, required this.status, required this.statusType});
}

const List<ExistingRegistration> _existingRegistrations = [
  ExistingRegistration(name: 'GST Registration', registerId: 'GST27ABCDE1234Z1Z', startDate: '01-04-2022', endDate: '—'),
  ExistingRegistration(name: 'Shop & Establishment', registerId: 'SHOPEST/PN/2021/1456', startDate: '15-06-2021', endDate: '14-06-2026'),
];

const List<RegistrationCategory> _registrationCategories = [
  RegistrationCategory(name: 'Formation', description: 'Company/LLP/Partnership, Society, Trust formation etc.'),
  RegistrationCategory(name: 'Govt Registration', description: 'GST, MSME/Udyam, Shops & Establishment, Professional Tax etc.'),
  RegistrationCategory(name: 'Govt License', description: 'FSSAI, Trade License, Pollution, Labour license etc.'),
  RegistrationCategory(name: 'Global', description: 'IEC, Import–Export registrations, foreign entity formation etc.'),
  RegistrationCategory(name: 'Other', description: 'Any other custom registration / license requirement.'),
];

const List<AppliedRegistration> _appliedRegistrations = [
  AppliedRegistration(sn: 1, date: '05-11-2025', name: 'GST Registration', status: 'Approved', statusType: 'success'),
  AppliedRegistration(sn: 2, date: '02-11-2025', name: 'FSSAI License', status: 'Pending', statusType: 'warning'),
  AppliedRegistration(sn: 3, date: '28-10-2025', name: 'Import–Export Code', status: 'Under Process', statusType: 'warning'),
];
