// dart format width=60
abstract final class TodoInfo {
  /// 表名称
  static const String tableName = 'todos';

  /// 字段名
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String priority = 'priority';
  static const String gradient1 = 'gradient1';
  static const String gradient2 = 'gradient2';

  /// 新增字段：提前通知小时（整型，默认0）
  static const String notifyBeforeHours = 'notifyBeforeHours';

  /// 新增字段：提前通知分钟（整型，默认0）
  static const String notifyBeforeMinutes = 'notifyBeforeMinutes';

  /// 删除数据库表
  static const String dropTable =
      'DROP TABLE IF EXISTS $tableName';

  /// 创建数据库表（包含提前通知字段）
  static const String createTable = '''
      CREATE TABLE $tableName (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $title TEXT,
        $content TEXT,
        $startTime TEXT,
        $endTime TEXT,
        $priority INTEGER,
        $gradient1 TEXT,
        $gradient2 TEXT,
        $notifyBeforeHours INTEGER DEFAULT 0,
        $notifyBeforeMinutes INTEGER DEFAULT 0
      );
    ''';
}
