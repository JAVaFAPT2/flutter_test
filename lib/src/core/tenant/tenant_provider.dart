import 'package:vietnamese_fish_sauce_app/src/data/datasources/local/secure_storage.dart' as legacy;

/// Provides the current tenant ID stored securely
class TenantProvider {
  TenantProvider(this._secureStorage);

  final legacy.SecureStorage _secureStorage;

  Future<String?> getTenantId() => _secureStorage.getString('tenant_id');

  Future<void> setTenantId(String tenantId) =>
      _secureStorage.setString('tenant_id', tenantId);
}
