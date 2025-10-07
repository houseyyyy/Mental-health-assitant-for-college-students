import '../../../domain/models/todo/todo_item.dart'; // 假设TodoItem模型的路径
import '../../database/database.dart';
import '../../database/tables/todo_info.dart';

class TodoDao {
  TodoDao({required DB database}) : _database = database;

  final DB _database;

  /// 插入新的Todo
  Future<int> insertTodo(TodoItem todo) async {
    final db = await _database.database;
    return await db.insert(TodoInfo.tableName, todo.toMap());
  }

  /// 获取所有Todo
  Future<List<TodoItem>> getTodos() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(TodoInfo.tableName);
    return List.generate(maps.length, (i) => TodoItem.fromMap(maps[i]));
  }

  /// 更新Todo
  Future<int> updateTodo(TodoItem todo) async {
    final db = await _database.database;
    return await db.update(
      TodoInfo.tableName,
      todo.toMap(),
      where: '${TodoInfo.id} = ?',
      whereArgs: [todo.id],
    );
  }

  /// 删除Todo
  Future<int> deleteTodo(int id) async {
    final db = await _database.database;
    return await db.delete(
      TodoInfo.tableName,
      where: '${TodoInfo.id} = ?',
      whereArgs: [id],
    );
  }

  // 可以根据需要添加更多查询方法，例如按日期、优先级等筛选
}
