import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Database helper for local data persistence using sqflite
/// Singleton pattern to ensure single database instance
class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  /// Get database instance (create if not exists)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database with tables
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'vietnamese_fish_sauce.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    // Notifications table
    await db.execute('''
      CREATE TABLE notifications (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        is_read INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Seed initial mock data for testing
    await _seedNotifications(db);
  }

  /// Seed initial mock notifications matching Figma design
  Future<void> _seedNotifications(Database db) async {
    final now = DateTime.now();

    // Notification 1: Unread order notification (Tuesday)
    await db.insert('notifications', {
      'id': '1',
      'title': 'Đơn hàng',
      'message': 'Đơn hàng X123xxxx của bạn đang trên đường...',
      'created_at':
          now.subtract(const Duration(days: 2)).millisecondsSinceEpoch,
      'is_read': 0,
    });

    // Notification 2: Read system notification (Sunday)
    await db.insert('notifications', {
      'id': '2',
      'title': 'Hệ thống',
      'message': 'Mật khẩu vừa được thay đổi thành công.',
      'created_at':
          now.subtract(const Duration(days: 5)).millisecondsSinceEpoch,
      'is_read': 1,
    });

    // Notification 3: Read profile notification (20 Oct)
    await db.insert('notifications', {
      'id': '3',
      'title': 'Cá nhân',
      'message': 'Cập nhập thông tin cá nhân!',
      'created_at':
          now.subtract(const Duration(days: 10)).millisecondsSinceEpoch,
      'is_read': 1,
    });
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
