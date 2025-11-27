import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class FollowUpPage extends StatefulWidget {
  const FollowUpPage({super.key});

  @override
  State<FollowUpPage> createState() => _FollowUpPageState();
}

class _FollowUpPageState extends State<FollowUpPage> {
  final List<Map<String, dynamic>> _followUps = [
    {
      'id': 'FU001',
      'leadName': 'Rajesh Kumar',
      'type': 'Call',
      'scheduledDate': '15 Nov 2025',
      'scheduledTime': '10:30 AM',
      'status': 'Pending',
      'priority': 'High',
      'notes': 'Discuss business loan proposal',
      'assignedTo': 'Amit Kumar',
      'reminder': '1 hour before',
    },
    {
      'id': 'FU002',
      'leadName': 'Priya Sharma',
      'type': 'Email',
      'scheduledDate': '14 Nov 2025',
      'scheduledTime': '2:00 PM',
      'status': 'Completed',
      'priority': 'Medium',
      'notes': 'Send product catalog and pricing',
      'assignedTo': 'You',
      'reminder': '30 minutes before',
    },
    {
      'id': 'FU003',
      'leadName': 'Amit Patel',
      'type': 'Meeting',
      'scheduledDate': '16 Nov 2025',
      'scheduledTime': '11:00 AM',
      'status': 'Scheduled',
      'priority': 'High',
      'notes': 'Product demonstration meeting',
      'assignedTo': 'You',
      'reminder': '2 hours before',
    },
    {
      'id': 'FU004',
      'leadName': 'Sneha Reddy',
      'type': 'Call',
      'scheduledDate': '13 Nov 2025',
      'scheduledTime': '4:30 PM',
      'status': 'Overdue',
      'priority': 'High',
      'notes': 'Follow up on contract signing',
      'assignedTo': 'Priya M.',
      'reminder': '1 hour before',
    },
    {
      'id': 'FU005',
      'leadName': 'Vikram Singh',
      'type': 'Email',
      'scheduledDate': '17 Nov 2025',
      'scheduledTime': '9:00 AM',
      'status': 'Scheduled',
      'priority': 'Low',
      'notes': 'Send follow-up questionnaire',
      'assignedTo': 'Amit Kumar',
      'reminder': '15 minutes before',
    },
  ];

  final List<Map<String, dynamic>> _pendingFollowUps = [
    {
      'id': 'FU003',
      'leadName': 'Amit Patel',
      'type': 'Meeting',
      'scheduledDate': '16 Nov 2025',
      'scheduledTime': '11:00 AM',
      'status': 'Pending',
      'priority': 'High',
      'notes': 'Product demonstration meeting',
    },
    {
      'id': 'FU004',
      'leadName': 'Sneha Reddy',
      'type': 'Call',
      'scheduledDate': '13 Nov 2025',
      'scheduledTime': '4:30 PM',
      'status': 'Pending',
      'priority': 'High',
      'notes': 'Follow up on contract signing',
    },
    {
      'id': 'FU008',
      'leadName': 'Rahul Verma',
      'type': 'Call',
      'scheduledDate': '18 Nov 2025',
      'scheduledTime': '3:00 PM',
      'status': 'Pending',
      'priority': 'Medium',
      'notes': 'Discuss pricing details',
    },
  ];

  final List<Map<String, dynamic>> _completedFollowUps = [
    {'id': 'FU002', 'leadName': 'Priya Sharma', 'type': 'Email', 'completedDate': '14 Nov 2025', 'status': 'Completed', 'result': 'Positive', 'notes': 'Sent product catalog and pricing'},
    {'id': 'FU006', 'leadName': 'Rahul Verma', 'type': 'Call', 'completedDate': '11 Nov 2025', 'status': 'Completed', 'result': 'Needs Follow-up', 'notes': 'Discussed pricing details'},
    {'id': 'FU007', 'leadName': 'Neha Gupta', 'type': 'Meeting', 'completedDate': '10 Nov 2025', 'status': 'Completed', 'result': 'Positive', 'notes': 'Product demo completed successfully'},
  ];

  final List<Map<String, dynamic>> _calendarEvents = [
    {
      'date': '15 Nov 2025',
      'events': [
        {'time': '10:30 AM', 'title': 'Call with Rajesh Kumar', 'type': 'Call'},
        {'time': '2:00 PM', 'title': 'Meeting with Tech Team', 'type': 'Meeting'},
        {'time': '4:00 PM', 'title': 'Follow-up Email', 'type': 'Email'},
      ],
    },
    {
      'date': '16 Nov 2025',
      'events': [
        {'time': '11:00 AM', 'title': 'Product Demo - Amit Patel', 'type': 'Meeting'},
        {'time': '3:30 PM', 'title': 'Follow-up Call', 'type': 'Call'},
      ],
    },
    {
      'date': '17 Nov 2025',
      'events': [
        {'time': '9:00 AM', 'title': 'Send Questionnaire - Vikram', 'type': 'Email'},
        {'time': '1:00 PM', 'title': 'Team Meeting', 'type': 'Meeting'},
      ],
    },
  ];

  final List<Map<String, dynamic>> _templates = [
    {'name': 'Initial Follow-up', 'type': 'Email', 'description': 'Standard first follow-up template', 'category': 'General'},
    {'name': 'Meeting Reminder', 'type': 'Email', 'description': 'Template for meeting reminders', 'category': 'Reminders'},
    {'name': 'Proposal Follow-up', 'type': 'Email', 'description': 'Follow-up after sending proposal', 'category': 'Sales'},
    {'name': 'Thank You Note', 'type': 'Email', 'description': 'Thank you note after meeting', 'category': 'General'},
    {'name': 'Welcome Message', 'type': 'SMS', 'description': 'Welcome message for new leads', 'category': 'Onboarding'},
  ];

  final List<Map<String, dynamic>> _automationRules = [
    {'name': 'New Lead Welcome', 'status': 'Active', 'description': 'Sends welcome email to new leads', 'trigger': 'New Lead Created', 'actions': 'Send Welcome Email'},
    {'name': 'Meeting Follow-up', 'status': 'Active', 'description': 'Follows up after meetings', 'trigger': 'Meeting Completed', 'actions': 'Send Thank You Email'},
    {'name': 'Inactive Lead', 'status': 'Inactive', 'description': 'Re-engages inactive leads', 'trigger': 'No Activity for 30 days', 'actions': 'Send Re-engagement Email'},
    {'name': 'Birthday Wishes', 'status': 'Active', 'description': 'Sends birthday greetings', 'trigger': 'Lead Birthday', 'actions': 'Send Birthday Email'},
  ];

  String _selectedFilter = 'All';
  String _selectedType = 'All';
  String _selectedPriority = 'All';
  String _selectedMenu = 'Follow-up Dashboard';

  Widget _buildCurrentView() {
    switch (_selectedMenu) {
      case 'Pending Follow-ups':
        return _buildPendingFollowUpsView();
      case 'Completed':
        return _buildCompletedFollowUpsView();
      case 'Calendar View':
        return _buildCalendarView();
      case 'Reminder Settings':
        return _buildReminderSettingsView();
      case 'Templates':
        return _buildTemplatesView();
      case 'Automation':
        return _buildAutomationView();
      case 'Follow-up Dashboard':
      default:
        return _buildDashboardView();
    }
  }

  Widget _buildDashboardView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Follow-up / Dashboard", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Follow-up Management", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Track and manage all your customer follow-ups in one place.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Bulk Actions", Icons.playlist_add_check, color: const Color(0xffE67E22)),
                const SizedBox(width: 10),
                _buildSmallButton("Schedule Follow-up", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildStatsCards(),
        const SizedBox(height: 25),
        _buildTodayFollowUps(),
        const SizedBox(height: 25),
        _buildFilterBar(),
        const SizedBox(height: 20),
        _buildFollowUpsTable(),
      ],
    );
  }

  Widget _buildPendingFollowUpsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Follow-up / Pending", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Pending Follow-ups", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Manage all your pending follow-up tasks.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Mark Complete", Icons.check_circle, color: const Color(0xff27AE60)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Pending Follow-ups",
          subtitle: "All follow-ups requiring your attention",
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              horizontalMargin: 0,
              headingRowHeight: 40,
              dataRowHeight: 60,
              columns: const [
                DataColumn(
                  label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Lead Name', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: _pendingFollowUps.map((followUp) {
                return DataRow(
                  cells: [
                    DataCell(Text(followUp['id'], style: const TextStyle(fontSize: 11))),
                    DataCell(Text(followUp['leadName'], style: const TextStyle(fontWeight: FontWeight.w500))),
                    DataCell(Row(children: [_buildTypeIcon(followUp['type'] as String), const SizedBox(width: 6), Text(followUp['type'])])),
                    DataCell(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(followUp['scheduledDate'], style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text(followUp['scheduledTime'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ),
                    DataCell(_buildPriorityBadge(followUp['priority'] as String)),
                    DataCell(Text(followUp['notes'], style: const TextStyle(fontSize: 11))),
                    DataCell(
                      Row(
                        children: [
                          _buildSmallButton("Complete", Icons.check, color: const Color(0xff27AE60)),
                          const SizedBox(width: 8),
                          _buildSmallButton("Reschedule", Icons.schedule, color: const Color(0xffE67E22)),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedFollowUpsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Follow-up / Completed", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Completed Follow-ups", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Review your completed follow-up activities.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Export", Icons.download, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Generate Report", Icons.analytics, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Completed Follow-ups",
          subtitle: "History of all completed follow-up activities",
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              horizontalMargin: 0,
              headingRowHeight: 40,
              dataRowHeight: 60,
              columns: const [
                DataColumn(
                  label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Lead Name', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Completed Date', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Result', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              rows: _completedFollowUps.map((followUp) {
                return DataRow(
                  cells: [
                    DataCell(Text(followUp['id'], style: const TextStyle(fontSize: 11))),
                    DataCell(Text(followUp['leadName'], style: const TextStyle(fontWeight: FontWeight.w500))),
                    DataCell(Row(children: [_buildTypeIcon(followUp['type'] as String), const SizedBox(width: 6), Text(followUp['type'])])),
                    DataCell(Text(followUp['completedDate'], style: const TextStyle(fontWeight: FontWeight.w500))),
                    DataCell(_buildResultBadge(followUp['result'] as String)),
                    DataCell(Text(followUp['notes'], style: const TextStyle(fontSize: 11))),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility, size: 16, color: Colors.blue),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.replay, size: 16, color: Colors.orange),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Follow-up / Calendar", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Calendar View", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("View your follow-ups in calendar format.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            Row(
              children: [
                _buildSmallButton("Today", Icons.today, border: true),
                const SizedBox(width: 10),
                _buildSmallButton("Add Event", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Follow-up Calendar",
          subtitle: "Your scheduled follow-ups by date",
          child: Column(
            children: _calendarEvents.map((day) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day['date'] as String,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff0E5E83)),
                    ),
                    const SizedBox(height: 8),
                    ...(day['events'] as List).map((event) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            _buildTypeIcon(event['type'] as String),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  Text(event['time'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                            _buildSmallButton("View", Icons.visibility, color: const Color(0xff0E5E83)),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderSettingsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Settings / Reminders", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Reminder Settings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Configure your follow-up reminder preferences.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("Save Settings", Icons.save, color: const Color(0xff0E5E83)),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildDashboardCard(
                title: "Notification Settings",
                subtitle: "Manage how and when you receive reminders",
                child: Column(
                  children: [
                    _buildSettingItem("Email Notifications", true),
                    _buildSettingItem("Push Notifications", true),
                    _buildSettingItem("SMS Alerts", false),
                    _buildSettingItem("Desktop Notifications", true),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildDashboardCard(
                title: "Reminder Timing",
                subtitle: "Set default reminder intervals",
                child: Column(
                  children: [
                    _buildReminderTimeItem("Before Follow-up", "1 hour"),
                    _buildReminderTimeItem("Overdue Alerts", "30 minutes"),
                    _buildReminderTimeItem("Daily Summary", "8:00 AM"),
                    _buildReminderTimeItem("Weekly Report", "Monday 9:00 AM"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplatesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Settings / Templates", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Follow-up Templates", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Manage your follow-up email and message templates.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("New Template", Icons.add, color: const Color(0xff0E5E83)),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Email Templates",
          subtitle: "Pre-designed templates for quick follow-ups",
          child: Column(
            children: [..._templates.map((template) => _buildTemplateItem(template['name'] as String, template['description'] as String, template['type'] as String, template['category'] as String))],
          ),
        ),
      ],
    );
  }

  Widget _buildAutomationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Settings / Automation", style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 6),
                Text("Automation Rules", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Set up automated follow-up workflows.", style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
            _buildSmallButton("New Rule", Icons.add, color: const Color(0xff0E5E83)),
          ],
        ),
        const SizedBox(height: 25),
        _buildDashboardCard(
          title: "Automation Rules",
          subtitle: "Automate your follow-up processes",
          child: Column(
            children: [
              ..._automationRules.map(
                (rule) => _buildAutomationRule(rule['name'] as String, rule['status'] as String, rule['description'] as String, rule['trigger'] as String, rule['actions'] as String),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, bool value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Switch(value: value, onChanged: (bool newValue) {}, activeColor: const Color(0xff0E5E83)),
        ],
      ),
    );
  }

  Widget _buildReminderTimeItem(String title, String time) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xfff7f8fb),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(time, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.edit, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String title, String description, String type, String category) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Icon(Icons.description, size: 20, color: const Color(0xff0E5E83)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(children: [_buildBadge(type, Colors.blue), const SizedBox(width: 8), _buildBadge(category, Colors.green)]),
              ],
            ),
          ),
          IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () {}),
          IconButton(icon: const Icon(Icons.content_copy, size: 18), onPressed: () {}),
          IconButton(icon: const Icon(Icons.visibility, size: 18), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildAutomationRule(String name, String status, String description, String trigger, String actions) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          const Icon(Icons.smart_toy, size: 20, color: Color(0xff0E5E83)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text("Trigger:", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    const SizedBox(width: 4),
                    Text(trigger, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 12),
                    const Text("Actions:", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    const SizedBox(width: 4),
                    Text(actions, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          _buildBadge(status, status == "Active" ? Colors.green : Colors.grey),
          const SizedBox(width: 12),
          IconButton(icon: const Icon(Icons.settings, size: 18), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildResultBadge(String result) {
    Color color;
    switch (result) {
      case 'Positive':
        color = Colors.green;
        break;
      case 'Needs Follow-up':
        color = Colors.orange;
        break;
      case 'Negative':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return _buildBadge(result, color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8fb),
      appBar: CustomAppBar(
        title: 'Follow-up',
        subtitle: 'Customer follow-up management',
        leadingIcon: Icons.update_outlined,
        customActions: [AppBarActionButton(label: 'Schedule Follow-up', icon: Icons.add, onPressed: () {}, isPrimary: true)],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildCurrentView(), const SizedBox(height: 30), _buildFooter()]),
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedMenu == "Follow-up Dashboard"
          ? FloatingActionButton(
              onPressed: _showAddFollowUpDialog,
              backgroundColor: const Color(0xff0E5E83),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tools & Services",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0E5E83)),
          ),
          const SizedBox(height: 25),
          const Text("FOLLOW-UP", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildMenuItem("Follow-up Dashboard", Icons.dashboard, active: _selectedMenu == "Follow-up Dashboard"),
          _buildMenuItem("Pending Follow-ups", Icons.pending_actions, active: _selectedMenu == "Pending Follow-ups"),
          _buildMenuItem("Completed", Icons.check_circle, active: _selectedMenu == "Completed"),
          _buildMenuItem("Calendar View", Icons.calendar_today, active: _selectedMenu == "Calendar View"),
          const SizedBox(height: 30),
          const Text("SETTINGS", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildMenuItem("Reminder Settings", Icons.notifications, active: _selectedMenu == "Reminder Settings"),
          _buildMenuItem("Templates", Icons.description, active: _selectedMenu == "Templates"),
          _buildMenuItem("Automation", Icons.smart_toy, active: _selectedMenu == "Automation"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String text, IconData icon, {bool active = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedMenu = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xff0E5E83).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: active ? Border.all(color: const Color(0xff0E5E83).withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: active ? const Color(0xff0E5E83) : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 13, color: active ? const Color(0xff0E5E83) : Colors.black87, fontWeight: active ? FontWeight.bold : FontWeight.normal),
              ),
            ),
            if (active) const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xff0E5E83)),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallButton(String text, IconData icon, {Color color = Colors.white, bool border = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: border ? Border.all(color: Colors.black26) : null,
        boxShadow: [if (!border) BoxShadow(color: color.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: border ? Colors.black87 : Colors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: border ? Colors.black87 : Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        _buildStatCard(title: "Pending Follow-ups", value: "24", change: "+5", isPositive: false, color: Color(0xffE67E22), icon: Icons.pending_actions),
        const SizedBox(width: 16),
        _buildStatCard(title: "Completed Today", value: "12", change: "+3", isPositive: true, color: Color(0xff27AE60), icon: Icons.check_circle),
        const SizedBox(width: 16),
        _buildStatCard(title: "Overdue", value: "8", change: "-2", isPositive: true, color: Color(0xffE74C3C), icon: Icons.warning),
        const SizedBox(width: 16),
        _buildStatCard(title: "Scheduled", value: "45", change: "+8", isPositive: true, color: Color(0xff0E5E83), icon: Icons.schedule),
      ],
    );
  }

  Widget _buildStatCard({required String title, required String value, required String change, required bool isPositive, required Color color, required IconData icon}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, size: 16, color: color),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, size: 10, color: isPositive ? Colors.green : Colors.red),
                      const SizedBox(width: 2),
                      Text(
                        change,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isPositive ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayFollowUps() {
    final todayFollowUps = [
      {'id': 'FU006', 'leadName': 'Rahul Verma', 'type': 'Call', 'scheduledTime': '11:30 AM', 'status': 'Upcoming', 'priority': 'High'},
      {'id': 'FU007', 'leadName': 'Neha Gupta', 'type': 'Meeting', 'scheduledTime': '3:00 PM', 'status': 'Upcoming', 'priority': 'Medium'},
    ];

    return _buildDashboardCard(
      title: "Today's Follow-ups",
      subtitle: "Your schedule for today",
      child: Column(
        children: [
          ...todayFollowUps.map((followUp) {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  _buildTypeIcon(followUp['type'] as String),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(followUp['leadName'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('${followUp['type']} • ${followUp['scheduledTime']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  _buildPriorityBadge(followUp['priority'] as String),
                  const SizedBox(width: 12),
                  _buildSmallButton("Start", Icons.play_arrow, color: const Color(0xff27AE60)),
                ],
              ),
            );
          }),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xff0E5E83).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xff0E5E83).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.add, size: 20, color: Color(0xff0E5E83)),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Add new follow-up for today",
                    style: TextStyle(fontSize: 14, color: Color(0xff0E5E83), fontWeight: FontWeight.w500),
                  ),
                ),
                _buildSmallButton("Add", Icons.add, color: const Color(0xff0E5E83)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          _buildFilterDropdown(
            value: _selectedFilter,
            items: ['All', 'Pending', 'Completed', 'Overdue', 'Scheduled'],
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
            label: 'Status',
          ),
          const SizedBox(width: 16),
          _buildFilterDropdown(
            value: _selectedType,
            items: ['All', 'Call', 'Email', 'Meeting', 'Message'],
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
            label: 'Type',
          ),
          const SizedBox(width: 16),
          _buildFilterDropdown(
            value: _selectedPriority,
            items: ['All', 'High', 'Medium', 'Low'],
            onChanged: (value) {
              setState(() {
                _selectedPriority = value!;
              });
            },
            label: 'Priority',
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search follow-ups...',
                prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: .8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFollowUpsTable() {
    return _buildDashboardCard(
      title: "All Follow-ups",
      subtitle: "Complete list of all scheduled follow-ups",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5),
          child: DataTable(
            columnSpacing: 20,
            horizontalMargin: 0,
            headingRowHeight: 40,
            dataRowHeight: 60,
            columns: const [
              DataColumn(
                label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Lead Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              DataColumn(
                label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
            rows: _followUps.map((followUp) {
              return DataRow(
                cells: [
                  DataCell(Text(followUp['id'], style: const TextStyle(fontSize: 11))),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(followUp['leadName'], style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 2),
                        Text(
                          followUp['notes'],
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  DataCell(Row(children: [_buildTypeIcon(followUp['type'] as String), const SizedBox(width: 6), Text(followUp['type'])])),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(followUp['scheduledDate'], style: const TextStyle(fontWeight: FontWeight.w500)),
                        Text(followUp['scheduledTime'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  DataCell(_buildStatusBadge(followUp['status'] as String)),
                  DataCell(_buildPriorityBadge(followUp['priority'] as String)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: followUp['assignedTo'] == 'You' ? const Color(0xff0E5E83).withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        followUp['assignedTo'],
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: followUp['assignedTo'] == 'You' ? const Color(0xff0E5E83) : Colors.grey),
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_arrow, size: 16, color: Colors.green),
                          onPressed: () => _startFollowUp(followUp),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 16, color: Colors.blue),
                          onPressed: () => _editFollowUp(followUp),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                          onPressed: () => _deleteFollowUp(followUp),
                        ),
                      ],
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

  Widget _buildDashboardCard({required String title, required String subtitle, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTypeIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'Call':
        icon = Icons.phone;
        color = Colors.green;
        break;
      case 'Email':
        icon = Icons.email;
        color = Colors.blue;
        break;
      case 'Meeting':
        icon = Icons.video_call;
        color = Colors.purple;
        break;
      case 'Message':
        icon = Icons.message;
        color = Colors.orange;
        break;
      default:
        icon = Icons.task;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, size: 16, color: color),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Completed':
        color = Colors.green;
        break;
      case 'Overdue':
        color = Colors.red;
        break;
      case 'Scheduled':
        color = Colors.blue;
        break;
      case 'Upcoming':
        color = Colors.purple;
        break;
      default:
        color = Colors.grey;
    }

    return _buildBadge(status, color);
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'Low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return _buildBadge(priority, color);
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget _buildFilterDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged, required String label}) {
    return Container(
      width: 140,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fb),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 16),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Text("© 2025 Saving Mantra — Follow-up Management System.", style: TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  void _showAddFollowUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Schedule New Follow-up"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: const InputDecoration(labelText: "Lead Name")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Type")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Schedule Date")),
              const SizedBox(height: 12),
              TextField(decoration: const InputDecoration(labelText: "Notes")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Schedule")),
        ],
      ),
    );
  }

  void _startFollowUp(Map<String, dynamic> followUp) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Starting follow-up with ${followUp['leadName']}")));
  }

  void _editFollowUp(Map<String, dynamic> followUp) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Editing follow-up ${followUp['id']}")));
  }

  void _deleteFollowUp(Map<String, dynamic> followUp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Follow-up"),
        content: Text("Are you sure you want to delete follow-up ${followUp['id']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              setState(() {
                _followUps.remove(followUp);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted follow-up ${followUp['id']}")));
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
