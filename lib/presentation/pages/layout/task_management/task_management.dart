import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class TaskManagementPage extends StatefulWidget {
  const TaskManagementPage({super.key});

  @override
  State<TaskManagementPage> createState() => _TaskManagementPageState();
}

class _TaskManagementPageState extends State<TaskManagementPage> {
  int _currentIndex = 0;
  final List<Task> _tasks = [
    Task(
      id: 'TSK-2025-001',
      title: 'GST Return – Oct 2025',
      assignee: 'Ankita Joshi',
      organization: 'ABC Traders (MSME)',
      status: TaskStatus.inProgress,
      dueDate: '05 Nov 2025',
      priority: Priority.high,
    ),
    Task(
      id: 'TSK-2025-002',
      title: 'Prepare Salary Sheet – Oct',
      assignee: 'Vikram Patil',
      organization: 'Saving Mantra (Corporate)',
      status: TaskStatus.open,
      dueDate: '03 Nov 2025',
      priority: Priority.medium,
    ),
    Task(
      id: 'TSK-2025-003',
      title: 'Onboarding – New CA Partner',
      assignee: 'Neha Shah',
      organization: 'CA Firm (Professional)',
      status: TaskStatus.open,
      dueDate: '01 Nov 2025',
      priority: Priority.high,
    ),
    Task(
      id: 'TSK-2025-004',
      title: 'Review Network Agreements',
      assignee: 'Rohan More',
      organization: 'NRI Clients – UAE',
      status: TaskStatus.overdue,
      dueDate: '27 Oct 2025',
      priority: Priority.critical,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      appBar: CustomAppBar(
        title: 'Task Management',
        subtitle: 'Project and task management',
        leadingIcon: Icons.task_outlined,
        customActions: [
          AppBarActionButton(label: 'Filter Tasks', icon: Icons.filter_list, onPressed: () {}),
          const SizedBox(width: 8),
          AppBarActionButton(label: 'New Task', icon: Icons.add, onPressed: () {}, isPrimary: true),
        ],
      ),
      body: Column(
        children: [
          _buildStatsRow(),
          Expanded(
            child: Row(
              children: [
                _buildSidebar(),
                const VerticalDivider(width: 1, color: Color(0xffe5e7eb)),
                Expanded(child: _buildMainContent()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF0E5E83),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStatCard('Total Tasks', '42', Icons.task, const Color(0xFF0E5E83)),
          const SizedBox(width: 12),
          _buildStatCard('Pending', '18', Icons.pending_actions, const Color(0xFFF59E0B)),
          const SizedBox(width: 12),
          _buildStatCard('Completed', '24', Icons.check_circle, const Color(0xFF10B981)),
          const SizedBox(width: 12),
          _buildStatCard('Overdue', '7', Icons.warning, const Color(0xFFEF4444)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: Colors.white,
      child: SingleChildScrollView(child: Column(children: [_buildQuickActions(), _buildTaskFilters()])),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          const SizedBox(height: 12),
          _buildActionButton('Create New Task', Icons.add),
          const SizedBox(height: 8),
          _buildActionButton('Import Tasks', Icons.upload),
          const SizedBox(height: 8),
          _buildActionButton('Export Report', Icons.download),
          const SizedBox(height: 8),
          _buildActionButton('Team Overview', Icons.people),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), alignment: Alignment.centerLeft),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF0E5E83)),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800]),
          ),
          const SizedBox(height: 16),
          _buildFilterSection('Status', ['All Tasks', 'Open', 'In Progress', 'Completed', 'Overdue']),
          const SizedBox(height: 16),
          _buildFilterSection('Priority', ['All Priorities', 'Critical', 'High', 'Medium', 'Low']),
          const SizedBox(height: 16),
          _buildFilterSection('Assignee', ['All Assignees', 'Ankita Joshi', 'Vikram Patil', 'Neha Shah']),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        ...options.map(
          (option) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(option, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildTabs(),
        Expanded(child: _buildTaskList()),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          _buildTab('All Tasks', 0),
          const SizedBox(width: 16),
          _buildTab('My Tasks', 1),
          const SizedBox(width: 16),
          _buildTab('Team Tasks', 2),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Text('Search tasks...', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text('Sort by: Due Date', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey[500]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E5E83) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF0E5E83) : Colors.grey[300]!),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: isSelected ? Colors.white : Colors.grey[700], fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return _buildTaskCard(task);
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(color: _getPriorityColor(task.priority), borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      task.id,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    _buildStatusBadge(task.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(task.assignee, Icons.person),
                    const SizedBox(width: 8),
                    _buildInfoChip(task.organization, Icons.business),
                    const SizedBox(width: 8),
                    _buildInfoChip(task.dueDate, Icons.calendar_today),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, size: 18, color: Colors.grey[600]),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, size: 18, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(TaskStatus status) {
    final statusConfig = _getStatusConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: statusConfig.color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(
        statusConfig.text,
        style: TextStyle(fontSize: 11, color: statusConfig.color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[500]),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Task'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: ['High', 'Medium', 'Low'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0E5E83)),
            child: const Text('Create Task'),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.critical:
        return const Color(0xFFDC2626);
      case Priority.high:
        return const Color(0xFFEA580C);
      case Priority.medium:
        return const Color(0xFFCA8A04);
      case Priority.low:
        return const Color(0xFF16A34A);
    }
  }

  _StatusConfig _getStatusConfig(TaskStatus status) {
    switch (status) {
      case TaskStatus.open:
        return _StatusConfig('Open', const Color(0xFF0E5E83));
      case TaskStatus.inProgress:
        return _StatusConfig('In Progress', const Color(0xFFF59E0B));
      case TaskStatus.completed:
        return _StatusConfig('Completed', const Color(0xFF10B981));
      case TaskStatus.overdue:
        return _StatusConfig('Overdue', const Color(0xFFEF4444));
    }
  }
}

class _StatusConfig {
  final String text;
  final Color color;

  _StatusConfig(this.text, this.color);
}

enum TaskStatus { open, inProgress, completed, overdue }

enum Priority { critical, high, medium, low }

class Task {
  final String id;
  final String title;
  final String assignee;
  final String organization;
  final TaskStatus status;
  final String dueDate;
  final Priority priority;

  Task({required this.id, required this.title, required this.assignee, required this.organization, required this.status, required this.dueDate, required this.priority});
}
