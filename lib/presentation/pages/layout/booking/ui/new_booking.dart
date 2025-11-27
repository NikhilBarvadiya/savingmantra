import 'package:flutter/material.dart';

class NewBookingPage extends StatefulWidget {
  const NewBookingPage({super.key});

  @override
  State<NewBookingPage> createState() => _NewBookingPageState();
}

class _NewBookingPageState extends State<NewBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedService = 'Business Consultation';
  String _selectedDuration = '60 mins';
  String _selectedChannel = 'Online';
  String _selectedPriority = 'Medium';

  final List<String> _services = ['Business Consultation', 'Strategy Session', 'Product Demo', 'Onboarding Call', 'Follow-up Meeting', 'Training Session', 'Support Call', 'Technical Review'];
  final List<String> _durations = ['30 mins', '45 mins', '60 mins', '90 mins', '120 mins'];
  final List<String> _channels = ['Online', 'Offline', 'Phone'];
  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0E5E83), onPrimary: Colors.white),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0E5E83), onPrimary: Colors.white),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => _BookingSuccessDialog(
          onConfirm: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF7F8FB);
    const brand = Color(0xFF0E5E83);
    const accent = Color(0xFFE67E22);
    const border = Color(0xFFE2E8F0);
    const muted = Color(0xFF6B7280);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Booking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
            ),
            Text('Create a new appointment', style: TextStyle(fontSize: 12, color: muted)),
          ],
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: muted)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BookingProgressIndicator(currentStep: 1),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        _FormSection(
                          title: 'Client Information',
                          icon: Icons.person_outline_rounded,
                          children: [
                            _FormRow(
                              label: 'Full Name *',
                              child: TextFormField(
                                controller: _clientNameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter client full name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: border),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: brand),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  prefixIcon: Icon(Icons.person, size: 20, color: muted),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter client name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _FormRow(
                                    label: 'Email Address',
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: 'client@example.com',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        prefixIcon: Icon(Icons.email_outlined, size: 20, color: muted),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _FormRow(
                                    label: 'Phone Number *',
                                    child: TextFormField(
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        hintText: '+91 98765 43210',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        prefixIcon: Icon(Icons.phone_outlined, size: 20, color: muted),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _FormRow(
                              label: 'Company / Organization',
                              child: TextFormField(
                                controller: _companyController,
                                decoration: InputDecoration(
                                  hintText: 'Enter company name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: border),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: brand),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  prefixIcon: Icon(Icons.business_outlined, size: 20, color: muted),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _FormSection(
                          title: 'Booking Details',
                          icon: Icons.calendar_today_outlined,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _FormRow(
                                    label: 'Date *',
                                    child: InkWell(
                                      onTap: () => _selectDate(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: border),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 20, color: muted),
                                            const SizedBox(width: 12),
                                            Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}', style: const TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _FormRow(
                                    label: 'Time *',
                                    child: InkWell(
                                      onTap: () => _selectTime(context),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: border),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.access_time, size: 20, color: muted),
                                            const SizedBox(width: 12),
                                            Text(_selectedTime.format(context), style: const TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _FormRow(
                                    label: 'Service Type *',
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedService,
                                      items: _services.map((service) => DropdownMenuItem(value: service, child: Text(service))).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedService = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, color: muted),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _FormRow(
                                    label: 'Duration *',
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedDuration,
                                      items: _durations.map((duration) => DropdownMenuItem(value: duration, child: Text(duration))).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedDuration = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, color: muted),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _FormRow(
                                    label: 'Channel *',
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedChannel,
                                      items: _channels.map((channel) => DropdownMenuItem(value: channel, child: Text(channel))).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedChannel = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, color: muted),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _FormRow(
                                    label: 'Priority',
                                    child: DropdownButtonFormField<String>(
                                      value: _selectedPriority,
                                      items: _priorities
                                          .map(
                                            (priority) => DropdownMenuItem(
                                              value: priority,
                                              child: _PriorityBadge(priority: priority),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPriority = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: border),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: brand),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, color: muted),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _FormSection(
                          title: 'Additional Information',
                          icon: Icons.note_add_outlined,
                          children: [
                            _FormRow(
                              label: 'Meeting Notes (Optional)',
                              child: TextFormField(
                                controller: _notesController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: 'Add any additional notes, agenda items, or special requirements for this meeting...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: border),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: brand),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: border),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: brand.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                                    child: Icon(Icons.history, size: 20, color: brand),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Booking Summary',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _SummaryItem(icon: Icons.person, label: 'Client', value: _clientNameController.text.isEmpty ? 'Not specified' : _clientNameController.text),
                              _SummaryItem(
                                icon: Icons.calendar_today,
                                label: 'Date & Time',
                                value: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} • ${_selectedTime.format(context)}',
                              ),
                              _SummaryItem(icon: Icons.work_outline, label: 'Service', value: _selectedService),
                              _SummaryItem(icon: Icons.schedule, label: 'Duration', value: _selectedDuration),
                              _SummaryItem(icon: Icons.videocam_outlined, label: 'Channel', value: _selectedChannel),
                              _SummaryItem(
                                icon: Icons.flag_outlined,
                                label: 'Priority',
                                value: _selectedPriority,
                                valueWidget: _PriorityBadge(priority: _selectedPriority),
                              ),
                              const Divider(height: 24),
                              const _SummaryItem(icon: Icons.attach_money, label: 'Total Amount', value: '₹ 2,500.00', isTotal: true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: _submitBooking,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle_outline, size: 18),
                                    SizedBox(width: 8),
                                    Text('Confirm & Create Booking', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: muted,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  side: const BorderSide(color: border),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Save as Draft'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F9FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFBAE6FD)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.help_outline, size: 18, color: brand),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Need Help?',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text('Our support team is available to help you with any questions about creating bookings.', style: TextStyle(fontSize: 12, color: muted)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(foregroundColor: brand, padding: EdgeInsets.zero),
                                    child: const Row(children: [Text('Contact Support'), SizedBox(width: 4), Icon(Icons.arrow_forward, size: 14)]),
                                  ),
                                  const SizedBox(width: 16),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(foregroundColor: brand, padding: EdgeInsets.zero),
                                    child: const Row(children: [Text('View Guide'), SizedBox(width: 4), Icon(Icons.arrow_forward, size: 14)]),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _BookingProgressIndicator extends StatelessWidget {
  final int currentStep;

  const _BookingProgressIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          _ProgressStep(number: 1, label: 'Details', isActive: currentStep >= 1, isCompleted: currentStep > 1),
          _ProgressConnector(isActive: currentStep > 1),
          _ProgressStep(number: 2, label: 'Confirmation', isActive: currentStep >= 2, isCompleted: currentStep > 2),
          _ProgressConnector(isActive: currentStep > 2),
          _ProgressStep(number: 3, label: 'Payment', isActive: currentStep >= 3, isCompleted: currentStep > 3),
        ],
      ),
    );
  }
}

class _ProgressStep extends StatelessWidget {
  final int number;
  final String label;
  final bool isActive;
  final bool isCompleted;

  const _ProgressStep({required this.number, required this.label, required this.isActive, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    const brand = Color(0xFF0E5E83);
    const muted = Color(0xFF6B7280);

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted || isActive ? brand : Colors.transparent,
              border: Border.all(color: isCompleted || isActive ? brand : muted, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      number.toString(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isActive ? Colors.white : muted),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, color: isActive ? brand : muted),
          ),
        ],
      ),
    );
  }
}

class _ProgressConnector extends StatelessWidget {
  final bool isActive;

  const _ProgressConnector({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 8), color: isActive ? const Color(0xFF0E5E83) : const Color(0xFFE2E8F0)),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _FormSection({required this.title, required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 20, color: const Color(0xFF0E5E83)),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _FormRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;
  final bool isTotal;

  const _SummaryItem({required this.icon, required this.label, required this.value, this.valueWidget, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6B7280)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF6B7280), fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal),
                ),
                const SizedBox(height: 2),
                valueWidget ??
                    Text(
                      value,
                      style: TextStyle(fontSize: 13, color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF0F172A), fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500),
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
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 4),
          Text(
            priority,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: fg),
          ),
        ],
      ),
    );
  }
}

class _BookingSuccessDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const _BookingSuccessDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(color: const Color(0xFFE6F4EA), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, size: 40, color: Color(0xFF15803D)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your booking has been successfully created. The client will receive a confirmation email with all the details.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5),
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
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    child: const Text('Add Another Booking'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5E83),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('View Booking'),
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
