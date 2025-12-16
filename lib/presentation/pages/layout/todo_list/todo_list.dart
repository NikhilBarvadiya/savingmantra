import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmantra/domain/repositories/todo_repository.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with SingleTickerProviderStateMixin {
  final TodoRepository _todoRepository = TodoRepository();
  late TabController _tabController;
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  bool _isLoading = true, _showAddForm = false;
  DateTime _selectedDate = DateTime.now();
  int _selectedTabIndex = 0;

  final Map<String, String> _statusMap = {'Open': 'O', 'Complete': 'C', 'Delete': 'D'};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.index != _selectedTabIndex) {
      setState(() {
        _selectedTabIndex = _tabController.index;
        _isLoading = true;
      });
      _fetchTasks();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      await _fetchTasks();
    } catch (e) {
      _showError('Failed to load data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchTasks() async {
    try {
      final formattedDate = DateFormat('d MMM yyyy').format(_selectedDate);
      final statusCode = _statusMap.values.elementAt(_selectedTabIndex);
      final response = await _todoRepository.getTodoList(planDate: formattedDate, planStatus: statusCode);
      if (mounted) {
        setState(() {
          _tasks.clear();
          _tasks.addAll(
            response.map((task) {
              return {
                'taskDes': task['TaskDes'] ?? 'No Description',
                'busPlannerid': task['BusPlannerId'] ?? '',
                'planStatus': task['PlanStatus']?.toLowerCase() ?? _statusMap.keys.elementAt(_selectedTabIndex).toLowerCase(),
                'createdDate': task['CreatedDate'] ?? '',
                'planDate': task['PlanDate'] ?? '',
              };
            }).toList(),
          );
        });
      }
    } catch (e) {
      _showError('Failed to load tasks: $e');
    }
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _addTask() async {
    if (_taskController.text.isEmpty) {
      _showError('Please enter task description');
      return;
    }
    try {
      final formattedDate = DateFormat('d MMM yyyy').format(_selectedDate);
      final response = await _todoRepository.addTodo(planDate: formattedDate, taskDes: _taskController.text);
      if (response['Message'] == 'Planner Added Successfully') {
        _taskController.clear();
        setState(() => _showAddForm = false);
        await _fetchTasks();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Task added successfully'),
                ],
              ),
              backgroundColor: Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      _showError('Failed to add task: $e');
    }
  }

  Future<void> _updateTaskStatus(String busPlannerid, String newStatus) async {
    try {
      setState(() => _isLoading = true);
      final response = await _todoRepository.updateTodoStatus(busPlannerid: busPlannerid, planStatus: newStatus);
      if (response['Message'] == 'Business Planner Status Updated Successfully') {
        await _fetchTasks();
      }
    } catch (e) {
      _showError('Failed to update status: $e');
      setState(() => _isLoading = false);
    }
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

  String _formatCreatedDate(String createdDate) {
    try {
      final parts = createdDate.split(' ');
      if (parts.length >= 2) {
        final datePart = parts[0];
        final dateComponents = datePart.split('/');
        if (dateComponents.length == 3) {
          final day = dateComponents[0];
          final month = dateComponents[1];
          final year = dateComponents[2];
          return '$day $month $year';
        }
      }
      return createdDate;
    } catch (e) {
      return createdDate;
    }
  }

  String _getTimeOnly(String createdDate) {
    try {
      final parts = createdDate.split(' ');
      if (parts.length >= 2) {
        final timePart = parts[1];
        final timeComponents = timePart.split(':');
        if (timeComponents.length >= 2) {
          int hour = int.parse(timeComponents[0]);
          final minute = timeComponents[1];

          String period = 'AM';
          if (hour >= 12) {
            period = 'PM';
            if (hour > 12) hour -= 12;
          }
          if (hour == 0) hour = 12;

          return '$hour:$minute $period';
        }
      }
      return 'N/A';
    } catch (e) {
      return 'N/A';
    }
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
            'To-Do List',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
          ),
          if (!isMobile)
            const Text(
              'Manage your daily tasks',
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
      label: Text(_showAddForm ? 'Close' : 'Add Task'),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF0E5E83))),
          SizedBox(height: 16),
          Text('Loading tasks...', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
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
            _buildDatePicker(context),
            const SizedBox(height: 24),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_showAddForm) ...[Expanded(flex: 2, child: _buildAddTaskForm(context)), const SizedBox(width: 24)],
                  Expanded(flex: _showAddForm ? 3 : 1, child: _buildTaskListPanel(context)),
                ],
              )
            else
              Column(
                children: [
                  if (_showAddForm) ...[_buildAddTaskForm(context), const SizedBox(height: 24)],
                  _buildTaskListPanel(context),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPISection(BuildContext context) {
    final totalTasks = _tasks.length;
    final openTasks = _tasks.where((t) => t['planStatus'] == 'o').length;
    final completedTasks = _tasks.where((t) => t['planStatus'] == 'c').length;
    final deletedTasks = _tasks.where((t) => t['planStatus'] == 'd').length;

    final isMobile = MediaQuery.of(context).size.width < 768;

    final kpis = [
      _KPIData('Total', totalTasks, Icons.list_alt, const Color(0xFF0E5E83)),
      _KPIData('Open', openTasks, Icons.pending_actions, const Color(0xFF3B82F6)),
      _KPIData('Done', completedTasks, Icons.check_circle, const Color(0xFF10B981)),
      _KPIData('Deleted', deletedTasks, Icons.delete, const Color(0xFFEF4444)),
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

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_today, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Date',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE, dd MMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
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

              if (picked != null && picked != _selectedDate) {
                setState(() {
                  _selectedDate = picked;
                  _isLoading = true;
                });
                await _fetchTasks();
              }
            },
            icon: const Icon(Icons.edit_calendar, color: Color(0xFF0E5E83)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskForm(BuildContext context) {
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
                child: const Icon(Icons.add_task, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Task',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('Create a new to-do item', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile) IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => setState(() => _showAddForm = false), color: const Color(0xFF6B7280)),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _taskController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter task description...',
              hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 16, right: 12, top: 12),
                child: Icon(Icons.edit_note, size: 24, color: Color(0xFF6B7280)),
              ),
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
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0E5E83),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Text('Add Task', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListPanel(BuildContext context) {
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
                child: const Icon(Icons.format_list_bulleted, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Tasks',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('${_tasks.length} tasks found', style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile && !_showAddForm)
                ElevatedButton.icon(
                  onPressed: () => setState(() => _showAddForm = true),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Task'),
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
          _buildStatusTabs(context),
          const SizedBox(height: 20),
          if (_tasks.isEmpty) _buildEmptyState() else _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildStatusTabs(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: const Color(0xFF0E5E83),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Open'),
          Tab(text: 'Complete'),
          Tab(text: 'Delete'),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tasks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return _buildTaskCard(task);
      },
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final String taskStatus = task['planStatus']?.toString().toLowerCase() ?? 'o';
    final bool isCompleted = taskStatus == 'c';
    final bool isDeleted = taskStatus == 'd';
    final String createdDate = task['createdDate']?.toString() ?? '';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(color: _getStatusColor(taskStatus), borderRadius: BorderRadius.circular(6)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task['taskDes']?.toString() ?? 'No Description',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                      decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                      decorationColor: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusBadge(taskStatus),
              ],
            ),
            if (createdDate.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Color(0xFF6B7280)),
                  const SizedBox(width: 6),
                  Text(
                    'Created: ${_formatCreatedDate(createdDate)}',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      _getTimeOnly(createdDate),
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6)),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isCompleted)
                  _buildActionButton(icon: Icons.check_circle_outline, label: 'Complete', color: const Color(0xFF10B981), onPressed: () => _updateTaskStatus(task['busPlannerid'], 'C')),
                if (!isCompleted) const SizedBox(width: 8),
                if (!isDeleted) _buildActionButton(icon: Icons.delete_outline, label: 'Delete', color: const Color(0xFFEF4444), onPressed: () => _updateTaskStatus(task['busPlannerid'], 'D')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final String statusText = _getStatusText(status);
    final Color statusColor = _getStatusColor(status);
    final IconData statusIcon = _getStatusIcon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 12, color: statusColor),
          const SizedBox(width: 4),
          Text(
            statusText,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(40)),
            child: const Icon(Icons.task_alt, size: 40, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 20),
          const Text(
            'No tasks found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add your first task to get started',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'c':
        return const Color(0xFF10B981);
      case 'd':
        return const Color(0xFFEF4444);
      case 'o':
      default:
        return const Color(0xFF3B82F6);
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'c':
        return 'Completed';
      case 'd':
        return 'Deleted';
      case 'o':
      default:
        return 'Open';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'c':
        return Icons.check_circle;
      case 'd':
        return Icons.delete;
      case 'o':
      default:
        return Icons.pending;
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
