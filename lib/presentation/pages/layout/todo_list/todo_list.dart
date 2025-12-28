import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmantra/domain/repositories/todo/todo_repository.dart';
import 'package:shimmer/shimmer.dart';

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

  bool _isLoadingMasters = true, _isLoadingTasks = false, _isSubmitting = false;

  DateTime _selectedDate = DateTime.now();
  int _selectedTabIndex = 0;

  final Map<String, String> _statusMap = {'Open': 'O', 'Complete': 'C', 'Delete': 'D'};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (_tabController.index < 0) {
          _tabController.animateTo(0);
        }
        _loadInitialData();
      }
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    final newIndex = _tabController.index;
    if (newIndex < 0 || newIndex == _selectedTabIndex) return;
    if (mounted) {
      setState(() {
        _selectedTabIndex = newIndex;
        _isLoadingTasks = true;
      });
      _fetchTasks();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoadingMasters = true);
    try {
      await _fetchTasks();
    } catch (e) {
      _showSnackBar('Failed to load data: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoadingMasters = false);
      }
    }
  }

  Future<void> _refreshData() async {
    setState(() => _isLoadingTasks = true);
    await _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      if (_selectedTabIndex < 0 || _selectedTabIndex >= _statusMap.length) {
        if (mounted) {
          setState(() {
            _selectedTabIndex = 0;
            _isLoadingTasks = false;
          });
        }
        return;
      }
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
          _isLoadingTasks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingTasks = false);
        _showSnackBar('Failed to load tasks: $e', isError: true);
      }
    }
  }

  Future<void> _addTask() async {
    if (_taskController.text.trim().isEmpty) {
      _showSnackBar('Please enter task description', isError: true);
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final formattedDate = DateFormat('d MMM yyyy').format(_selectedDate);
      final response = await _todoRepository.addTodo(planDate: formattedDate, taskDes: _taskController.text.trim());
      if (response['Message'] == 'Planner Added Successfully') {
        _taskController.clear();
        await _fetchTasks();
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
          _showSnackBar('✓ Task added successfully!', isError: false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        _showSnackBar('Failed to add task: $e', isError: true);
      }
    }
  }

  Future<void> _updateTaskStatus(String busPlannerid, String newStatus) async {
    setState(() => _isLoadingTasks = true);
    try {
      final response = await _todoRepository.updateTodoStatus(busPlannerid: busPlannerid, planStatus: newStatus);
      if (response['Message'] == 'Business Planner Status Updated Successfully') {
        await _fetchTasks();
        if (mounted) {
          _showSnackBar(newStatus == 'C' ? '✓ Task completed!' : '✓ Task deleted!', isError: false);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingTasks = false);
        _showSnackBar('Failed to update status: $e', isError: true);
      }
    }
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
    return Scaffold(backgroundColor: const Color(0xFFF8FAFC), body: _isLoadingMasters ? _buildInitialLoading() : _buildMainContent(context));
  }

  Widget _buildInitialLoading() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(delegate: SliverChildListDelegate([_buildShimmerKPIs(), const SizedBox(height: 24), _buildShimmerCard(), const SizedBox(height: 24), _buildShimmerList()])),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isMobile = MediaQuery.of(context).size.width < 768;
    return CustomScrollView(
      slivers: [
        _buildAppBar(context),
        SliverPadding(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickStats(context),
              const SizedBox(height: 24),
              _buildDatePicker(context),
              const SizedBox(height: 24),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildAddTaskForm(context)),
                    const SizedBox(width: 24),
                    Expanded(flex: 3, child: _buildTaskListPanel(context)),
                  ],
                )
              else
                Column(children: [_buildAddTaskForm(context), const SizedBox(height: 24), _buildTaskListPanel(context)]),
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
                    child: const Icon(Icons.task_alt_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To-Do Dashboard',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827), letterSpacing: -0.5),
                        ),
                        if (!isMobile)
                          const Text(
                            'Manage and track your daily tasks',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
                          ),
                      ],
                    ),
                  ),
                  if (!isMobile) ...[
                    IconButton(
                      icon: _isLoadingTasks
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Color(0xFF0E5E83))))
                          : const Icon(Icons.refresh_rounded),
                      onPressed: _isLoadingTasks ? null : _refreshData,
                      tooltip: 'Refresh',
                      color: const Color(0xFF6B7280),
                    ),
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
    final totalTasks = _tasks.length;
    final openTasks = _tasks.where((t) => t['planStatus'] == 'o').length;
    final completedTasks = _tasks.where((t) => t['planStatus'] == 'c').length;
    final deletedTasks = _tasks.where((t) => t['planStatus'] == 'd').length;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final stats = [
      _StatCard(icon: Icons.list_alt_rounded, label: 'Total Tasks', value: totalTasks.toString(), color: const Color(0xFF0E5E83), gradient: [const Color(0xFF0E5E83), const Color(0xFF1E88B7)]),
      _StatCard(icon: Icons.pending_actions_rounded, label: 'Open Tasks', value: openTasks.toString(), color: const Color(0xFF3B82F6), gradient: [const Color(0xFF3B82F6), const Color(0xFF2563EB)]),
      _StatCard(icon: Icons.check_circle_rounded, label: 'Completed', value: completedTasks.toString(), color: const Color(0xFF10B981), gradient: [const Color(0xFF10B981), const Color(0xFF059669)]),
      _StatCard(icon: Icons.delete_rounded, label: 'Deleted', value: deletedTasks.toString(), color: const Color(0xFFEF4444), gradient: [const Color(0xFFEF4444), const Color(0xFFDC2626)]),
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

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0E5E83), Color(0xFF1E88B7)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Date',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.w600, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE, dd MMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
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
                    _isLoadingTasks = true;
                  });
                  WidgetsBinding.instance.addPostFrameCallback((_) => _fetchTasks());
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.edit_calendar_rounded, color: Color(0xFF0E5E83), size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddTaskForm(BuildContext context) {
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
                child: const Icon(Icons.add_task_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Task',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('Create a new to-do item', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
              if (!isMobile)
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 22),
                  onPressed: () => setState(() {
                    _taskController.clear();
                  }),
                  color: const Color(0xFF6B7280),
                ),
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
                child: Icon(Icons.edit_note_rounded, size: 24, color: Color(0xFF6B7280)),
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
            height: 52,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _addTask,
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
                        Text('Add Task', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                child: const Icon(Icons.format_list_bulleted_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Tasks',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    Text('${_tasks.length} ${_tasks.length == 1 ? 'task' : 'tasks'}', style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildStatusTabs(context),
          const SizedBox(height: 20),
          if (_isLoadingTasks) _buildTasksShimmer() else if (_tasks.isEmpty) _buildEmptyState() else _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildStatusTabs(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(12)),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: const Color(0xFF0E5E83),
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontSize: 14, letterSpacing: .5, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 14, letterSpacing: .5, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
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
    final statusColor = _getStatusColor(taskStatus);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withOpacity(0.3), width: 2),
                  ),
                  child: Center(child: Icon(_getStatusIcon(taskStatus), color: statusColor, size: 22)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['taskDes']?.toString() ?? 'No Description',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF111827),
                          decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          decorationColor: const Color(0xFF9CA3AF),
                          decorationThickness: 2,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (createdDate.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time_rounded, size: 14, color: statusColor),
                            const SizedBox(width: 4),
                            Text(
                              _getTimeOnly(createdDate),
                              style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.calendar_today_rounded, size: 12, color: const Color(0xFF6B7280)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                _formatCreatedDate(createdDate),
                                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatusBadge(taskStatus),
              ],
            ),
            if (!isCompleted && !isDeleted) ...[
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: _buildActionButton(icon: Icons.check_circle_rounded, label: 'Complete', color: const Color(0xFF10B981), onPressed: () => _updateTaskStatus(task['busPlannerid'], 'C')),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildActionButton(icon: Icons.delete_rounded, label: 'Delete', color: const Color(0xFFEF4444), onPressed: () => _updateTaskStatus(task['busPlannerid'], 'D')),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
      ),
      child: Text(
        statusText,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor, letterSpacing: 0.3),
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
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: const Color(0xFFF0F9FF), borderRadius: BorderRadius.circular(50)),
            child: const Icon(Icons.task_alt_rounded, size: 48, color: Color(0xFF0E5E83)),
          ),
          const SizedBox(height: 20),
          const Text(
            'No Tasks Yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
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

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
          children: List.generate(4, (index) {
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

  Widget _buildTasksShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Column(
        children: List.generate(3, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              height: 120,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          );
        }),
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
        return 'COMPLETED';
      case 'd':
        return 'DELETED';
      case 'o':
      default:
        return 'OPEN';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'c':
        return Icons.check_circle_rounded;
      case 'd':
        return Icons.delete_rounded;
      case 'o':
      default:
        return Icons.pending_rounded;
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
