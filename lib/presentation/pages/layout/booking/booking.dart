import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/pages/layout/booking/ui/new_booking.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F8FB);
    const cardBg = Colors.white;
    const ink = Color(0xFF0F172A);
    const brand = Color(0xFF0E5E83);
    const accent = Color(0xFFE67E22);
    const border = Color(0xFFE2E8F0);
    const muted = Color(0xFF6B7280);
    const success = Color(0xFF10B981);
    const warning = Color(0xFFF59E0B);
    const danger = Color(0xFFEF4444);

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: cardBg,
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
                            'Client Dashboard',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: brand),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Booking', style: TextStyle(fontSize: 12, color: muted)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Booking Dashboard',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: ink),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: muted),
                          const SizedBox(width: 8),
                          Text('Today', style: TextStyle(fontSize: 13, color: muted)),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down, size: 16, color: muted),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBookingPage()));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add, size: 16),
                          SizedBox(width: 6),
                          Text('New Booking', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
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
                  Row(
                    children: [
                      Expanded(
                        child: _KpiCard(label: 'Bookings Today', value: '18', meta: '8 online · 10 offline', trend: '+12%', icon: Icons.trending_up, color: success),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _KpiCard(label: 'Pending Confirmations', value: '6', meta: 'Reminder SMS queued for 3', trend: '-2%', icon: Icons.trending_down, color: danger),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _KpiCard(label: 'No-Shows (30 Days)', value: '9', meta: 'Follow-up pending: 4', trend: '+5%', icon: Icons.trending_up, color: warning),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _KpiCard(label: 'Revenue', value: '₹24.5K', meta: 'This month', trend: '+18%', icon: Icons.trending_up, color: success),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _DashboardCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CardHeader(
                                title: "Today's Schedule",
                                subtitle: "November 7, 2025",
                                trailing: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(foregroundColor: brand, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                                  child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('View Calendar'), SizedBox(width: 4), Icon(Icons.arrow_forward, size: 14)]),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _ScheduleTable(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            _DashboardCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _CardHeader(title: 'Upcoming Slots', subtitle: 'Next 7 Days'),
                                  const SizedBox(height: 16),
                                  const _BulletList(items: ['24 slots available', '12 slots already booked', '3 group sessions scheduled', '8 waiting list requests']),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    height: 4,
                                    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(2)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 12,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: success,
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
                                            ),
                                          ),
                                        ),
                                        Expanded(flex: 24, child: Container(color: brand)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('50% booked', style: TextStyle(fontSize: 11, color: muted)),
                                      Text('12/24 slots', style: TextStyle(fontSize: 11, color: muted)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _DashboardCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _CardHeader(title: 'Quick Actions'),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _ActionButton(icon: Icons.block, label: 'Block Time', color: brand),
                                      _ActionButton(icon: Icons.share, label: 'Share Link', color: success),
                                      _ActionButton(icon: Icons.download, label: 'Export', color: warning),
                                      _ActionButton(icon: Icons.notifications, label: 'Reminders', color: danger),
                                      _ActionButton(icon: Icons.analytics, label: 'Reports', color: brand),
                                      _ActionButton(icon: Icons.settings, label: 'Setup', color: muted),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _DashboardCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeader(
                          title: 'Recent Bookings',
                          subtitle: 'Last 30 days',
                          trailing: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(foregroundColor: brand, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6)),
                            child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('View All'), SizedBox(width: 4), Icon(Icons.arrow_forward, size: 14)]),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _RecentBookingsTable(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('© ${DateTime.now().year} Saving Mantra — Booking Module v2.0', style: const TextStyle(fontSize: 11, color: muted)),
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
}

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final String meta;
  final String trend;
  final IconData icon;
  final Color color;

  const _KpiCard({required this.label, required this.value, required this.meta, required this.trend, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    const muted = Color(0xFF6B7280);
    const ink = Color(0xFF0F172A);

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
                child: Icon(icon, size: 16, color: color),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Icon(icon, size: 10, color: color),
                    const SizedBox(width: 2),
                    Text(
                      trend,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 12, color: muted)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: ink),
          ),
          const SizedBox(height: 4),
          Text(meta, style: const TextStyle(fontSize: 11, color: muted)),
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
  final Widget? trailing;

  const _CardHeader({required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF0F172A);
    const muted = Color(0xFF6B7280);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ink),
            ),
            if (subtitle != null) ...[const SizedBox(height: 2), Text(subtitle!, style: const TextStyle(fontSize: 12, color: muted))],
          ],
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionButton({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScheduleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TableWrapper(
      columns: const ['Time', 'Client', 'Service', 'Status', 'Actions'],
      rows: [
        _scheduleRow('10:00 AM', 'Rahul Patil', 'Business Consultation', const _StatusBadge(text: 'Confirmed', type: BadgeType.success)),
        _scheduleRow('12:30 PM', 'Anita Desai', 'Follow-up Call', const _StatusBadge(text: 'Pending', type: BadgeType.warning)),
        _scheduleRow('2:15 PM', 'Global Retail Inc.', 'Product Demo', const _StatusBadge(text: 'Confirmed', type: BadgeType.success)),
        _scheduleRow('4:00 PM', 'Tech Solutions Ltd.', 'Onboarding Session', const _StatusBadge(text: 'Waiting', type: BadgeType.info)),
      ],
    );
  }

  static List<Widget> _scheduleRow(String time, String client, String service, Widget status) => [
    _TableCell(
      child: Text(time, style: const TextStyle(fontWeight: FontWeight.w600)),
    ),
    _TableCell(child: Text(client)),
    _TableCell(child: Text(service)),
    _TableCell(child: status),
    _TableCell(
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.visibility, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.edit, size: 16), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        ],
      ),
    ),
  ];
}

class _RecentBookingsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _TableWrapper(
      columns: const ['Date & Time', 'Client', 'Service', 'Channel', 'Status', 'Amount', 'Actions'],
      rows: [
        [
          _TableCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('07 Nov 2025', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('10:00 AM', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          _TableCell(child: Text('Mahesh Industries')),
          _TableCell(child: Text('Onboarding Call')),
          _TableCell(child: _ChannelBadge(channel: 'Online')),
          const _TableCell(
            child: _StatusBadge(text: 'Completed', type: BadgeType.success),
          ),
          _TableCell(
            child: Text(
              '₹ 2,500',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green[700]),
            ),
          ),
          _TableCell(child: _ActionMenu()),
        ],
        [
          _TableCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('06 Nov 2025', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('2:30 PM', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          _TableCell(child: Text('Sunrise Traders')),
          _TableCell(child: Text('Product Demo')),
          _TableCell(child: _ChannelBadge(channel: 'Offline')),
          const _TableCell(
            child: _StatusBadge(text: 'No-Show', type: BadgeType.warning),
          ),
          _TableCell(
            child: Text(
              '₹ 0',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
          ),
          _TableCell(child: _ActionMenu()),
        ],
        [
          _TableCell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('05 Nov 2025', style: TextStyle(fontWeight: FontWeight.w600)),
                Text('11:00 AM', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              ],
            ),
          ),
          _TableCell(child: Text('Apex Consultants')),
          _TableCell(child: Text('Strategy Session')),
          _TableCell(child: _ChannelBadge(channel: 'Online')),
          const _TableCell(
            child: _StatusBadge(text: 'Completed', type: BadgeType.success),
          ),
          _TableCell(
            child: Text(
              '₹ 5,000',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green[700]),
            ),
          ),
          _TableCell(child: _ActionMenu()),
        ],
      ],
    );
  }
}

class _TableWrapper extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;

  const _TableWrapper({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.2),
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 0,
          headingRowHeight: 44,
          dataRowMinHeight: 52,
          dataRowMaxHeight: 52,
          showCheckboxColumn: false,
          headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF6B7280), letterSpacing: 0.5),
          dataTextStyle: const TextStyle(fontSize: 12),
          columns: columns.map((c) => DataColumn(label: Text(c.toUpperCase()))).toList(),
          rows: rows.map((cells) => DataRow(cells: cells.map((w) => DataCell(w)).toList())).toList(),
        ),
      ),
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
            channel,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}

class _ActionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert, size: 16),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'view', child: Text('View Details')),
        const PopupMenuItem(value: 'edit', child: Text('Edit Booking')),
        const PopupMenuItem(value: 'reschedule', child: Text('Reschedule')),
        const PopupMenuItem(value: 'cancel', child: Text('Cancel')),
      ],
      onSelected: (value) {},
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final BadgeType type;

  const _StatusBadge({required this.text, required this.type});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (type) {
      case BadgeType.success:
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF15803D);
        icon = Icons.check_circle;
        break;
      case BadgeType.warning:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        icon = Icons.warning;
        break;
      case BadgeType.danger:
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFB91C1C);
        icon = Icons.error;
        break;
      case BadgeType.info:
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        icon = Icons.info;
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

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    const muted = Color(0xFF6B7280);
    const brand = Color(0xFF0E5E83);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((t) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4, right: 8),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(color: brand, shape: BoxShape.circle),
              ),
              Expanded(
                child: Text(t, style: const TextStyle(fontSize: 12, color: muted)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

enum BadgeType { success, warning, danger, info }
