import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/layout/accounting/accounting.dart';
import 'package:savingmantra/presentation/pages/layout/booking/booking.dart';
import 'package:savingmantra/presentation/pages/layout/client/client.dart';
import 'package:savingmantra/presentation/pages/layout/create_managed_network/create_managed_network.dart';
import 'package:savingmantra/presentation/pages/layout/import_export/import_export.dart';
import 'package:savingmantra/presentation/pages/layout/invitations_requests/invitations_requests.dart';
import 'package:savingmantra/presentation/pages/layout/crm/crm_page.dart';
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
  bool _isSidebarExpanded = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    16: const CRMPage(),
    17: const BookingPage(),
    18: const ManageBookingsPage(),
    19: const TodoListPage(),
  };

  void _changeView(String viewName, int index) {
    setState(() {
      _currentView = viewName;
      _currentIndex = index;
    });

    // Close drawer on mobile after selection
    if (MediaQuery.of(context).size.width < 1024) {
      Navigator.of(context).pop();
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isDesktop) {
      return _buildDesktopLayout();
    } else {
      return _buildMobileLayout(isMobile);
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // Animated Sidebar - Changed collapsed width from 80 to 72
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSidebarExpanded ? 280 : 72,
            child: _Sidebar(
              currentView: _currentView,
              currentIndex: _currentIndex,
              onViewChanged: _changeView,
              isExpanded: _isSidebarExpanded,
              onToggle: _toggleSidebar,
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(-4, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
                child: _views[_currentIndex]!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(bool isMobile) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF111827)),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _currentView,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
            if (!isMobile)
              const Text(
                'Saving Mantra',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
          ),
        ),
      ),
      drawer: Drawer(
        width: 280,
        child: _Sidebar(
          currentView: _currentView,
          currentIndex: _currentIndex,
          onViewChanged: _changeView,
          isExpanded: true,
          onToggle: () {},
          isMobile: true,
        ),
      ),
      body: _views[_currentIndex]!,
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String currentView;
  final int currentIndex;
  final Function(String, int) onViewChanged;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool isMobile;

  const _Sidebar({
    required this.currentView,
    required this.currentIndex,
    required this.onViewChanged,
    required this.isExpanded,
    required this.onToggle,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        boxShadow: !isMobile
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(2, 0),
          ),
        ]
            : [],
      ),
      child: Column(
        children: [
          _buildLogoSection(),
          if (!isMobile) _buildToggleButton(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: isExpanded ? 8 : 4),
              children: [
                _SidebarSection(
                  title: 'Overview',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('Client Dashboard', icon: Icons.dashboard_rounded, active: currentIndex == 0, onTap: () => onViewChanged('Client Dashboard', 0), isExpanded: isExpanded),
                    _SidebarItem('Opportunity Dashboard', icon: Icons.trending_up_rounded, active: currentIndex == 1, onTap: () => onViewChanged('Opportunity Dashboard', 1), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'Services',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('Registrations', icon: Icons.app_registration_rounded, active: currentIndex == 2, onTap: () => onViewChanged('Registrations', 2), isExpanded: isExpanded),
                    _SidebarItem('Compliances', icon: Icons.verified_rounded, active: currentIndex == 3, onTap: () => onViewChanged('Compliances', 3), isExpanded: isExpanded),
                    _SidebarItem('Legal', icon: Icons.gavel_rounded, active: currentIndex == 4, onTap: () => onViewChanged('Legal', 4), isExpanded: isExpanded),
                    _SidebarItem('Financial Services', icon: Icons.attach_money_rounded, active: currentIndex == 5, onTap: () => onViewChanged('Financial Services', 5), isExpanded: isExpanded),
                    _SidebarItem('Digital Marketing', icon: Icons.campaign_rounded, active: currentIndex == 6, onTap: () => onViewChanged('Digital Marketing', 6), isExpanded: isExpanded),
                    _SidebarItem('Import / Export', icon: Icons.import_export_rounded, active: currentIndex == 7, onTap: () => onViewChanged('Import / Export', 7), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'Accounting',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('Accounting Workspace', icon: Icons.account_balance_wallet_rounded, active: currentIndex == 8, onTap: () => onViewChanged('Accounting Workspace', 8), isExpanded: isExpanded),
                    _SidebarItem('Masters', icon: Icons.star_rounded, active: currentIndex == 9, onTap: () => onViewChanged('Masters', 9), isExpanded: isExpanded),
                    _SidebarItem('Transactions', icon: Icons.swap_horiz_rounded, active: currentIndex == 10, onTap: () => onViewChanged('Transactions', 10), isExpanded: isExpanded),
                    _SidebarItem('Reports', icon: Icons.analytics_rounded, active: currentIndex == 11, onTap: () => onViewChanged('Reports', 11), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'Networking',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('Network Dashboard', icon: Icons.groups_rounded, active: currentIndex == 12, onTap: () => onViewChanged('Network Dashboard', 12), isExpanded: isExpanded),
                    _SidebarItem('Create / Manage Network', icon: Icons.add_business_rounded, active: currentIndex == 13, onTap: () => onViewChanged('Create / Manage Network', 13), isExpanded: isExpanded),
                    _SidebarItem('My Members', icon: Icons.people_alt_rounded, active: currentIndex == 14, onTap: () => onViewChanged('My Members', 14), isExpanded: isExpanded),
                    _SidebarItem('Invitations / Requests', icon: Icons.mail_rounded, active: currentIndex == 15, onTap: () => onViewChanged('Invitations / Requests', 15), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'CRM',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('CRM', icon: Icons.people_rounded, active: currentIndex == 16, onTap: () => onViewChanged('CRM', 16), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'Booking',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('Booking Dashboard', icon: Icons.calendar_today_rounded, active: currentIndex == 17, onTap: () => onViewChanged('Booking Dashboard', 17), isExpanded: isExpanded),
                    _SidebarItem('Manage Bookings', icon: Icons.event_available_rounded, active: currentIndex == 18, onTap: () => onViewChanged('Manage Bookings', 18), isExpanded: isExpanded),
                  ],
                ),
                _SidebarSection(
                  title: 'Daily Tools',
                  isExpanded: isExpanded,
                  items: [
                    _SidebarItem('To-Do', icon: Icons.checklist_rounded, active: currentIndex == 19, onTap: () => onViewChanged('To-Do', 19), isExpanded: isExpanded),
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
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? 20 : 0,
        vertical: isExpanded ? 20 : 16,
      ),
      child: isExpanded
          ? Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0E5E83).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.savings_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saving Mantra',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: Color(0xFF111827),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Business Suite',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
          : Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0E5E83).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.savings_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isExpanded ? 16 : 12,
        vertical: 8,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(isExpanded ? 10 : 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0E5E83).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF0E5E83).withOpacity(0.2),
              ),
            ),
            child: isExpanded
                ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chevron_left_rounded, color: Color(0xFF0E5E83), size: 20),
                SizedBox(width: 8),
                Text('Collapse', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83))),
              ],
            )
                : const Center(
              child: Icon(Icons.chevron_right_rounded, color: Color(0xFF0E5E83), size: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(isExpanded ? 16 : 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB), width: 1)),
      ),
      child: isExpanded
          ? Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Color(0xFF0E5E83).withOpacity(.2), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: const Center(child: Text('AM', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amit Mishra', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                SizedBox(height: 2),
                Text('Admin User', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.settings_rounded, size: 20, color: Color(0xFF6B7280)),
              ),
            ),
          ),
        ],
      )
          : Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Color(0xFF0E5E83).withOpacity(.2), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: const Center(child: Text('AM', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}

class _SidebarSection extends StatefulWidget {
  final String title;
  final List<_SidebarItem> items;
  final bool isExpanded;

  const _SidebarSection({
    required this.title,
    required this.items,
    required this.isExpanded,
  });

  @override
  State<_SidebarSection> createState() => _SidebarSectionState();
}

class _SidebarSectionState extends State<_SidebarSection> {
  late bool _isSectionExpanded;

  @override
  void initState() {
    super.initState();
    _isSectionExpanded = widget.title == 'Overview' || widget.title == 'CRM' || widget.title == 'Daily Tools';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isExpanded) {
      return Column(
        children: [
          const SizedBox(height: 2),
          ...widget.items,
          const SizedBox(height: 2),
          if (widget.items.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              height: 1,
              color: const Color(0xFFE5E7EB),
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _isSectionExpanded = !_isSectionExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title.toUpperCase(),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 1),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isSectionExpanded ? 0 : -0.25,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _isSectionExpanded
              ? Column(children: [...widget.items, const SizedBox(height: 6)])
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final bool isExpanded;

  const _SidebarItem(this.text, {required this.icon, this.active = false, required this.onTap, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isExpanded ? 12 : 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isExpanded ? 12 : 10),
            decoration: BoxDecoration(
              gradient: active
                  ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xFF0E5E83).withOpacity(0.1), const Color(0xFF1E88B7).withOpacity(0.05)],
              )
                  : null,
              borderRadius: BorderRadius.circular(10),
              border: active ? Border.all(color: const Color(0xFF0E5E83).withOpacity(0.3), width: 1.5) : null,
            ),
            child: isExpanded
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFF0E5E83).withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Icon(icon, size: 18, color: active ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 13,
                      color: active ? const Color(0xFF0E5E83) : const Color(0xFF374151),
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (active) ...[
                  const SizedBox(width: 6),
                  Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF0E5E83), shape: BoxShape.circle)),
                ],
              ],
            )
                : Center(
              child: Tooltip(
                message: text,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: active ? const Color(0xFF0E5E83).withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: active ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}