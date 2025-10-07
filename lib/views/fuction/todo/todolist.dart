// dart format width=60
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../../../shared/view_models/notification_view_model.dart';
import '../../../themes/app_theme.dart';
import '../../../data/dao/todo_list/todo.dart';
import '../../../data/database/database.dart';
import '../../../domain/models/todo/todo_item.dart';

/// 工具：格式化日期时间
String formatDateTime(DateTime dt) =>
    DateFormat('yyyy-MM-dd HH:mm').format(dt);

/// ========== Todo 列表页 ==========
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todos = [];
  late final TodoDao _todoDao;

  @override
  void initState() {
    super.initState();
    _todoDao = TodoDao(database: DB.instance);
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    try {
      final data = await _todoDao.getTodos();
      setState(() {
        _todos
          ..clear()
          ..addAll(data);
      });
    } catch (e) {
      debugPrint('加载待办失败: $e');
    }
  }

  Future<void> _onAddPressed() async {
    final newTodo = await Navigator.push<TodoItem?>(
      context,
      MaterialPageRoute(builder: (_) => const AddTodoScreen()),
    );

    if (newTodo != null) {
      try {
        // 插入数据库并获取新 id
        final newId = await _todoDao.insertTodo(newTodo);
        // 用新 id 构建完整实例
        final savedTodo = newTodo.copyWith(id: newId);
        // 尝试调度通知（如果设置）
        await NotificationService.instance
            .scheduleTodoNotificationIfNeeded(savedTodo);
        await _loadTodos();
      } catch (e) {
        debugPrint('插入待办失败: $e');
      }
    }
  }

  Future<void> _onEditPressed(int index) async {
    final original = _todos[index];
    final edited = await Navigator.push<TodoItem?>(
      context,
      MaterialPageRoute(
          builder: (_) => AddTodoScreen(todoItem: original)),
    );

    if (edited != null) {
      try {
        // 确保 id 保持不变（编辑返回的应包含 id）
        final toUpdate = edited.copyWith(id: original.id);
        await _todoDao.updateTodo(toUpdate);
        // DAO 的 updateTodo 已包含取消旧通知与重新调度的逻辑，
        // 但若没有，可在这里显式调用：
        await NotificationService.instance
            .scheduleTodoNotificationIfNeeded(toUpdate);
        await _loadTodos();
      } catch (e) {
        debugPrint('更新待办失败: $e');
      }
    }
  }

  Future<void> _onDeletePressed(int index) async {
    final l10n = AppL10n.of(context)!;
    final todo = _todos[index];
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.todo_confirm_delete_title),
        content: Text(l10n.todo_confirm_delete_content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        if (todo.id != null) {
          await NotificationService.instance.cancelNotification(todo.id!);
          await _todoDao.deleteTodo(todo.id!);
        }
        await _loadTodos();
      } catch (e) {
        debugPrint('删除待办失败: $e');
      }
    }
  }

  Widget _buildTile(TodoItem todo, int index) {
    final theme = Theme.of(context);
    final gradientColors = <Color>[
      Color(int.parse(todo.gradient1, radix: 16)),
      Color(int.parse(todo.gradient2, radix: 16)),
    ];
    final l10n = AppL10n.of(context)!;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          todo.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          '${l10n.start_time}: ${formatDateTime(todo.startTime)}\n'
          '${l10n.end_time}: ${formatDateTime(todo.endTime)}\n'
          '${l10n.priority}: ${_priorityText(todo.priority, l10n)}\n'
          '提醒: ${todo.notifyBeforeHours}h ${todo.notifyBeforeMinutes}m',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.white70),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white, size: 20),
              onPressed: () => _onEditPressed(index),
            ),
            IconButton(
              icon:
                  const Icon(Icons.delete, color: Colors.white, size: 20),
              onPressed: () => _onDeletePressed(index),
            ),
          ],
        ),
      ),
    );
  }

  String _priorityText(int p, AppL10n l10n) {
    switch (p) {
      case 1:
        return l10n.high;
      case 2:
        return l10n.medium;
      case 3:
        return l10n.low;
      default:
        return l10n.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context)!;
    final theme = Theme.of(context);
    final appTheme = AppTheme(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.todo_list_title),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: appTheme.isDarkMode
            ? theme.colorScheme.background
            : AppTheme.staticBackgroundColor1,
        child: RefreshIndicator(
          onRefresh: _loadTodos,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: _todos.length,
            itemBuilder: (context, index) =>
                _buildTile(_todos[index], index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPressed,
        child: const Icon(Icons.add),
        tooltip: l10n.add_todo,
      ),
    );
  }
}

/// ========== 添加 / 编辑页面 ==========
class AddTodoScreen extends StatefulWidget {
  final TodoItem? todoItem;
  const AddTodoScreen({super.key, this.todoItem});

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _hoursController = TextEditingController(text: '0');
  final _minutesController = TextEditingController(text: '0');

  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(const Duration(hours: 1));
  int _priority = 2;

  String? _g1;
  String? _g2;

  final _roundedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(color: Colors.grey),
  );

  @override
  void initState() {
    super.initState();
    // 强制竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (widget.todoItem != null) {
      final t = widget.todoItem!;
      _titleController.text = t.title;
      _contentController.text = t.content ?? '';
      _startTime = t.startTime;
      _endTime = t.endTime;
      _priority = t.priority;
      _g1 = t.gradient1;
      _g2 = t.gradient2;
      _hoursController.text = t.notifyBeforeHours.toString();
      _minutesController.text = t.notifyBeforeMinutes.toString();
    } else {
      _generateRandomGradient();
    }
  }

  @override
  void dispose() {
    // 恢复方向设置
    SystemChrome.setPreferredOrientations([]);
    _titleController.dispose();
    _contentController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    super.dispose();
  }

  void _generateRandomGradient() {
    final rand = Random();
    final c1 =
        Colors.primaries[rand.nextInt(Colors.primaries.length)].shade300;
    Color c2;
    do {
      c2 =
          Colors.primaries[rand.nextInt(Colors.primaries.length)].shade700;
    } while (c1 == c2);
    _g1 = c1.value.toRadixString(16);
    _g2 = c2.value.toRadixString(16);
  }

  Future<void> _selectDateAndTime(bool isStart) async {
    final l10n = AppL10n.of(context)!;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStart ? _startTime : _endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: isStart ? l10n.select_start_date : l10n.select_end_date,
      cancelText: l10n.cancel,
      confirmText: l10n.confirm,
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(isStart ? _startTime : _endTime),
        cancelText: l10n.cancel,
        confirmText: l10n.confirm,
      );

      if (pickedTime != null) {
        setState(() {
          if (isStart) {
            _startTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          } else {
            _endTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context)!;
    final theme = Theme.of(context);
    final appTheme = AppTheme(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.todoItem == null ? l10n.add_todo : l10n.edit_todo),
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        color: appTheme.isDarkMode
            ? theme.colorScheme.background
            : AppTheme.staticBackgroundColor1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.title,
                  border: _roundedBorder,
                  enabledBorder: _roundedBorder,
                  focusedBorder: _roundedBorder.copyWith(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: l10n.content,
                  border: _roundedBorder,
                  enabledBorder: _roundedBorder,
                  focusedBorder: _roundedBorder.copyWith(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                maxLines: 3,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: InputDecoration(
                  labelText: l10n.priority,
                  border: _roundedBorder,
                  enabledBorder: _roundedBorder,
                  focusedBorder: _roundedBorder.copyWith(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                items: [
                  DropdownMenuItem(value: 1, child: Text(l10n.high)),
                  DropdownMenuItem(value: 2, child: Text(l10n.medium)),
                  DropdownMenuItem(value: 3, child: Text(l10n.low)),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _priority = v);
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                tileColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text('${l10n.start_time}: ${formatDateTime(_startTime)}'),
                onTap: () async => await _selectDateAndTime(true),
                trailing: const Icon(Icons.calendar_today),
              ),
              const SizedBox(height: 8),
              ListTile(
                tileColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                title: Text('${l10n.end_time}: ${formatDateTime(_endTime)}'),
                onTap: () async => await _selectDateAndTime(false),
                trailing: const Icon(Icons.calendar_today),
              ),
              const SizedBox(height: 12),

              // 提前提醒输入（小时 + 分钟）
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _hoursController,
                      decoration: InputDecoration(
                        labelText: l10n.todo_notify_before_hours ??
                            '提前提醒（小时）',
                        border: _roundedBorder,
                        enabledBorder: _roundedBorder,
                        focusedBorder: _roundedBorder.copyWith(
                          borderSide: BorderSide(
                              color: theme.primaryColor, width: 2),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _minutesController,
                      decoration: InputDecoration(
                        labelText: l10n.todo_notify_before_minutes ??
                            '提前提醒（分钟）',
                        border: _roundedBorder,
                        enabledBorder: _roundedBorder,
                        focusedBorder: _roundedBorder.copyWith(
                          borderSide: BorderSide(
                              color: theme.primaryColor, width: 2),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    final l10n = AppL10n.of(context)!;

                    if (_titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.todo_title_required)),
                      );
                      return;
                    }
                    if (_endTime.isBefore(_startTime)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.todo_end_time_invalid)),
                      );
                      return;
                    }

                    final int notifyHours =
                        int.tryParse(_hoursController.text) ?? 0;
                    final int notifyMinutes =
                        int.tryParse(_minutesController.text) ?? 0;

                    if (notifyHours < 0 ||
                        notifyMinutes < 0 ||
                        notifyMinutes >= 60) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(l10n.todo_notify_time_invalid ??
                                '提醒时间不合法')),
                      );
                      return;
                    }

                    final todo = TodoItem(
                      id: widget.todoItem?.id,
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      startTime: _startTime,
                      endTime: _endTime,
                      priority: _priority,
                      gradient1: _g1!,
                      gradient2: _g2!,
                      notifyBeforeHours: notifyHours,
                      notifyBeforeMinutes: notifyMinutes,
                    );

                    Navigator.pop(context, todo);
                  },
                  child: Text(
                    widget.todoItem == null ? l10n.save_todo : l10n.update_todo,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
