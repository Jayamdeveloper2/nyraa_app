// lib/pages/Profile/profile_page.dart
import 'package:flutter/material.dart';
import '../../data/profileData.dart';
import '../../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserData _user;
  bool _isEditingName = false;
  bool _isEditingPhone = false;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  Future<void> _loadUserData() async {
    final userData = await getUserData();
    setState(() {
      _user = userData;
      _nameController.text = userData.name;
      _phoneController.text = userData.phone;
      _isLoading = false;
    });
  }

  void _toggleEditName() {
    setState(() {
      if (_isEditingName) {
        _nameController.text = _user.name;
      }
      _isEditingName = !_isEditingName;
    });
  }

  void _toggleEditPhone() {
    setState(() {
      if (_isEditingPhone) {
        _phoneController.text = _user.phone;
      }
      _isEditingPhone = !_isEditingPhone;
    });
  }

  Future<void> _saveName() async {
    final newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      final updatedUser = UserData(
        email: _user.email,
        name: newName,
        phone: _user.phone,
        joinDate: _user.joinDate,
      );
      await updateUserData(updatedUser);
      setState(() {
        _user = updatedUser;
        _isEditingName = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully'),
          backgroundColor: const Color(0xFFBE6992),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  Future<void> _savePhone() async {
    final newPhone = _phoneController.text.trim();
    if (newPhone.isNotEmpty) {
      final updatedUser = UserData(
        email: _user.email,
        name: _user.name,
        phone: newPhone,
        joinDate: _user.joinDate,
      );
      await updateUserData(updatedUser);
      setState(() {
        _user = updatedUser;
        _isEditingPhone = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully'),
          backgroundColor: const Color(0xFFBE6992),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.logout,
                color: Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Log Out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to log out? You will need to sign in again to access your account.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout();
            },
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(
                color: Color(0xFFBE6992),
              ),
              SizedBox(height: 16),
              Text(
                'Logging out...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2));
    await clearUserData();

    if (mounted) {
      Navigator.pop(context); // Close loading dialog
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Logged out successfully'),
          backgroundColor: const Color(0xFFBE6992),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFBE6992)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE6992),
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
          ),
          onPressed: () {
            MainApp.navigatorKey.currentState?.setCurrentIndex(3); // Navigate to Orders page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfoSection(),
            const SizedBox(height: 16),
            _buildMenuSection(context),
            const SizedBox(height: 24),
            _buildLogoutButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFBE6992),
                      const Color(0xFFBE6992).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFBE6992).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFBE6992).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Premium Member',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFBE6992),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildContactInfo(Icons.email_outlined, _user.email, editable: false),
          const SizedBox(height: 8),
          _buildContactInfo(
            Icons.person_outline,
            _user.name,
            editable: true,
            isEditing: _isEditingName,
            controller: _nameController,
            onEdit: _toggleEditName,
            onSave: _saveName,
            onCancel: _toggleEditName,
          ),
          const SizedBox(height: 8),
          _buildContactInfo(
            Icons.phone_outlined,
            _user.phone,
            editable: true,
            isEditing: _isEditingPhone,
            controller: _phoneController,
            onEdit: _toggleEditPhone,
            onSave: _savePhone,
            onCancel: _toggleEditPhone,
          ),
          const SizedBox(height: 8),
          _buildContactInfo(Icons.calendar_today, _user.joinDate, editable: false),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
      IconData icon,
      String text, {
        bool editable = false,
        bool isEditing = false,
        TextEditingController? controller,
        VoidCallback? onEdit,
        VoidCallback? onSave,
        VoidCallback? onCancel,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: isEditing
              ? Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFBE6992)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onSave,
                child: const Icon(Icons.check, color: Color(0xFFBE6992), size: 20),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onCancel,
                child: const Icon(Icons.close, color: Colors.grey, size: 20),
              ),
            ],
          )
              : Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (editable && !isEditing) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onEdit,
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFFBE6992),
                    size: 16,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            context,
            icon: Icons.receipt_long_outlined,
            title: 'My Orders',
            subtitle: 'Track your orders',
            onTap: () {
              MainApp.navigatorKey.currentState?.setCurrentIndex(3);
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.favorite_border,
            title: 'My Wishlist',
            subtitle: 'View saved items',
            onTap: () {
              MainApp.navigatorKey.currentState?.setCurrentIndex(2);
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.location_on_outlined,
            title: 'Saved Addresses',
            subtitle: 'Manage delivery addresses',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Saved addresses feature coming soon!'),
                  backgroundColor: const Color(0xFFBE6992),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Notifications feature coming soon!'),
                  backgroundColor: const Color(0xFFBE6992),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Help & Support feature coming soon!'),
                  backgroundColor: const Color(0xFFBE6992),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Settings feature coming soon!'),
                  backgroundColor: const Color(0xFFBE6992),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFBE6992).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFBE6992),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _showLogoutDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.red.withOpacity(0.3), width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 12),
              const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}