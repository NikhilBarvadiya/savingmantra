import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoTask> _tasks = [
    TodoTask(
      id: '1',
      title: 'Send GST documents to CA',
      module: 'Accounting',
      dueDate: DateTime.now(),
      priority: Priority.high,
      status: TaskStatus.open,
      description: 'Submit all GST documents for quarterly filing',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TodoTask(
      id: '2',
      title: 'Call back lead — Mr. Shah',
      module: 'CRM',
      dueDate: DateTime.now(),
      priority: Priority.medium,
      status: TaskStatus.open,
      description: 'Follow up on product inquiry from last week',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    TodoTask(
      id: '3',
      title: 'Review HR offer letter format',
      module: 'HR / Advisors',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: Priority.low,
      status: TaskStatus.planned,
      description: 'Update offer letter template with new policies',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TodoTask(
      id: '4',
      title: 'Approve invoices for October',
      module: 'Accounting',
      dueDate: DateTime.now().subtract(const Duration(days: 3)),
      priority: Priority.high,
      status: TaskStatus.overdue,
      description: 'Review and approve pending vendor invoices',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    TodoTask(
      id: '5',
      title: 'Prepare quarterly business report',
      module: 'Business Tools',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: Priority.medium,
      status: TaskStatus.planned,
      description: 'Compile performance metrics and analysis',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final TextEditingController _searchController = TextEditingController();

  String _selectedModule = 'All';
  String _selectedPriority = 'All';
  String _selectedStatus = 'All';

  List<TodoTask> get _filteredTasks {
    return _tasks.where((task) {
      final matchesSearch =
          _searchController.text.isEmpty || task.title.toLowerCase().contains(_searchController.text.toLowerCase()) || task.module.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesModule = _selectedModule == 'All' || task.module == _selectedModule;
      final matchesPriority = _selectedPriority == 'All' || task.priority.name == _selectedPriority.toLowerCase();
      final matchesStatus = _selectedStatus == 'All' || task.status.name == _selectedStatus.toLowerCase();
      return matchesSearch && matchesModule && matchesPriority && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F8FB);
    const muted = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: bg,
      appBar: CustomAppBar(
        title: 'To-Do',
        subtitle: 'Your daily tasks and priorities',
        leadingIcon: Icons.checklist_outlined,
        customActions: [AppBarActionButton(label: 'New Task', icon: Icons.add, onPressed: _showNewTaskDialog, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildKpiStrip(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      _DashboardCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _CardHeader(title: 'My Tasks', subtitle: 'Manage your daily tasks and priorities'),
                            const SizedBox(height: 20),
                            _buildTaskFilters(),
                            const SizedBox(height: 20),
                            _buildTasksList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      _DashboardCard(child: _buildQuickAddTask()),
                      const SizedBox(height: 16),
                      _DashboardCard(child: _buildTodaysFocus()),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('© ${DateTime.now().year} Saving Mantra — Business Tools · To-Do List v2.0', style: const TextStyle(fontSize: 11, color: muted)),
                  const Row(
                    children: [
                      Icon(Icons.help_outline, size: 12, color: muted),
                      SizedBox(width: 6),
                      Text('Need help? Contact support', style: TextStyle(fontSize: 11, color: muted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiStrip() {
    final openTasks = _tasks.where((task) => task.status == TaskStatus.open).length;
    final dueToday = _tasks.where((task) => task.dueDate.day == DateTime.now().day && task.status != TaskStatus.completed).length;
    final completedThisWeek = _tasks.where((task) => task.status == TaskStatus.completed && task.dueDate.isAfter(DateTime.now().subtract(const Duration(days: 7)))).length;
    final overdue = _tasks.where((task) => task.status == TaskStatus.overdue).length;
    return Row(
      children: [
        Expanded(
          child: _KpiCard(label: 'Open Tasks', value: openTasks.toString(), meta: 'Pending across all modules', trend: '+2', color: const Color(0xFF0E5E83)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _KpiCard(label: 'Due Today', value: dueToday.toString(), meta: 'Make sure to close these', trend: '+1', color: const Color(0xFFF59E0B)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _KpiCard(label: 'Completed (Week)', value: completedThisWeek.toString(), meta: 'Nice progress so far', trend: '+5', color: const Color(0xFF10B981)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _KpiCard(label: 'Overdue', value: overdue.toString(), meta: 'Older than 3 days', trend: '-1', color: const Color(0xFFEF4444)),
        ),
      ],
    );
  }

  Widget _buildTaskFilters() {
    return Row(
      children: [
        Expanded(
          child: _FilterDropdown(
            label: 'Module',
            value: _selectedModule,
            items: const ['All', 'Accounting', 'CRM', 'HR /` Advisors', 'Business Tools', 'Store'],
            onChanged: (value) => setState(() => _selectedModule = value!),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _FilterDropdown(label: 'Priority', value: _selectedPriority, items: const ['All', 'High', 'Medium', 'Low'], onChanged: (value) => setState(() => _selectedPriority = value!)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _FilterDropdown(
            label: 'Status',
            value: _selectedStatus,
            items: const ['All', 'Open', 'Planned', 'Completed', 'Overdue'],
            onChanged: (value) => setState(() => _selectedStatus = value!),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Search',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 6),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.search, size: 18, color: Color(0xFF6B7280)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Search tasks...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    if (_filteredTasks.isEmpty) {
      return const _EmptyState();
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'TASK',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'MODULE',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
              Expanded(
                child: Text(
                  'DUE DATE',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
              Expanded(
                child: Text(
                  'PRIORITY',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
              Expanded(
                child: Text(
                  'STATUS',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  'ACTIONS',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ..._filteredTasks.map((task) => _TaskItem(task: task, onEdit: () => _editTask(task), onDelete: () => _deleteTask(task), onStatusChange: (status) => _updateTaskStatus(task, status))),
      ],
    );
  }

  Widget _buildQuickAddTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CardHeader(title: 'Quick Add Task', subtitle: 'Add a quick reminder linked with your business modules'),
        const SizedBox(height: 20),
        _QuickAddForm(
          onSave: (title, module, priority, dueDate) {
            _addNewTask(title, module, priority, dueDate);
          },
        ),
      ],
    );
  }

  Widget _buildTodaysFocus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CardHeader(title: "Today's Focus"),
        const SizedBox(height: 16),
        const _FocusItem(icon: Icons.account_balance_wallet, text: 'Clear GST & accounting queries'),
        const _FocusItem(icon: Icons.people_alt, text: 'Follow up with 2 hot CRM leads'),
        const _FocusItem(icon: Icons.store, text: 'Review pending store orders'),
        const _FocusItem(icon: Icons.assignment, text: 'Prepare weekly team meeting agenda'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFBAE6FD)),
          ),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 16, color: Color(0xFF0E5E83)),
              SizedBox(width: 8),
              Expanded(
                child: Text('Focus on completing high-priority tasks first', style: TextStyle(fontSize: 12, color: Color(0xFF0E5E83))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showNewTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => _NewTaskDialog(
        onSave: (title, description, module, priority, dueDate) {
          _addNewTask(title, module, priority, dueDate);
        },
      ),
    );
  }

  void _addNewTask(String title, String module, Priority priority, DateTime dueDate) {
    final newTask = TodoTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      module: module,
      dueDate: dueDate,
      priority: priority,
      status: TaskStatus.open,
      description: '',
      createdAt: DateTime.now(),
    );
    setState(() {
      _tasks.insert(0, newTask);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task "$title" added successfully'), backgroundColor: const Color(0xFF10B981)));
  }

  void _editTask(TodoTask task) {}

  void _deleteTask(TodoTask task) {
    setState(() {
      _tasks.remove(task);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task "${task.title}" deleted'), backgroundColor: const Color(0xFFEF4444)));
  }

  void _updateTaskStatus(TodoTask task, TaskStatus status) {
    setState(() {
      task.status = status;
    });
  }
}

enum Priority { high, medium, low }

enum TaskStatus { open, planned, completed, overdue }

class TodoTask {
  String id;
  String title;
  String module;
  DateTime dueDate;
  Priority priority;
  TaskStatus status;
  String description;
  DateTime createdAt;

  TodoTask({required this.id, required this.title, required this.module, required this.dueDate, required this.priority, required this.status, required this.description, required this.createdAt});
}

class _DashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const _DashboardCard({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFF1F5F9)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 10, offset: Offset(0, 1))],
      ),
      child: child,
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _CardHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
        ),
        if (subtitle != null) ...[const SizedBox(height: 4), Text(subtitle!, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)))],
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String meta;
  final String trend;
  final Color color;

  const _KpiCard({required this.label, required this.value, required this.meta, required this.trend, required this.color});

  @override
  Widget build(BuildContext context) {
    return _DashboardCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Icon(Icons.trending_up, size: 16, color: color),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(
                  trend,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const _FilterDropdown({required this.label, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
              onChanged: onChanged,
              style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
              icon: const Icon(Icons.arrow_drop_down, size: 18, color: Color(0xFF6B7280)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskItem extends StatelessWidget {
  final TodoTask task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(TaskStatus) onStatusChange;

  const _TaskItem({required this.task, required this.onEdit, required this.onDelete, required this.onStatusChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF0F172A)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    task.description,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(task.module, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          ),
          Expanded(
            child: Text(
              DateFormat('MMM dd').format(task.dueDate),
              style: TextStyle(
                fontSize: 12,
                color: task.dueDate.isBefore(DateTime.now()) ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
                fontWeight: task.dueDate.isBefore(DateTime.now()) ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Expanded(child: _PriorityBadge(priority: task.priority)),
          Expanded(child: _StatusBadge(status: task.status)),
          SizedBox(
            width: 80,
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.edit, size: 14), onPressed: onEdit, padding: EdgeInsets.zero, constraints: const BoxConstraints(), color: const Color(0xFF0E5E83)),
                IconButton(icon: const Icon(Icons.delete, size: 14), onPressed: onDelete, padding: EdgeInsets.zero, constraints: const BoxConstraints(), color: const Color(0xFFEF4444)),
                PopupMenuButton<TaskStatus>(
                  icon: const Icon(Icons.more_vert, size: 14),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: TaskStatus.open, child: Text('Mark as Open')),
                    const PopupMenuItem(value: TaskStatus.planned, child: Text('Mark as Planned')),
                    const PopupMenuItem(value: TaskStatus.completed, child: Text('Mark as Completed')),
                  ],
                  onSelected: onStatusChange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final Priority priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String text;

    switch (priority) {
      case Priority.high:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        text = 'High';
        break;
      case Priority.medium:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        text = 'Medium';
        break;
      case Priority.low:
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        text = 'Low';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TaskStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String text;
    IconData icon;

    switch (status) {
      case TaskStatus.open:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        text = 'Open';
        icon = Icons.access_time;
        break;
      case TaskStatus.planned:
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        text = 'Planned';
        icon = Icons.schedule;
        break;
      case TaskStatus.completed:
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF15803D);
        text = 'Completed';
        icon = Icons.check_circle;
        break;
      case TaskStatus.overdue:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        text = 'Overdue';
        icon = Icons.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: fg),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}

class _QuickAddForm extends StatefulWidget {
  final Function(String, String, Priority, DateTime) onSave;

  const _QuickAddForm({required this.onSave});

  @override
  State<_QuickAddForm> createState() => _QuickAddFormState();
}

class _QuickAddFormState extends State<_QuickAddForm> {
  final TextEditingController _titleController = TextEditingController();
  String _selectedModule = 'General';
  Priority _selectedPriority = Priority.medium;
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Task Title',
            hintText: 'e.g. Call CA for TDS query',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedModule,
                items: const ['General', 'Accounting', 'CRM', 'HR / Advisors', 'Business Tools', 'Store'].map((module) => DropdownMenuItem(value: module, child: Text(module))).toList(),
                onChanged: (value) => setState(() => _selectedModule = value!),
                decoration: const InputDecoration(labelText: 'Module', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<Priority>(
                value: _selectedPriority,
                items: const [
                  DropdownMenuItem(value: Priority.high, child: Text('High')),
                  DropdownMenuItem(value: Priority.medium, child: Text('Medium')),
                  DropdownMenuItem(value: Priority.low, child: Text('Low')),
                ],
                onChanged: (value) => setState(() => _selectedPriority = value!),
                decoration: const InputDecoration(labelText: 'Priority', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty) {
              widget.onSave(_titleController.text, _selectedModule, _selectedPriority, _selectedDate);
              _titleController.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0E5E83),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 44),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Add Task', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _FocusItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FocusItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
            child: Icon(icon, size: 14, color: const Color(0xFF0E5E83)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(Icons.task_alt, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No tasks found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 8),
          const Text('Try adjusting your filters or create a new task', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5E83),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Create New Task'),
          ),
        ],
      ),
    );
  }
}

class _NewTaskDialog extends StatelessWidget {
  final Function(String, String, String, Priority, DateTime) onSave;

  const _NewTaskDialog({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 500,
        child: const Column(mainAxisSize: MainAxisSize.min, children: [Text('New Task Dialog - Implementation similar to Quick Add Form')]),
      ),
    );
  }
}
