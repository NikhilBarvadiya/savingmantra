import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/layout/accounting/accounting.dart';
import 'package:savingmantra/presentation/pages/layout/booking/booking.dart';
import 'package:savingmantra/presentation/pages/layout/business_plans/business_plans.dart';
import 'package:savingmantra/presentation/pages/layout/client/client.dart';
import 'package:savingmantra/presentation/pages/layout/clients/clients.dart';
import 'package:savingmantra/presentation/pages/layout/create_managed_network/create_managed_network.dart';
import 'package:savingmantra/presentation/pages/layout/follow_up/follow_up.dart';
import 'package:savingmantra/presentation/pages/layout/import_export/import_export.dart';
import 'package:savingmantra/presentation/pages/layout/invitations_requests/invitations_requests.dart';
import 'package:savingmantra/presentation/pages/layout/leads/leads.dart';
import 'package:savingmantra/presentation/pages/layout/manage_bookings/manage_bookings.dart';
import 'package:savingmantra/presentation/pages/layout/masters/masters.dart';
import 'package:savingmantra/presentation/pages/layout/my_members/my_members.dart';
import 'package:savingmantra/presentation/pages/layout/network/network.dart';
import 'package:savingmantra/presentation/pages/layout/opportunity/opportunity.dart';
import 'package:savingmantra/presentation/pages/layout/registration/registration.dart';
import 'package:savingmantra/presentation/pages/layout/compliance/compliance.dart';
import 'package:savingmantra/presentation/pages/layout/legal/legal.dart';
import 'package:savingmantra/presentation/pages/layout/financial_services/financial_services.dart';
import 'package:savingmantra/presentation/pages/layout/digital_marketing/digital_marketing.dart';
import 'package:savingmantra/presentation/pages/layout/reports/reports.dart';
import 'package:savingmantra/presentation/pages/layout/sop/sop.dart';
import 'package:savingmantra/presentation/pages/layout/task_management/task_management.dart';
import 'package:savingmantra/presentation/pages/layout/todo_list/todo_list.dart';
import 'package:savingmantra/presentation/pages/layout/transactions/transactions.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  String _currentView = 'Opportunity Dashboard';
  int _currentIndex = 1;

  final Map<int, Widget> _views = {
    0: const ClientPage(),
    1: const OpportunityPage(),
    2: const RegistrationPage(),
    3: const CompliancePage(),
    4: const LegalPage(),
    5: const FinancialServicesPage(),
    6: const DigitalMarketingPage(),
    7: const ImportExportPage(),
    8: const AccountingPage(),
    9: const MastersPage(),
    10: const TransactionsPage(),
    11: const ReportsPage(),
    12: const NetworkPage(),
    13: const CreateManageNetworkPage(),
    14: const MyMembersPage(),
    15: const InvitationsRequestsPage(),
    16: const LeadsPage(),
    17: const FollowUpPage(),
    18: const ClientsPage(),
    19: const BookingPage(),
    20: const ManageBookingsPage(),
    21: const TodoListPage(),
    22: const TaskManagementPage(),
    23: const SopPage(),
    24: const BusinessPlansPage(),
  };

  void _changeView(String viewName, int index) {
    setState(() {
      _currentView = viewName;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          _Sidebar(currentView: _currentView, currentIndex: _currentIndex, onViewChanged: _changeView),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Color(0x0F000000), blurRadius: 20, offset: Offset(0, 4))],
              ),
              child: _views[_currentIndex]!,
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String currentView;
  final int currentIndex;
  final Function(String, int) onViewChanged;

  const _Sidebar({required this.currentView, required this.currentIndex, required this.onViewChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Column(
        children: [
          _buildLogoSection(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SidebarSection(
                  title: 'Overview',
                  items: [
                    _SidebarItem('Client Dashboard', icon: Icons.dashboard_outlined, active: currentIndex == 0, onTap: () => onViewChanged('Client Dashboard', 0)),
                    _SidebarItem('Opportunity Dashboard', icon: Icons.trending_up_outlined, active: currentIndex == 1, onTap: () => onViewChanged('Opportunity Dashboard', 1)),
                  ],
                ),
                _SidebarSection(
                  title: 'Services',
                  items: [
                    _SidebarItem('Registrations', icon: Icons.app_registration_outlined, active: currentIndex == 2, onTap: () => onViewChanged('Registrations', 2)),
                    _SidebarItem('Compliances', icon: Icons.verified_outlined, active: currentIndex == 3, onTap: () => onViewChanged('Compliances', 3)),
                    _SidebarItem('Legal', icon: Icons.gavel_outlined, active: currentIndex == 4, onTap: () => onViewChanged('Legal', 4)),
                    _SidebarItem('Financial Services', icon: Icons.attach_money_outlined, active: currentIndex == 5, onTap: () => onViewChanged('Financial Services', 5)),
                    _SidebarItem('Digital Marketing', icon: Icons.campaign_outlined, active: currentIndex == 6, onTap: () => onViewChanged('Digital Marketing', 6)),
                    _SidebarItem('Import / Export', icon: Icons.import_export_outlined, active: currentIndex == 7, onTap: () => onViewChanged('Import / Export', 7)),
                  ],
                ),
                _SidebarSection(
                  title: 'Accounting',
                  items: [
                    _SidebarItem('Accounting Workspace', icon: Icons.account_balance_wallet_outlined, active: currentIndex == 8, onTap: () => onViewChanged('Accounting Workspace', 8)),
                    _SidebarItem('Masters', icon: Icons.star_outline, active: currentIndex == 9, onTap: () => onViewChanged('Masters', 9)),
                    _SidebarItem('Transactions', icon: Icons.swap_horiz_outlined, active: currentIndex == 10, onTap: () => onViewChanged('Transactions', 10)),
                    _SidebarItem('Reports', icon: Icons.analytics_outlined, active: currentIndex == 11, onTap: () => onViewChanged('Reports', 11)),
                  ],
                ),
                _SidebarSection(
                  title: 'Networking',
                  items: [
                    _SidebarItem('Network Dashboard', icon: Icons.groups_outlined, active: currentIndex == 12, onTap: () => onViewChanged('Network Dashboard', 12)),
                    _SidebarItem('Create / Manage Network', icon: Icons.add_business_outlined, active: currentIndex == 13, onTap: () => onViewChanged('Create / Manage Network', 13)),
                    _SidebarItem('My Members', icon: Icons.people_alt_outlined, active: currentIndex == 14, onTap: () => onViewChanged('My Members', 14)),
                    _SidebarItem('Invitations / Requests', icon: Icons.mail_outline, active: currentIndex == 15, onTap: () => onViewChanged('Invitations / Requests', 15)),
                  ],
                ),
                _SidebarSection(
                  title: 'CRM',
                  items: [
                    _SidebarItem('Leads', icon: Icons.leaderboard_outlined, active: currentIndex == 16, onTap: () => onViewChanged('Leads', 16)),
                    _SidebarItem('Follow-up', icon: Icons.update_outlined, active: currentIndex == 17, onTap: () => onViewChanged('Follow-ups', 17)),
                    _SidebarItem('Clients', icon: Icons.business_center_outlined, active: currentIndex == 18, onTap: () => onViewChanged('Clients', 18)),
                  ],
                ),
                _SidebarSection(
                  title: 'Booking',
                  items: [
                    _SidebarItem('Booking Dashboard', icon: Icons.calendar_today_outlined, active: currentIndex == 19, onTap: () => onViewChanged('Booking Dashboard', 19)),
                    _SidebarItem('Manage Bookings', icon: Icons.event_available_outlined, active: currentIndex == 20, onTap: () => onViewChanged('Manage Bookings', 20)),
                  ],
                ),
                _SidebarSection(
                  title: 'Daily Tools',
                  items: [
                    _SidebarItem('To-Do', icon: Icons.checklist_outlined, active: currentIndex == 21, onTap: () => onViewChanged('To-Do', 21)),
                    _SidebarItem('Task Management', icon: Icons.task_outlined, active: currentIndex == 22, onTap: () => onViewChanged('Task Management', 22)),
                    _SidebarItem('SOP', icon: Icons.description_outlined, active: currentIndex == 23, onTap: () => onViewChanged('SOP', 23)),
                    _SidebarItem('Biz Plan', icon: Icons.lightbulb_outline, active: currentIndex == 24, onTap: () => onViewChanged('Biz Plan', 24)),
                  ],
                ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF0E8E83)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.savings, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Saving Mantra',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF111827)),
              ),
              SizedBox(height: 2),
              Text(
                'Business Suite',
                style: TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83), borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text(
                'AM',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amit Mishra',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
                SizedBox(height: 2),
                Text('Admin User', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, size: 20, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SidebarSection extends StatelessWidget {
  final String title;
  final List<_SidebarItem> items;

  const _SidebarSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.only(bottom: 10),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      initiallyExpanded: title == 'Overview',
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
      ),
      children: items,
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _SidebarItem(this.text, {required this.icon, this.active = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF0F9FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: active ? Border.all(color: const Color(0xFF0E5E83).withOpacity(0.2)) : null,
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 20, color: active ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
        title: Text(
          text,
          style: TextStyle(fontSize: 13, color: active ? const Color(0xFF0E5E83) : const Color(0xFF374151), fontWeight: active ? FontWeight.w600 : FontWeight.w500),
        ),
        onTap: onTap,
      ),
    );
  }
}
