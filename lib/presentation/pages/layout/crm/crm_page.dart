import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmantra/domain/repositories/crm/crm_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class CRMPage extends StatefulWidget {
  const CRMPage({super.key});

  @override
  State<CRMPage> createState() => _CRMPageState();
}

class _CRMPageState extends State<CRMPage> with SingleTickerProviderStateMixin {
  final CrmRepository _crmRepository = CrmRepository();

  bool _isLoadingMasters = true, _isLoadingList = false, _isSubmitting = false, _showAddForm = false;

  List<Map<String, dynamic>> _crmTypes = [], _crmSources = [];
  List<Map<String, dynamic>> _crmStatuses = [], _crmList = [];

  TabController? _tabController;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  final ScrollController _scrollController = ScrollController();

  late final TextEditingController _newPartyController;
  late final TextEditingController _newMobileController;
  late final TextEditingController _newNotesController;

  String _searchQuery = '', _selectedStatusFilter = '';
  int _currentTypeIndex = 0;

  String? _newSelectedTypeId, _newSelectedSourceId;

  late DateTime _newSelectedDate;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadInitialData();
  }

  void _initializeControllers() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _newPartyController = TextEditingController();
    _newMobileController = TextEditingController();
    _newNotesController = TextEditingController();
    _newSelectedDate = DateTime.now();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoadingMasters = true);
    try {
      await _loadMasters();
      await _loadCRMList();
    } catch (e) {
      _showSnackBar('Failed to load data: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoadingMasters = false);
      }
    }
  }

  Future<void> _loadMasters() async {
    try {
      final response = await _crmRepository.getCrmMasters();
      if (!mounted) return;
      setState(() {
        _crmTypes = (response['BusCRMTypeMasterList'] as List?)?.cast<Map<String, dynamic>>() ?? [];
        _crmSources = (response['BusCRMSourceMasterList'] as List?)?.cast<Map<String, dynamic>>() ?? [];
        _crmStatuses = (response['BusCRMSalesStatusMasterList'] as List?)?.cast<Map<String, dynamic>>() ?? [];
      });
      if (_crmTypes.isNotEmpty) {
        _tabController = TabController(length: _crmTypes.length, vsync: this, initialIndex: 0);
        _tabController!.addListener(() {
          if (!_tabController!.indexIsChanging && mounted) {
            setState(() => _currentTypeIndex = _tabController!.index);
            _loadCRMList();
          }
        });
        _newSelectedTypeId = _crmTypes[0]['BusCRMTypeid'].toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadCRMList() async {
    if (!mounted || _tabController == null) return;
    setState(() => _isLoadingList = true);
    try {
      final currentTypeId = _crmTypes[_tabController!.index]['BusCRMTypeid'];
      final response = await _crmRepository.getCrmList(busCRMTypeid: currentTypeId.toString(), busCRMSalesStatusid: _selectedStatusFilter);
      if (mounted) {
        setState(() {
          _crmList = (response as List?)?.cast<Map<String, dynamic>>() ?? [];
          _isLoadingList = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingList = false);
        _showSnackBar('Failed to load CRM list: $e', isError: true);
      }
    }
  }

  Future<void> _submitNewCRM() async {
    if (_newPartyController.text.trim().isEmpty) {
      _showSnackBar('Please enter party name', isError: true);
      return;
    }
    if (_newMobileController.text.trim().isEmpty) {
      _showSnackBar('Please enter mobile number', isError: true);
      return;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(_newMobileController.text.trim())) {
      _showSnackBar('Please enter a valid 10-digit mobile number', isError: true);
      return;
    }
    if (_newSelectedTypeId == null) {
      _showSnackBar('Please select CRM type', isError: true);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await _crmRepository.addCrm(
        busCRMTypeid: _newSelectedTypeId!,
        followDate: DateFormat('yyyy-MM-dd').format(_newSelectedDate),
        crmParty: _newPartyController.text.trim(),
        mobileNumber: _newMobileController.text.trim(),
        crmNotes: _newNotesController.text.trim(),
        busCRMSourceId: _newSelectedSourceId ?? '',
      );
      _clearForm();
      await _loadCRMList();
      if (mounted) {
        setState(() {
          _showAddForm = false;
          _isSubmitting = false;
        });
        _showSnackBar('✓ Contact added successfully!', isError: false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _showSnackBar('Failed to add contact: $e', isError: true);
      }
    }
  }

  void _clearForm() {
    _newPartyController.clear();
    _newMobileController.clear();
    _newNotesController.clear();
    _newSelectedDate = DateTime.now();
    _newSelectedSourceId = null;
    if (_crmTypes.isNotEmpty) {
      _newSelectedTypeId = _crmTypes[0]['BusCRMTypeid'].toString();
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _newSelectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0E5E83), onPrimary: Colors.white, surface: Colors.white, onSurface: Colors.black),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() => _newSelectedDate = picked);
    }
  }

  List<Map<String, dynamic>> get _filteredCRMList {
    List<Map<String, dynamic>> filtered = _crmList;
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((crm) {
        final party = (crm['CRMParty'] ?? '').toString().toLowerCase();
        final mobile = (crm['MobileNumber'] ?? '').toString().toLowerCase();
        final notes = (crm['CRMNotes'] ?? '').toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return party.contains(query) || mobile.contains(query) || notes.contains(query);
      }).toList();
    }
    if (_selectedStatusFilter.isNotEmpty) {
      filtered = filtered.where((crm) => crm['BusCRMSalesStatusid'].toString() == _selectedStatusFilter).toList();
    }
    return filtered;
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isError ? Icons.error_outline : Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showSnackBar('Unable to make call', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error: $e', isError: true);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _newPartyController.dispose();
    _newMobileController.dispose();
    _newNotesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: _isLoadingMasters ? _buildInitialLoading() : _buildMainContent(context),
      floatingActionButton: !_isLoadingMasters ? _buildFAB(context) : null,
    );
  }

  Widget _buildFAB(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    if (!isMobile) return const SizedBox.shrink();
    return FloatingActionButton.extended(
      onPressed: () => setState(() {
        _showAddForm = !_showAddForm;
        if (!_showAddForm) _clearForm();
      }),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 6,
      icon: Icon(_showAddForm ? Icons.close : Icons.add_rounded, size: 22),
      label: Text(_showAddForm ? 'Close' : 'Add Contact', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }

  Widget _buildInitialLoading() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(delegate: SliverChildListDelegate([_buildShimmerKPIs(), const SizedBox(height: 24), _buildShimmerList()])),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    if (_crmTypes.isEmpty) {
      return CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverFillRemaining(child: _buildEmptyState()),
        ],
      );
    }
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isMobile = MediaQuery.of(context).size.width < 768;
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickStats(context),
              const SizedBox(height: 24),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_showAddForm) ...[Expanded(flex: 2, child: _buildAddFormCard(context)), const SizedBox(width: 24)],
                    Expanded(flex: _showAddForm ? 3 : 1, child: _buildContactsCard(context)),
                  ],
                )
              else
                Column(
                  children: [
                    if (_showAddForm) ...[_buildAddFormCard(context), const SizedBox(height: 24)],
                    _buildContactsCard(context),
                  ],
                ),
              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      expandedHeight: isMobile ? 100 : 120,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, const Color(0xFF0E5E83).withOpacity(0.02)]),
          ),
          padding: EdgeInsets.fromLTRB(isMobile ? 16 : 24, MediaQuery.of(context).padding.top + 16, isMobile ? 16 : 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: const Color(0xFF0E5E83).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: const Icon(Icons.dashboard_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CRM Dashboard',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), letterSpacing: -0.5),
                        ),
                        if (!isMobile)
                          const Text(
                            'Manage and track your customer relationships',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
                          ),
                      ],
                    ),
                  ),
                  if (!isMobile) ...[
                    IconButton(
                      icon: _isLoadingList
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Color(0xFF0E5E83))))
                          : const Icon(Icons.refresh_rounded),
                      onPressed: _isLoadingList ? null : _loadCRMList,
                      tooltip: 'Refresh',
                      color: const Color(0xFF6B7280),
                    ),
                    IconButton(icon: const Icon(Icons.filter_list_rounded), onPressed: () {}, tooltip: 'Advanced Filters', color: const Color(0xFF6B7280)),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final totalEntries = _crmList.length;
    final activeEntries = _crmList.where((c) => c['StatusName']?.toString().toLowerCase() == 'follow up').length;
    final newEntries = _crmList.where((c) => c['StatusName']?.toString().toLowerCase() == 'new').length;
    final closedEntries = _crmList.where((c) => c['StatusName']?.toString().toLowerCase() == 'close').length;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final stats = [
      _StatCard(icon: Icons.groups_rounded, label: 'Total Contacts', value: totalEntries.toString(), color: const Color(0xFF0E5E83), gradient: [const Color(0xFF0E5E83), const Color(0xFF1E88B7)]),
      _StatCard(
        icon: Icons.trending_up_rounded,
        label: 'Active Follow-ups',
        value: activeEntries.toString(),
        color: const Color(0xFF10B981),
        gradient: [const Color(0xFF10B981), const Color(0xFF059669)],
      ),
      _StatCard(icon: Icons.fiber_new_rounded, label: 'New Leads', value: newEntries.toString(), color: const Color(0xFFF59E0B), gradient: [const Color(0xFFF59E0B), const Color(0xFFD97706)]),
      _StatCard(icon: Icons.check_circle_rounded, label: 'Closed Deals', value: closedEntries.toString(), color: const Color(0xFF8B5CF6), gradient: [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)]),
    ];
    return isMobile
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4),
            itemCount: stats.length,
            itemBuilder: (context, index) => _buildStatCard(stats[index], isMobile),
          )
        : Row(
            children: stats.map((stat) {
              return Expanded(
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: _buildStatCard(stat, isMobile)),
              );
            }).toList(),
          );
  }

  Widget _buildStatCard(_StatCard stat, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: stat.gradient),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: stat.color.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10.0,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: Icon(stat.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                stat.value,
                style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: .5),
              ),
            ],
          ),
          Text(
            stat.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w600, letterSpacing: .5),
          ),
        ],
      ),
    );
  }

  Widget _buildAddFormCard(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_add_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Contact',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('Fill in the details below', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile)
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 22),
                  onPressed: () => setState(() {
                    _showAddForm = false;
                    _clearForm();
                  }),
                  color: const Color(0xFF6B7280),
                ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField(controller: _newPartyController, label: 'Full Name', hint: 'Enter contact name', icon: Icons.person_outline_rounded, isRequired: true),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _newMobileController,
            label: 'Mobile Number',
            hint: '10-digit number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            isRequired: true,
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'CRM Type',
            value: _newSelectedTypeId,
            items: _crmTypes.map((type) {
              return DropdownMenuItem(value: type['BusCRMTypeid'].toString(), child: Text(type['CRMTypeName'] ?? ''));
            }).toList(),
            onChanged: (value) => setState(() => _newSelectedTypeId = value),
            icon: Icons.category_outlined,
            isRequired: true,
          ),
          const SizedBox(height: 16),
          if (_crmSources.isNotEmpty) ...[
            _buildDropdown(
              label: 'Source',
              value: _newSelectedSourceId,
              items: [
                const DropdownMenuItem(value: null, child: Text('Select source (optional)')),
                ..._crmSources.map((source) {
                  return DropdownMenuItem(value: source['BusCRMSourceId'].toString(), child: Text(source['BusCRMSourceName'] ?? ''));
                }),
              ],
              onChanged: (value) => setState(() => _newSelectedSourceId = value),
              icon: Icons.source_outlined,
            ),
            const SizedBox(height: 16),
          ],
          _buildDateField(),
          const SizedBox(height: 16),
          _buildTextField(controller: _newNotesController, label: 'Notes', hint: 'Add any additional notes...', icon: Icons.note_outlined, maxLines: 3),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitNewCRM,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E5E83),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                disabledBackgroundColor: const Color(0xFF0E5E83).withOpacity(0.5),
              ),
              child: _isSubmitting
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline_rounded, size: 22),
                        SizedBox(width: 10),
                        Text('Add Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isRequired = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
            if (isRequired) const Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0E5E83), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    required IconData icon,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
            if (isRequired) const Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0E5E83), width: 2),
            ),
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Follow-up Date',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
            ),
            Text(' *', style: TextStyle(color: Color(0xFFEF4444), fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDate,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 20, color: Color(0xFF6B7280)),
                const SizedBox(width: 12),
                Text(DateFormat('EEE, MMM dd, yyyy').format(_newSelectedDate), style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactsCard(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.contacts_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact List',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('${_filteredCRMList.length} ${_filteredCRMList.length == 1 ? 'contact' : 'contacts'}', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile && !_showAddForm)
                ElevatedButton.icon(
                  onPressed: () => setState(() => _showAddForm = true),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add CRM', style: TextStyle(fontWeight: FontWeight.w400, letterSpacing: .5)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E5E83),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 16),
          if (_crmStatuses.isNotEmpty) ...[_buildStatusFilters(), const SizedBox(height: 20)],
          if (_crmTypes.length > 1) ...[_buildTypeTabs(), const SizedBox(height: 20)],
          if (_isLoadingList) _buildContactsShimmer() else if (_filteredCRMList.isEmpty) _buildEmptyContacts() else _buildContactsList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by name, mobile, or notes...',
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF6B7280), size: 22),
          suffixIcon: _searchQuery.isNotEmpty ? IconButton(icon: const Icon(Icons.close_rounded, size: 20), onPressed: () => _searchController.clear(), color: const Color(0xFF6B7280)) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildStatusFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(label: 'All', count: _crmList.length, isSelected: _selectedStatusFilter.isEmpty, color: const Color(0xFF0E5E83), onTap: () => setState(() => _selectedStatusFilter = '')),
          ..._crmStatuses.map((status) {
            final statusName = status['StatusName'] ?? '';
            final statusId = status['BusCRMSalesStatusid'].toString();
            final count = _crmList.where((c) => c['BusCRMSalesStatusid'].toString() == statusId).length;
            final isSelected = _selectedStatusFilter == statusId;
            return _buildFilterChip(
              label: statusName,
              count: count,
              isSelected: isSelected,
              color: _getStatusColor(statusName),
              onTap: () => setState(() {
                _selectedStatusFilter = isSelected ? '' : statusId;
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required int count, required bool isSelected, required Color color, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? color : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isSelected ? color : color.withOpacity(0.3), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(color: isSelected ? Colors.white : color, fontSize: 13, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: isSelected ? Colors.white.withOpacity(0.3) : color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        labelColor: const Color(0xFF0E5E83),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        tabs: _crmTypes.map((type) {
          final count = _crmList.where((crm) => crm['BusCRMTypeid'] == type['BusCRMTypeid']).length;
          return Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: Text(type['CRMTypeName'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis)),
                if (count > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _currentTypeIndex == _crmTypes.indexOf(type) ? const Color(0xFF0E5E83).withOpacity(0.15) : const Color(0xFF9CA3AF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      count.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _currentTypeIndex == _crmTypes.indexOf(type) ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactsList() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    if (isDesktop) {
      return _buildDesktopTable();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredCRMList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final crm = _filteredCRMList[index];
        return _buildContactCard(crm, isMobile);
      },
    );
  }

  Widget _buildDesktopTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 56,
            dataRowMinHeight: 72,
            dataRowMaxHeight: 72,
            horizontalMargin: 24,
            columnSpacing: 32,
            headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
            decoration: const BoxDecoration(color: Colors.white),
            columns: const [
              DataColumn(
                label: Text(
                  'CONTACT',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'MOBILE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'TYPE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'STATUS',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'SOURCE',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'FOLLOW-UP',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
              DataColumn(
                label: Text(
                  'NOTES',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
                ),
              ),
            ],
            rows: _filteredCRMList.map((crm) {
              final statusName = crm['StatusName'] ?? '';
              final statusColor = _getStatusColor(statusName);
              final sourceName = crm['BusCRMSourceName'] ?? '-';
              final followDate = crm['FollowDate'] ?? 'N/A';
              final notes = crm['CRMNotes'] ?? '-';
              return DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [const Color(0xFF0E5E83), const Color(0xFF0E5E83).withOpacity(0.7)]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              (crm['CRMParty'] ?? 'U')[0].toUpperCase(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            crm['CRMParty'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    InkWell(
                      onTap: () {
                        if (crm['MobileNumber'] != null) {
                          _makePhoneCall(crm['MobileNumber']);
                        }
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF10B981)),
                            const SizedBox(width: 6),
                            Text(
                              crm['MobileNumber'] ?? 'N/A',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF10B981), fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.2)),
                      ),
                      child: Text(
                        crm['CRMTypeName'] ?? 'N/A',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B)),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusName,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: statusColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      sourceName,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF6B7280)),
                        const SizedBox(width: 6),
                        Text(
                          followDate,
                          style: const TextStyle(fontSize: 13, color: Color(0xFF111827), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        notes,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontStyle: FontStyle.italic),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> crm, bool isMobile) {
    final statusName = crm['StatusName'] ?? '';
    final statusColor = _getStatusColor(statusName);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [const Color(0xFF0E5E83), const Color(0xFF0E5E83).withOpacity(0.7)]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          (crm['CRMParty'] ?? 'U')[0].toUpperCase(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crm['CRMParty'] ?? 'Unknown',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF6B7280)),
                              const SizedBox(width: 4),
                              Text(
                                crm['MobileNumber'] ?? 'N/A',
                                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            statusName,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: statusColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE5E7EB)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildInfoTag(Icons.event_rounded, crm['FollowDate'] ?? 'N/A', const Color(0xFF0E5E83))),
                    const SizedBox(width: 8),
                    Expanded(child: _buildInfoTag(Icons.category_rounded, crm['CRMTypeName'] ?? 'N/A', const Color(0xFFF59E0B))),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (crm['MobileNumber'] != null) {
                            _makePhoneCall(crm['MobileNumber']);
                          }
                        },
                        icon: const Icon(Icons.call_rounded, size: 18),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.visibility_rounded, size: 18),
                        label: const Text('View'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0E5E83),
                          side: const BorderSide(color: Color(0xFF0E5E83), width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContacts() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(50)),
              child: Icon(_searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? Icons.people_outline_rounded : Icons.search_off_rounded, size: 48, color: const Color(0xFF0E5E83)),
            ),
            const SizedBox(height: 20),
            Text(
              _searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? 'No Contacts Yet' : 'No Results Found',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? 'Start by adding your first contact' : 'Try adjusting your search or filters',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color(0xFF0E5E83).withOpacity(0.1), const Color(0xFF1E88B7).withOpacity(0.1)]),
                borderRadius: BorderRadius.circular(70),
              ),
              child: const Icon(Icons.settings_suggest_rounded, size: 70, color: Color(0xFF0E5E83)),
            ),
            const SizedBox(height: 32),
            const Text(
              'Configuration Required',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please contact your administrator to\nconfigure CRM types to get started',
              style: TextStyle(fontSize: 15, color: Color(0xFF6B7280), height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _loadInitialData,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E5E83),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerKPIs() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Row(
        children: List.generate(4, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                height: 120,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                height: 100,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContactsShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 140,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color(0xFF0EA5E9);
      case 'follow up':
        return const Color(0xFFF59E0B);
      case 'close':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

class _StatCard {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final List<Color> gradient;

  _StatCard({required this.icon, required this.label, required this.value, required this.color, required this.gradient});
}
