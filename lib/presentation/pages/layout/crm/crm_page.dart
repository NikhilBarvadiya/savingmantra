import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmantra/domain/repositories/crm_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class CRMPage extends StatefulWidget {
  const CRMPage({super.key});

  @override
  State<CRMPage> createState() => _CRMPageState();
}

class _CRMPageState extends State<CRMPage> with SingleTickerProviderStateMixin {
  final CrmRepository _crmRepository = CrmRepository();
  bool _isLoading = true, _showAddForm = false, _isSubmitting = false;
  List<Map<String, dynamic>> _crmTypes = [], _crmSources = [];
  List<Map<String, dynamic>> _crmStatuses = [], _crmList = [];
  TabController? _tabController;
  String _searchQuery = '', _selectedStatusFilter = '';

  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  final ScrollController _scrollController = ScrollController();
  int _currentTypeIndex = 0;

  late final TextEditingController _newPartyController;
  late final TextEditingController _newMobileController;
  late final TextEditingController _newNotesController;
  String? _newSelectedTypeId, _newSelectedSourceId;
  late DateTime _newSelectedDate;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    _newPartyController = TextEditingController();
    _newMobileController = TextEditingController();
    _newNotesController = TextEditingController();
    _newSelectedDate = DateTime.now();
    super.initState();
    _loadData();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      await _loadMasters();
      await _loadCRMList();
    } catch (e) {
      _showError('Failed to load data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMasters() async {
    try {
      final response = await _crmRepository.getCrmMasters();
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
      throw Exception('Failed to load masters: $e');
    }
  }

  Future<void> _loadCRMList() async {
    if (!mounted || _tabController == null) return;
    try {
      final currentTypeId = _crmTypes[_tabController!.index]['BusCRMTypeid'];
      final response = await _crmRepository.getCrmList(busCRMTypeid: currentTypeId.toString(), busCRMSalesStatusid: _selectedStatusFilter);
      if (mounted) {
        setState(() {
          _crmList = (response as List?)?.cast<Map<String, dynamic>>() ?? [];
        });
      }
    } catch (e) {
      _showError('Failed to load CRM list: $e');
    }
  }

  Future<void> _submitNewCRM() async {
    if (_newPartyController.text.isEmpty || _newMobileController.text.isEmpty || _newSelectedTypeId == null) {
      _showError('Please fill all required fields');
      return;
    }
    if (!RegExp(r'^\d{10}$').hasMatch(_newMobileController.text)) {
      _showError('Please enter a valid 10-digit mobile number');
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      await _crmRepository.addCrm(
        busCRMTypeid: _newSelectedTypeId!,
        followDate: DateFormat('yyyy-MM-dd').format(_newSelectedDate),
        crmParty: _newPartyController.text,
        mobileNumber: _newMobileController.text,
        crmNotes: _newNotesController.text,
        busCRMSourceId: _newSelectedSourceId ?? '',
      );
      _newPartyController.clear();
      _newMobileController.clear();
      _newNotesController.clear();
      _newSelectedDate = DateTime.now();
      _newSelectedSourceId = null;
      await _loadCRMList();
      if (mounted) {
        setState(() => _showAddForm = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('CRM added successfully'),
              ],
            ),
            backgroundColor: Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      _showError('Failed to add CRM: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
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
    if (picked != null) {
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
      filtered = filtered.where((crm) => crm['BusCRMSalesStatusid'] == _selectedStatusFilter).toList();
    }
    return filtered;
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      _showError('Unable to make call');
    }
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatusFilter = '';
    });
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
      appBar: _buildAppBar(context),
      body: _isLoading ? _buildLoadingState() : _buildContent(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CRM Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
          ),
          if (!isMobile)
            const Text(
              'Manage customer relationships',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF6B7280)),
            ),
        ],
      ),
      actions: [
        if (!isMobile) ...[
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF6B7280)),
            onPressed: _loadData,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Color(0xFF6B7280)),
            onPressed: () {},
            tooltip: 'Export',
          ),
        ],
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: const Color(0xFFE5E7EB)),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    if (!isMobile) return const SizedBox.shrink();
    return FloatingActionButton.extended(
      onPressed: () => setState(() => _showAddForm = !_showAddForm),
      backgroundColor: const Color(0xFF0E5E83),
      icon: Icon(_showAddForm ? Icons.close : Icons.add),
      label: Text(_showAddForm ? 'Close' : 'Add CRM'),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF0E5E83))),
          SizedBox(height: 16),
          Text('Loading CRM data...', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_crmTypes.isEmpty) {
      return _buildEmptyState();
    }
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isMobile = MediaQuery.of(context).size.width < 768;
    return RefreshIndicator(
      onRefresh: _loadData,
      color: const Color(0xFF0E5E83),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKPISection(context),
            const SizedBox(height: 24),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_showAddForm) ...[Expanded(flex: 2, child: _buildNewCRMForm(context)), const SizedBox(width: 24)],
                  Expanded(flex: _showAddForm ? 3 : 1, child: _buildCRMListingPanel(context)),
                ],
              )
            else
              Column(
                children: [
                  if (_showAddForm) ...[_buildNewCRMForm(context), const SizedBox(height: 24)],
                  _buildCRMListingPanel(context),
                ],
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
              width: 120,
              height: 120,
              decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(60)),
              child: const Icon(Icons.people_outline, size: 60, color: Color(0xFF0E5E83)),
            ),
            const SizedBox(height: 24),
            const Text(
              'No CRM Types Available',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please contact your administrator to configure\nCRM types before getting started',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPISection(BuildContext context) {
    final totalEntries = _crmList.length;
    final activeEntries = _crmList.where((c) => c['StatusName'] == 'Follow Up').length;
    final newEntries = _crmList.where((c) => c['StatusName'] == 'New').length;
    final closedEntries = _crmList.where((c) => c['StatusName'] == 'Close').length;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final kpis = [
      _KPIData('Total', totalEntries, Icons.groups_2, const Color(0xFF0E5E83)),
      _KPIData('Active', activeEntries, Icons.trending_up, const Color(0xFF10B981)),
      _KPIData('New', newEntries, Icons.fiber_new, const Color(0xFFF59E0B)),
      _KPIData('Closed', closedEntries, Icons.check_circle, const Color(0xFF8B5CF6)),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: isMobile
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.3),
              itemCount: kpis.length,
              itemBuilder: (context, index) => _buildKPICard(kpis[index], true),
            )
          : Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: kpis.map((kpi) {
                  return Expanded(
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: _buildKPICard(kpi, false)),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildKPICard(_KPIData kpi, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: kpi.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kpi.color.withOpacity(0.1), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 40 : 56,
            height: isMobile ? 40 : 56,
            decoration: BoxDecoration(color: kpi.color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(kpi.icon, color: kpi.color, size: isMobile ? 20 : 28),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            kpi.count.toString(),
            style: TextStyle(fontSize: isMobile ? 24 : 32, fontWeight: FontWeight.w800, color: const Color(0xFF111827)),
          ),
          const SizedBox(height: 4),
          Text(
            kpi.label,
            style: TextStyle(fontSize: isMobile ? 12 : 14, color: const Color(0xFF6B7280), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildNewCRMForm(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
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
                  gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person_add_outlined, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Contact',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('Create new CRM entry', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile) IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => setState(() => _showAddForm = false), color: const Color(0xFF6B7280)),
            ],
          ),
          const SizedBox(height: 24),
          _buildFormField('Party Name *', TextField(controller: _newPartyController, decoration: _buildInputDecoration('Enter full name', Icons.person_outline))),
          const SizedBox(height: 16),
          _buildFormField(
            'Mobile Number *',
            TextField(controller: _newMobileController, keyboardType: TextInputType.phone, maxLength: 10, decoration: _buildInputDecoration('10-digit mobile', Icons.phone_outlined)),
          ),
          const SizedBox(height: 16),
          _buildFormField(
            'CRM Type *',
            DropdownButtonFormField<String>(
              value: _newSelectedTypeId,
              decoration: _buildInputDecoration('Select type', Icons.category_outlined),
              items: _crmTypes.map((type) {
                return DropdownMenuItem(value: type['BusCRMTypeid'].toString(), child: Text(type['CRMTypeName'] ?? ''));
              }).toList(),
              onChanged: (value) => setState(() => _newSelectedTypeId = value),
            ),
          ),
          const SizedBox(height: 16),
          if (_crmSources.isNotEmpty) ...[
            _buildFormField(
              'Source',
              DropdownButtonFormField<String>(
                value: _newSelectedSourceId,
                decoration: _buildInputDecoration('Select source', Icons.source_outlined),
                items: [
                  const DropdownMenuItem(value: '', child: Text('None')),
                  ..._crmSources.map((source) {
                    return DropdownMenuItem(value: source['BusCRMSourceId'].toString(), child: Text(source['BusCRMSourceName'] ?? ''));
                  }),
                ],
                onChanged: (value) => setState(() => _newSelectedSourceId = value),
              ),
            ),
            const SizedBox(height: 16),
          ],
          _buildFormField(
            'Follow-up Date *',
            InkWell(
              onTap: _selectDate,
              child: InputDecorator(decoration: _buildInputDecoration(DateFormat('dd MMM yyyy').format(_newSelectedDate), Icons.calendar_today_outlined), child: const SizedBox()),
            ),
          ),
          const SizedBox(height: 16),
          _buildFormField('Notes', TextField(controller: _newNotesController, maxLines: 3, decoration: _buildInputDecoration('Additional notes...', Icons.notes_outlined))),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
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
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 20),
                        SizedBox(width: 8),
                        Text('Add Contact', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
      prefixIcon: icon != null ? Icon(icon, size: 20, color: const Color(0xFF6B7280)) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
      ),
    );
  }

  Widget _buildCRMListingPanel(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
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
                  gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.list_alt_outlined, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CRM Contacts',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('${_filteredCRMList.length} contacts found', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile && !_showAddForm)
                ElevatedButton.icon(
                  onPressed: () => setState(() => _showAddForm = true),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add New'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0E5E83),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSearchFilterSection(context),
          const SizedBox(height: 20),
          if (_crmTypes.length > 1) ...[_buildCRMTypeTabs(context), const SizedBox(height: 20)],
          if (_filteredCRMList.isEmpty) _buildEmptyResultsState() else (isMobile ? _buildCRMListView() : _buildCRMTable()),
        ],
      ),
    );
  }

  Widget _buildSearchFilterSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF9FAFB),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search contacts...',
                    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF6B7280), size: 20),
                    suffixIcon: _searchQuery.isNotEmpty ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: () => _searchController.clear(), color: const Color(0xFF6B7280)) : null,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.filter_alt_off, size: 18),
                label: const Text('Clear'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  foregroundColor: const Color(0xFF6B7280),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        if (_crmStatuses.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusChip('All', _crmList.length, _selectedStatusFilter.isEmpty, const Color(0xFF0E5E83), () => setState(() => _selectedStatusFilter = '')),
                ..._crmStatuses.map((status) {
                  final statusName = status['StatusName'] ?? '';
                  final statusId = status['BusCRMSalesStatusid'].toString();
                  final count = _crmList.where((c) => c['BusCRMSalesStatusid'] == statusId).length;
                  final isSelected = _selectedStatusFilter == statusId;
                  return _buildStatusChip(statusName, count, isSelected, _getStatusColor(statusName), () => setState(() => _selectedStatusFilter = isSelected ? '' : statusId));
                }),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStatusChip(String label, int count, bool isSelected, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? color : color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? color : color.withOpacity(0.2), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(color: isSelected ? Colors.white : color, fontSize: 13, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: isSelected ? Colors.white.withOpacity(0.25) : color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : color),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCRMTypeTabs(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        labelColor: const Color(0xFF0E5E83),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        tabs: _crmTypes.map((type) {
          final count = _crmList.where((crm) => crm['BusCRMTypeid'] == type['BusCRMTypeid']).length;
          return Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(type['CRMTypeName'] ?? ''),
                if (count > 0) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _currentTypeIndex == _crmTypes.indexOf(type) ? const Color(0xFF0E5E83).withOpacity(0.2) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      count.toString(),
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _currentTypeIndex == _crmTypes.indexOf(type) ? const Color(0xFF0E5E83) : Colors.grey[700]),
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

  Widget _buildCRMListView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredCRMList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final crm = _filteredCRMList[index];
        final statusName = crm['StatusName'] ?? '';

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // Navigate to detail
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF0E5E83).withOpacity(0.1),
                          child: Text(
                            (crm['CRMParty'] ?? 'U')[0].toUpperCase(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0E5E83)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                crm['CRMParty'] ?? 'Unknown',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                              ),
                              const SizedBox(height: 2),
                              Text(crm['MobileNumber'] ?? 'N/A', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            ],
                          ),
                        ),
                        _StatusBadge(text: statusName, type: _getStatusType(statusName)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildInfoChip(Icons.event_outlined, crm['FollowDate'] ?? 'N/A')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildInfoChip(Icons.category_outlined, crm['CRMTypeName'] ?? 'N/A')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              if (crm['MobileNumber'] != null) {
                                _makePhoneCall(crm['MobileNumber']);
                              }
                            },
                            icon: const Icon(Icons.call, size: 16),
                            label: const Text('Call'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF10B981),
                              side: const BorderSide(color: Color(0xFF10B981)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility, size: 16),
                            label: const Text('View'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0E5E83),
                              side: const BorderSide(color: Color(0xFF0E5E83)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF0E5E83)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: Color(0xFF0E5E83), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCRMTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
          dataRowColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.hovered) ? const Color(0xFFF9FAFB) : Colors.white),
          columns: const [
            DataColumn(
              label: Text(
                'Contact',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Mobile',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Source',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Follow-up',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF374151)),
              ),
            ),
          ],
          rows: _filteredCRMList.map((crm) {
            final statusName = crm['StatusName'] ?? '';
            final sourceName = crm['BusCRMSourceName'] ?? '';
            final followDate = crm['FollowDate'] ?? '';

            return DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: const Color(0xFF0E5E83).withOpacity(0.1),
                        child: Text(
                          (crm['CRMParty'] ?? 'U')[0].toUpperCase(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0E5E83)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 150,
                        child: Text(
                          crm['CRMParty'] ?? 'Unknown',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                DataCell(Text(crm['MobileNumber'] ?? 'N/A', style: const TextStyle(fontFamily: 'monospace'))),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      crm['CRMTypeName'] ?? '',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
                    ),
                  ),
                ),
                DataCell(_StatusBadge(text: statusName, type: _getStatusType(statusName))),
                DataCell(
                  sourceName.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            sourceName,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
                          ),
                        )
                      : const Text('-'),
                ),
                DataCell(Text(followDate.isNotEmpty ? followDate : 'N/A', style: const TextStyle(fontSize: 13))),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.call, size: 18),
                        color: const Color(0xFF10B981),
                        onPressed: () {
                          if (crm['MobileNumber'] != null) {
                            _makePhoneCall(crm['MobileNumber']);
                          }
                        },
                        tooltip: 'Call',
                      ),
                      IconButton(icon: const Icon(Icons.visibility, size: 18), color: const Color(0xFF6B7280), onPressed: () {}, tooltip: 'View Details'),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyResultsState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(40)),
            child: Icon(_searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? Icons.people_outline : Icons.search_off_outlined, size: 40, color: const Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 20),
          Text(
            _searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? 'No contacts yet' : 'No results found',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty && _selectedStatusFilter.isEmpty ? 'Add your first contact to get started' : 'Try adjusting your search or filters',
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ],
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

  _StatusType _getStatusType(String status) {
    switch (status.toLowerCase()) {
      case 'new':
      case 'follow up':
        return _StatusType.warning;
      case 'close':
        return _StatusType.success;
      default:
        return _StatusType.warning;
    }
  }
}

class _KPIData {
  final String label;
  final int count;
  final IconData icon;
  final Color color;

  _KPIData(this.label, this.count, this.icon, this.color);
}

enum _StatusType { success, warning }

class _StatusBadge extends StatelessWidget {
  final String text;
  final _StatusType type;

  const _StatusBadge({required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (type) {
      case _StatusType.success:
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF166534);
        icon = Icons.check_circle_outline;
        break;
      case _StatusType.warning:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFF92400E);
        icon = Icons.access_time_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }
}
