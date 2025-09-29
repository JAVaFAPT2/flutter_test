import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';

/// Settings page for app preferences and configuration
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;
  String _language = 'vi'; // vi, en
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (_isLoading)
            Container(
              padding: const EdgeInsets.all(16),
              child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Settings Section
            _buildSectionHeader('Tài khoản'),
            _buildAccountSettings(),

            const SizedBox(height: 24),

            // App Settings Section
            _buildSectionHeader('Ứng dụng'),
            _buildAppSettings(),

            const SizedBox(height: 24),

            // Privacy & Security Section
            _buildSectionHeader('Bảo mật & Quyền riêng tư'),
            _buildPrivacySettings(),

            const SizedBox(height: 24),

            // Support Section
            _buildSectionHeader('Hỗ trợ'),
            _buildSupportSettings(),

            const SizedBox(height: 24),

            // About Section
            _buildSectionHeader('Thông tin'),
            _buildAboutSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.person,
            title: 'Thông tin cá nhân',
            subtitle: 'Quản lý thông tin tài khoản',
            onTap: () => Navigator.of(context).pushNamed('/profile'),
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.notifications,
            title: 'Thông báo',
            subtitle: 'Quản lý thông báo ứng dụng',
            onTap: () {
              _showSnackBar('Chức năng đang được phát triển');
            },
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
                _showSnackBar('Cài đặt thông báo đã được cập nhật');
              },
            ),
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.fingerprint,
            title: 'Xác thực sinh trắc học',
            subtitle: 'Đăng nhập bằng vân tay/khuôn mặt',
            onTap: () {
              _showSnackBar('Chức năng đang được phát triển');
            },
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: (value) {
                setState(() {
                  _biometricEnabled = value;
                });
                _showSnackBar(
                    'Cài đặt xác thực sinh trắc học đã được cập nhật');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.language,
            title: 'Ngôn ngữ',
            subtitle: _getLanguageText(_language),
            onTap: _showLanguageDialog,
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.dark_mode,
            title: 'Chế độ tối',
            subtitle: 'Giao diện tối cho ban đêm',
            onTap: () {
              _showSnackBar('Chức năng đang được phát triển');
            },
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
                _showSnackBar(
                    'Chế độ tối đã được ${_darkModeEnabled ? 'bật' : 'tắt'}');
              },
            ),
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.data_usage,
            title: 'Dữ liệu & Bộ nhớ',
            subtitle: 'Quản lý dữ liệu và bộ nhớ',
            onTap: () {
              _showSnackBar('Chức năng đang được phát triển');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.privacy_tip,
            title: 'Chính sách bảo mật',
            subtitle: 'Xem chính sách bảo mật của ứng dụng',
            onTap: () {
              _showSnackBar('Chính sách bảo mật sẽ được hiển thị ở đây');
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.description,
            title: 'Điều khoản sử dụng',
            subtitle: 'Xem điều khoản và điều kiện sử dụng',
            onTap: () {
              _showSnackBar('Điều khoản sử dụng sẽ được hiển thị ở đây');
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.delete_forever,
            title: 'Xóa tài khoản',
            subtitle: 'Xóa vĩnh viễn tài khoản và dữ liệu',
            onTap: _showDeleteAccountDialog,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.help_center,
            title: 'Trung tâm hỗ trợ',
            subtitle: 'Câu hỏi thường gặp và hướng dẫn',
            onTap: () {
              _showSnackBar('Trung tâm hỗ trợ sẽ được hiển thị ở đây');
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.contact_support,
            title: 'Liên hệ hỗ trợ',
            subtitle: 'Gửi phản hồi hoặc báo cáo vấn đề',
            onTap: _showContactSupportDialog,
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.rate_review,
            title: 'Đánh giá ứng dụng',
            subtitle: 'Đánh giá ứng dụng trên cửa hàng',
            onTap: () {
              _showSnackBar('Đánh giá ứng dụng sẽ được mở');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildSettingTile(
            icon: Icons.info,
            title: 'Về ứng dụng',
            subtitle: '${AppConstants.appName} v${AppConstants.appVersion}',
            onTap: () {
              _showAboutDialog();
            },
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.code,
            title: 'Phiên bản',
            subtitle:
                'Build ${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}',
            onTap: null,
          ),
          const Divider(),
          _buildSettingTile(
            icon: Icons.update,
            title: 'Kiểm tra cập nhật',
            subtitle: 'Kiểm tra phiên bản mới nhất',
            onTap: () {
              _showSnackBar('Đang kiểm tra cập nhật...');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    Widget? trailing,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: trailing ??
          (onTap != null
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                )
              : null),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  String _getLanguageText(String language) {
    switch (language) {
      case 'vi':
        return 'Tiếng Việt';
      case 'en':
        return 'English';
      default:
        return 'Tiếng Việt';
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn ngôn ngữ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tiếng Việt'),
              leading: Radio<String>(
                value: 'vi',
                groupValue: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.of(context).pop();
                  _showSnackBar('Ngôn ngữ đã được thay đổi');
                },
              ),
            ),
            ListTile(
              title: const Text('English'),
              leading: Radio<String>(
                value: 'en',
                groupValue: _language,
                onChanged: (value) {
                  setState(() {
                    _language = value!;
                  });
                  Navigator.of(context).pop();
                  _showSnackBar('Language has been changed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa tài khoản'),
        content: const Text(
            'Bạn có chắc chắn muốn xóa tài khoản? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar('Chức năng xóa tài khoản đang được phát triển');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Xóa tài khoản'),
          ),
        ],
      ),
    );
  }

  void _showContactSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Liên hệ hỗ trợ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('support@mgf-vietnam.com'),
              onTap: () {
                _showSnackBar('Email hỗ trợ: support@mgf-vietnam.com');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Hotline'),
              subtitle: const Text('1900 XXX XXX'),
              onTap: () {
                _showSnackBar('Hotline: 1900 XXX XXX');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationLegalese: '© 2025 MGF Vietnam. All rights reserved.',
      children: [
        const SizedBox(height: 16),
        const Text(
          AppConstants.appDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
