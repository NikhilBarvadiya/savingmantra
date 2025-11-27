import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class ManageBookingsPage extends StatefulWidget {
  const ManageBookingsPage({super.key});

  @override
  State<ManageBookingsPage> createState() => _ManageBookingsPageState();
}

class _ManageBookingsPageState extends State<ManageBookingsPage> {
  String _selectedFilter = 'all';
  String _selectedStatus = 'all';
  String _selectedDateRange = 'today';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _bookings = [
    {
      'id': 'BK-001',
      'clientName': 'Rahul Patil',
      'service': 'Business Consultation',
      'date': '2025-11-07',
      'time': '10:00 AM',
      'status': 'confirmed',
      'channel': 'online',
      'duration': '60 mins',
      'amount': 2500,
      'priority': 'high',
      'notes': 'Discussion about new business strategy',
    },
    {
      'id': 'BK-002',
      'clientName': 'Anita Desai',
      'service': 'Follow-up Call',
      'date': '2025-11-07',
      'time': '12:30 PM',
      'status': 'pending',
      'channel': 'phone',
      'duration': '30 mins',
      'amount': 1500,
      'priority': 'medium',
      'notes': 'Follow up on previous consultation',
    },
    {
      'id': 'BK-003',
      'clientName': 'Global Retail Inc.',
      'service': 'Product Demo',
      'date': '2025-11-07',
      'time': '2:15 PM',
      'status': 'confirmed',
      'channel': 'offline',
      'duration': '90 mins',
      'amount': 5000,
      'priority': 'urgent',
      'notes': 'Product demonstration for enterprise client',
    },
    {
      'id': 'BK-004',
      'clientName': 'Tech Solutions Ltd.',
      'service': 'Onboarding Session',
      'date': '2025-11-07',
      'time': '4:00 PM',
      'status': 'waiting',
      'channel': 'online',
      'duration': '120 mins',
      'amount': 7500,
      'priority': 'high',
      'notes': 'Complete onboarding process',
    },
    {
      'id': 'BK-005',
      'clientName': 'Mahesh Industries',
      'service': 'Strategy Session',
      'date': '2025-11-06',
      'time': '11:00 AM',
      'status': 'completed',
      'channel': 'online',
      'duration': '60 mins',
      'amount': 3000,
      'priority': 'medium',
      'notes': 'Quarterly strategy planning',
    },
    {
      'id': 'BK-006',
      'clientName': 'Sunrise Traders',
      'service': 'Product Demo',
      'date': '2025-11-06',
      'time': '2:30 PM',
      'status': 'cancelled',
      'channel': 'offline',
      'duration': '90 mins',
      'amount': 0,
      'priority': 'low',
      'notes': 'Client cancelled last minute',
    },
  ];

  List<Map<String, dynamic>> get _filteredBookings {
    return _bookings.where((booking) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          booking['clientName'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          booking['service'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          booking['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus = _selectedStatus == 'all' || booking['status'] == _selectedStatus;
      final matchesFilter =
          _selectedFilter == 'all' ||
          (_selectedFilter == 'today' && booking['date'] == '2025-11-07') ||
          (_selectedFilter == 'upcoming' && ['confirmed', 'pending', 'waiting'].contains(booking['status'])) ||
          (_selectedFilter == 'past' && ['completed', 'cancelled'].contains(booking['status']));

      return matchesSearch && matchesStatus && matchesFilter;
    }).toList();
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => _BookingDetailsDialog(booking: booking),
    );
  }

  void _editBooking(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Editing booking ${booking['id']}'), backgroundColor: const Color(0xFF0E5E83)));
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => _CancelBookingDialog(
        booking: booking,
        onConfirm: () {
          setState(() {
            booking['status'] = 'cancelled';
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking ${booking['id']} cancelled'), backgroundColor: const Color(0xFFEF4444)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F8FB);
    const brand = Color(0xFF0E5E83);
    const border = Color(0xFFE2E8F0);
    const muted = Color(0xFF6B7280);
    const success = Color(0xFF10B981);
    const warning = Color(0xFFF59E0B);
    const danger = Color(0xFFEF4444);

    return Scaffold(
      backgroundColor: bg,
      appBar: CustomAppBar(
        title: 'Manage Bookings',
        subtitle: 'Booking system administration',
        leadingIcon: Icons.event_available_outlined,
        customActions: [
          AppBarActionButton(label: 'Export', icon: Icons.download_outlined, onPressed: () {}),
          const SizedBox(width: 8),
          AppBarActionButton(label: 'Filter', icon: Icons.filter_list, onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
              boxShadow: [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: brand.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            'Booking Management',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: brand),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Manage All Bookings', style: TextStyle(fontSize: 12, color: muted)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Manage Bookings',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _FilterChip(label: 'All Bookings', isSelected: _selectedFilter == 'all', onTap: () => setState(() => _selectedFilter = 'all')),
                    const SizedBox(width: 8),
                    _FilterChip(label: "Today's", isSelected: _selectedFilter == 'today', onTap: () => setState(() => _selectedFilter = 'today')),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Upcoming', isSelected: _selectedFilter == 'upcoming', onTap: () => setState(() => _selectedFilter = 'upcoming')),
                    const SizedBox(width: 8),
                    _FilterChip(label: 'Past', isSelected: _selectedFilter == 'past', onTap: () => setState(() => _selectedFilter = 'past')),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DashboardCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) => setState(() => _searchQuery = value),
                                decoration: InputDecoration(
                                  hintText: 'Search by client name, service, or booking ID...',
                                  hintStyle: TextStyle(fontSize: 13, color: muted),
                                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[500], size: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey.shade300, width: .8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: border),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedStatus,
                                  items: [
                                    _dropdownItem('All Status', 'all'),
                                    _dropdownItem('Confirmed', 'confirmed'),
                                    _dropdownItem('Pending', 'pending'),
                                    _dropdownItem('Waiting', 'waiting'),
                                    _dropdownItem('Completed', 'completed'),
                                    _dropdownItem('Cancelled', 'cancelled'),
                                  ],
                                  onChanged: (value) => setState(() => _selectedStatus = value!),
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                  icon: Icon(Icons.arrow_drop_down, color: muted),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: border),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedDateRange,
                                  items: [_dropdownItem('Today', 'today'), _dropdownItem('This Week', 'week'), _dropdownItem('This Month', 'month'), _dropdownItem('Custom Range', 'custom')],
                                  onChanged: (value) => setState(() => _selectedDateRange = value!),
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                  icon: Icon(Icons.arrow_drop_down, color: muted),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brand,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.download_outlined, size: 16),
                                  SizedBox(width: 6),
                                  Text('Export', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _SummaryChip(icon: Icons.event_available, label: 'Total Bookings', value: _bookings.length.toString(), color: brand),
                            const SizedBox(width: 12),
                            _SummaryChip(icon: Icons.check_circle, label: 'Confirmed', value: _bookings.where((b) => b['status'] == 'confirmed').length.toString(), color: success),
                            const SizedBox(width: 12),
                            _SummaryChip(icon: Icons.pending, label: 'Pending', value: _bookings.where((b) => b['status'] == 'pending').length.toString(), color: warning),
                            const SizedBox(width: 12),
                            _SummaryChip(icon: Icons.cancel, label: 'Cancelled', value: _bookings.where((b) => b['status'] == 'cancelled').length.toString(), color: danger),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _DashboardCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeader(title: 'Bookings Overview', subtitle: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                        const SizedBox(height: 20),
                        _BookingsTable(bookings: _filteredBookings, onViewDetails: _showBookingDetails, onEdit: _editBooking, onCancel: _cancelBooking),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('© ${DateTime.now().year} Saving Mantra — Booking Management v2.0', style: const TextStyle(fontSize: 11, color: muted)),
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
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> _dropdownItem(String text, String value) {
    return DropdownMenuItem(
      value: value,
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0E5E83) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF0E5E83) : const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF6B7280)),
        ),
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryChip({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
              ),
              Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            ],
          ),
        ],
      ),
    );
  }
}

class _BookingsTable extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;
  final Function(Map<String, dynamic>) onViewDetails;
  final Function(Map<String, dynamic>) onEdit;
  final Function(Map<String, dynamic>) onCancel;

  const _BookingsTable({required this.bookings, required this.onViewDetails, required this.onEdit, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const _EmptyState();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.2),
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 0,
          headingRowHeight: 44,
          dataRowMinHeight: 60,
          dataRowMaxHeight: 60,
          showCheckboxColumn: false,
          headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
          dataTextStyle: const TextStyle(fontSize: 12),
          columns: const [
            DataColumn(label: Text('BOOKING ID')),
            DataColumn(label: Text('CLIENT')),
            DataColumn(label: Text('SERVICE')),
            DataColumn(label: Text('DATE & TIME')),
            DataColumn(label: Text('CHANNEL')),
            DataColumn(label: Text('STATUS')),
            DataColumn(label: Text('AMOUNT')),
            DataColumn(label: Text('ACTIONS')),
          ],
          rows: bookings.map((booking) => _bookingRow(booking)).toList(),
        ),
      ),
    );
  }

  DataRow _bookingRow(Map<String, dynamic> booking) {
    return DataRow(
      cells: [
        DataCell(
          _TableCell(
            child: Text(
              booking['id'],
              style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0E5E83)),
            ),
          ),
        ),
        DataCell(_TableCell(child: Text(booking['clientName']))),
        DataCell(_TableCell(child: Text(booking['service']))),
        DataCell(
          _TableCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking['date'], style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(booking['time'], style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
        ),
        DataCell(_TableCell(child: _ChannelBadge(channel: booking['channel']))),
        DataCell(_TableCell(child: _StatusBadge(status: booking['status']))),
        DataCell(
          _TableCell(
            child: Text(
              '₹ ${booking['amount']}',
              style: TextStyle(fontWeight: FontWeight.w600, color: booking['amount'] > 0 ? Colors.green[700] : Colors.grey[600]),
            ),
          ),
        ),
        DataCell(
          _TableCell(
            child: _ActionButtons(booking: booking, onViewDetails: () => onViewDetails(booking), onEdit: () => onEdit(booking), onCancel: () => onCancel(booking)),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const _ActionButtons({required this.booking, required this.onViewDetails, required this.onEdit, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.visibility_outlined, size: 16), onPressed: onViewDetails, tooltip: 'View Details', padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 16),
          onPressed: onEdit,
          tooltip: 'Edit Booking',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: const Color(0xFF0E5E83),
        ),
        const SizedBox(width: 8),
        if (booking['status'] != 'cancelled' && booking['status'] != 'completed')
          IconButton(
            icon: const Icon(Icons.cancel_outlined, size: 16),
            onPressed: onCancel,
            tooltip: 'Cancel Booking',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            color: const Color(0xFFEF4444),
          ),
      ],
    );
  }
}

class _BookingDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> booking;

  const _BookingDetailsDialog({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.event_available, size: 24, color: Color(0xFF0E5E83)),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Booking Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                ),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close, size: 20), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 24),
            _DetailRow(label: 'Booking ID', value: booking['id']),
            _DetailRow(label: 'Client Name', value: booking['clientName']),
            _DetailRow(label: 'Service', value: booking['service']),
            _DetailRow(label: 'Date & Time', value: '${booking['date']} at ${booking['time']}'),
            _DetailRow(label: 'Duration', value: booking['duration']),
            _DetailRow(label: 'Channel', value: booking['channel'].toString().toUpperCase()),
            _DetailRow(
              label: 'Status',
              valueWidget: _StatusBadge(status: booking['status']),
            ),
            _DetailRow(label: 'Amount', value: '₹ ${booking['amount']}'),
            _DetailRow(
              label: 'Priority',
              valueWidget: _PriorityBadge(priority: booking['priority']),
            ),
            const SizedBox(height: 16),
            const Text(
              'Notes:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),
            Text(booking['notes'], style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6B7280),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5E83),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Edit Booking'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelBookingDialog extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onConfirm;

  const _CancelBookingDialog({required this.booking, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: const Color(0xFFFEE2E2), shape: BoxShape.circle),
              child: const Icon(Icons.warning_amber_rounded, size: 32, color: Color(0xFFEF4444)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cancel Booking?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to cancel booking ${booking['id']} for ${booking['clientName']}?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6B7280),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Keep Booking'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Cancel Booking'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? valueWidget;

  const _DetailRow({required this.label, this.value, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: valueWidget ?? Text(value ?? '', style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A))),
          ),
        ],
      ),
    );
  }
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
    const ink = Color(0xFF0F172A);
    const muted = Color(0xFF6B7280);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ink),
        ),
        if (subtitle != null) ...[const SizedBox(height: 2), Text(subtitle!, style: const TextStyle(fontSize: 12, color: muted))],
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  final Widget child;

  const _TableCell({required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _ChannelBadge extends StatelessWidget {
  final String channel;

  const _ChannelBadge({required this.channel});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (channel.toLowerCase()) {
      case 'online':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        icon = Icons.videocam;
        break;
      case 'offline':
        bg = const Color(0xFFF0FDF4);
        fg = const Color(0xFF166534);
        icon = Icons.business;
        break;
      case 'phone':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFF92400E);
        icon = Icons.phone;
        break;
      default:
        bg = const Color(0xFFF3F4F6);
        fg = const Color(0xFF374151);
        icon = Icons.help;
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
            channel.toUpperCase(),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;
    String text;

    switch (status.toLowerCase()) {
      case 'confirmed':
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF15803D);
        icon = Icons.check_circle;
        text = 'Confirmed';
        break;
      case 'pending':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        icon = Icons.pending;
        text = 'Pending';
        break;
      case 'waiting':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        icon = Icons.schedule;
        text = 'Waiting';
        break;
      case 'completed':
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF15803D);
        icon = Icons.done_all;
        text = 'Completed';
        break;
      case 'cancelled':
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        icon = Icons.cancel;
        text = 'Cancelled';
        break;
      default:
        bg = const Color(0xFFF3F4F6);
        fg = const Color(0xFF374151);
        icon = Icons.help;
        text = 'Unknown';
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

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (priority.toLowerCase()) {
      case 'urgent':
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        icon = Icons.error_outline;
        break;
      case 'high':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        icon = Icons.warning_amber_outlined;
        break;
      case 'medium':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        icon = Icons.info_outline;
        break;
      case 'low':
      default:
        bg = const Color(0xFFF3F4F6);
        fg = const Color(0xFF374151);
        icon = Icons.flag_outlined;
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
            priority.toUpperCase(),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
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
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          Icon(Icons.event_busy_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'No bookings found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
          ),
          const SizedBox(height: 8),
          const Text('Try adjusting your search or filter criteria', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0E5E83),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Create New Booking'),
          ),
        ],
      ),
    );
  }
}
