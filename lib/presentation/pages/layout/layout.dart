import 'package:flutter/material.dart';
import 'package:savingmantra/data/datasources/api_service.dart';
import 'package:savingmantra/presentation/pages/layout/crm/crm_page.dart';
import 'package:savingmantra/presentation/pages/layout/todo_list/todo_list.dart';
import 'package:savingmantra/presentation/router/app_routes.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  String _currentView = 'CRM';
  int _currentIndex = 0;
  bool _isSidebarExpanded = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<int, Widget> _views = {0: const CRMPage(), 1: const TodoListPage()};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ApiService().token.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
      }
    });
  }

  void _changeView(String viewName, int index) {
    setState(() {
      _currentView = viewName;
      _currentIndex = index;
    });

    if (MediaQuery.of(context).size.width < 1024) {
      Navigator.of(context).pop();
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarExpanded = !_isSidebarExpanded;
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ApiService().token = "";
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5E83),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    if (isDesktop) {
      return _buildDesktopLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSidebarExpanded ? 280 : 80,
            child: _Sidebar(currentView: _currentView, currentIndex: _currentIndex, onViewChanged: _changeView, isExpanded: _isSidebarExpanded, onToggle: _toggleSidebar, onLogout: _handleLogout),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4))],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(20), child: _views[_currentIndex]!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Row(
        children: [
          SizedBox(
            width: 80,
            child: _Sidebar(currentView: _currentView, currentIndex: _currentIndex, onViewChanged: _changeView, isExpanded: false, onToggle: _toggleSidebar, onLogout: _handleLogout),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 2))],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(16), child: _views[_currentIndex]!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF1F2937)),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          _currentView,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE5E7EB).withOpacity(0.5)),
        ),
      ),
      drawer: Drawer(
        width: 280,
        child: _Sidebar(currentView: _currentView, currentIndex: _currentIndex, onViewChanged: _changeView, isExpanded: true, onToggle: () {}, isMobile: true, onLogout: _handleLogout),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(borderRadius: BorderRadius.circular(12), child: _views[_currentIndex]!),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  final String currentView;
  final int currentIndex;
  final Function(String, int) onViewChanged;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onLogout;
  final bool isMobile;

  const _Sidebar({required this.currentView, required this.currentIndex, required this.onViewChanged, required this.isExpanded, required this.onToggle, required this.onLogout, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: !isMobile ? Border(right: BorderSide(color: const Color(0xFFE5E7EB).withOpacity(0.6), width: 1)) : null,
        boxShadow: !isMobile && isExpanded ? [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(2, 0))] : [],
      ),
      child: Column(
        children: [
          _buildLogoSection(),
          if (!isMobile && isExpanded) _buildToggleButton(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: isExpanded ? 16 : 12),
              children: [
                _SidebarItem('CRM', icon: Icons.people_rounded, active: currentIndex == 0, onTap: () => onViewChanged('CRM', 0), isExpanded: isExpanded),
                const SizedBox(height: 8),
                _SidebarItem('To-Do List', icon: Icons.checklist_rounded, active: currentIndex == 1, onTap: () => onViewChanged('To-Do List', 1), isExpanded: isExpanded),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: isExpanded ? 16 : 12),
            child: _SidebarItem('Logout', icon: Icons.logout_rounded, active: false, onTap: onLogout, isExpanded: isExpanded, isLogout: true),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isExpanded ? 20 : 0, vertical: 24),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color(0xFFE5E7EB).withOpacity(0.5), width: 1)),
      ),
      child: isExpanded
          ? Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.savings_rounded, color: Colors.white, size: 26);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saving Mantra',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19, color: Color(0xFF1F2937), letterSpacing: -0.5),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Business Suite',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w500, letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.25), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.savings_rounded, color: Colors.white, size: 22);
                    },
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildToggleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0E5E83).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF0E5E83).withOpacity(0.15), width: 1),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chevron_left_rounded, color: Color(0xFF0E5E83), size: 20),
                SizedBox(width: 8),
                Text(
                  'Collapse',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final bool isExpanded;
  final bool isLogout;

  const _SidebarItem(this.text, {required this.icon, this.active = false, required this.onTap, required this.isExpanded, this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: isExpanded ? 14 : 12, horizontal: isExpanded ? 14 : 12),
          decoration: BoxDecoration(
            gradient: active ? const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]) : null,
            color: isLogout
                ? const Color(0xFFEF4444).withOpacity(0.1)
                : active
                ? null
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isLogout ? Border.all(color: const Color(0xFFEF4444).withOpacity(0.3), width: 1) : null,
            boxShadow: active ? [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))] : null,
          ),
          child: isExpanded
              ? Row(
                  children: [
                    Icon(
                      icon,
                      size: 22,
                      color: isLogout
                          ? const Color(0xFFEF4444)
                          : active
                          ? Colors.white
                          : const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 14,
                          color: isLogout
                              ? const Color(0xFFEF4444)
                              : active
                              ? Colors.white
                              : const Color(0xFF374151),
                          letterSpacing: .5,
                          fontWeight: active || isLogout ? FontWeight.w600 : FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Tooltip(
                    message: text,
                    child: Icon(
                      icon,
                      size: 24,
                      color: isLogout
                          ? const Color(0xFFEF4444)
                          : active
                          ? Colors.white
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
