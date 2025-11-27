import 'package:flutter/material.dart';
import 'package:savingmantra/presentation/widgets/common/custom_app_bar.dart';

class CreateManageNetworkPage extends StatefulWidget {
  const CreateManageNetworkPage({super.key});

  @override
  State<CreateManageNetworkPage> createState() => _CreateManageNetworkPageState();
}

class _CreateManageNetworkPageState extends State<CreateManageNetworkPage> {
  int _currentTab = 0;
  final TextEditingController _networkNameController = TextEditingController();
  final TextEditingController _networkDescriptionController = TextEditingController();
  String _selectedNetworkType = 'Distribution', _selectedPrivacy = 'Private';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        title: 'Create / Manage Network',
        subtitle: 'Build and manage your business network',
        leadingIcon: Icons.add_business_outlined,
        customActions: [AppBarActionButton(label: 'Create Network', icon: Icons.add, onPressed: () {}, isPrimary: true)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTabSelector(), const SizedBox(height: 24), _currentTab == 0 ? _buildCreateNetwork() : _buildManageNetworks(), const SizedBox(height: 40), _buildFooter()],
        ),
      ),
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
      child: Row(
        spacing: 10.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TabButton(text: "Create Network", isActive: _currentTab == 0, onTap: () => setState(() => _currentTab = 0)),
          _TabButton(text: "Manage Networks", isActive: _currentTab == 1, onTap: () => setState(() => _currentTab = 1)),
        ],
      ),
    );
  }

  Widget _buildCreateNetwork() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create New Network",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
            ),
            const SizedBox(height: 8),
            Text("Set up a new business network with your preferred structure and settings", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 32),
            _buildFormSection(
              title: "Basic Information",
              icon: Icons.info_rounded,
              children: [
                _buildFormField(label: "Network Name", hint: "Enter network name (e.g., SM Garments Channel)", controller: _networkNameController, icon: Icons.business_rounded),
                const SizedBox(height: 20),
                _buildFormField(label: "Description", hint: "Describe the purpose and scope of this network", controller: _networkDescriptionController, icon: Icons.description_rounded, maxLines: 3),
              ],
            ),
            const SizedBox(height: 32),
            _buildFormSection(
              title: "Network Configuration",
              icon: Icons.settings_rounded,
              children: [
                _buildDropdownField(
                  label: "Network Type",
                  value: _selectedNetworkType,
                  items: const ['Distribution', 'Franchise', 'Service', 'Retail', 'Manufacturing', 'Multi-level'],
                  onChanged: (value) => setState(() => _selectedNetworkType = value!),
                  icon: Icons.account_tree_rounded,
                ),
                const SizedBox(height: 20),
                _buildDropdownField(
                  label: "Privacy Settings",
                  value: _selectedPrivacy,
                  items: const ['Private', 'Public', 'Invite Only'],
                  onChanged: (value) => setState(() => _selectedPrivacy = value!),
                  icon: Icons.lock_rounded,
                ),
                const SizedBox(height: 20),
                _buildCheckboxField(label: "Enable member approvals", subtitle: "Require approval for new member requests", value: true, onChanged: (value) {}),
                const SizedBox(height: 10),
                _buildCheckboxField(label: "Allow member sales", subtitle: "Members can make sales within network", value: true, onChanged: (value) {}),
                const SizedBox(height: 10),
                _buildCheckboxField(label: "Enable commission tracking", subtitle: "Track commissions and payments automatically", value: true, onChanged: (value) {}),
              ],
            ),
            const SizedBox(height: 32),
            _buildFormSection(
              title: "Network Hierarchy",
              icon: Icons.account_tree_rounded,
              children: [
                Text("Define the structure of your network", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 16),
                _buildHierarchyLevel(level: "Level 1", title: "Manufacturer", description: "You (Network Owner)", isActive: true),
                _buildHierarchyLevel(level: "Level 2", title: "Distributor", description: "Regional distributors", isActive: true),
                _buildHierarchyLevel(level: "Level 3", title: "Retailer", description: "Local retailers and stores", isActive: true),
                _buildHierarchyLevel(level: "Level 4", title: "Customer", description: "End customers", isActive: false),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _networkNameController.clear();
                      _networkDescriptionController.clear();
                      setState(() {
                        _selectedNetworkType = 'Distribution';
                        _selectedPrivacy = 'Private';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Reset Form", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E5E83),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "Create Network",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManageNetworks() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _QuickActionCard(icon: Icons.group_add_rounded, title: "Invite Members", subtitle: "Add new members to your networks", color: Color(0xFF0E5E83), onTap: () {}),
                    const SizedBox(width: 16),
                    _QuickActionCard(icon: Icons.settings_rounded, title: "Network Settings", subtitle: "Configure network preferences", color: Color(0xFF10B981), onTap: () {}),
                    const SizedBox(width: 16),
                    _QuickActionCard(icon: Icons.analytics_rounded, title: "View Reports", subtitle: "Network performance analytics", color: Color(0xFFF59E0B), onTap: () {}),
                    const SizedBox(width: 16),
                    _QuickActionCard(icon: Icons.download_rounded, title: "Export Data", subtitle: "Export member and sales data", color: Color(0xFFEF4444), onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: const Color(0x0F000000), blurRadius: 20, offset: const Offset(0, 4))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Networks",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: const Color(0xFF111827)),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "3 Networks",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF0E5E83)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _NetworkManagementCard(name: "SM Garments Channel", type: "Distribution Network", members: 18, sales: "₹1,20,000", status: "Active", onEdit: () {}, onManage: () {}, onView: () {}),
                _NetworkManagementCard(name: "ElectroParts Dealer Net", type: "Dealer Network", members: 9, sales: "₹72,500", status: "Active", onEdit: () {}, onManage: () {}, onView: () {}),
                _NetworkManagementCard(name: "Service Franchise West", type: "Service Network", members: 6, sales: "₹38,200", status: "Active", onEdit: () {}, onManage: () {}, onView: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection({required String title, required IconData icon, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, size: 18, color: const Color(0xFF0E5E83)),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFormField({required String label, required String hint, required TextEditingController controller, required IconData icon, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: 1,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Icon(icon, color: Colors.grey[500]),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0E5E83)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({required String label, required String value, required List<String> items, required Function(String?) onChanged, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Icon(icon, color: Colors.grey[500]),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildCheckboxField({required String label, required String subtitle, required bool value, required Function(bool?) onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF0E5E83),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
              ),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHierarchyLevel({required String level, required String title, required String description, required bool isActive}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF0F9FF) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? const Color(0xFF0E5E83).withOpacity(0.2) : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: isActive ? const Color(0xFF0E5E83) : Colors.grey[400], borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                level.replaceAll('Level ', ''),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF0E5E83) : const Color(0xFF374151)),
                ),
                const SizedBox(height: 2),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
              child: Text(
                "Active",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF059669)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Text('© ${DateTime.now().year} Saving Mantra — Network Management', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.text, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive ? [BoxShadow(color: const Color(0x0F000000), blurRadius: 10, offset: const Offset(0, 2))] : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF0E5E83) : const Color(0xFF6B7280)),
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

class _NetworkManagementCard extends StatelessWidget {
  final String name;
  final String type;
  final int members;
  final String sales;
  final String status;
  final VoidCallback onEdit;
  final VoidCallback onManage;
  final VoidCallback onView;

  const _NetworkManagementCard({
    required this.name,
    required this.type,
    required this.members,
    required this.sales,
    required this.status,
    required this.onEdit,
    required this.onManage,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: const Color(0x0A000000), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: const Color(0xFF0E5E83).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.groups_rounded, color: Color(0xFF0E5E83), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Text(type, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _NetworkMetric(icon: Icons.people_rounded, value: '$members members'),
                    const SizedBox(width: 16),
                    _NetworkMetric(icon: Icons.attach_money_rounded, value: sales),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        status,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF059669)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              _NetworkActionButton(icon: Icons.edit_rounded, tooltip: 'Edit Network', onTap: onEdit),
              const SizedBox(width: 8),
              _NetworkActionButton(icon: Icons.manage_accounts_rounded, tooltip: 'Manage Members', onTap: onManage),
              const SizedBox(width: 8),
              _NetworkActionButton(icon: Icons.visibility_rounded, tooltip: 'View Details', onTap: onView),
            ],
          ),
        ],
      ),
    );
  }
}

class _NetworkMetric extends StatelessWidget {
  final IconData icon;
  final String value;

  const _NetworkMetric({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _NetworkActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _NetworkActionButton({required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: const Color(0xFF374151)),
        ),
      ),
    );
  }
}
