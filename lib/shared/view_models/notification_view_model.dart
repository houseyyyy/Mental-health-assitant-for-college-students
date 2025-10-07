// lib/shared/services/notification_service.dart
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';
import '../../domain/models/todo/todo_item.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  final AwesomeNotifications _aw = AwesomeNotifications();

  /// 在应用启动时调用一次（你已有的 init 可继续使用）
  Future<void> initialize() async {
    // 你原来 NotificationService.init() 的初始化可以沿用，
    // 保持此处空实现或放置 fallback 初始化逻辑
  }

  Future<bool> isPermissionGranted() => _aw.isNotificationAllowed();

  Future<bool> requestPermission() => _aw.requestPermissionToSendNotifications();

  Future<void> cancelNotification(int id) async {
    try {
      await _aw.cancel(id);
    } catch (_) {}
  }

  Future<void> cancelAll() async => _aw.cancelAll();

  /// 将 DateTime 转成 NotificationCalendar，创建一次性通知
  Future<void> _createOneShotNotification({
    required int id,
    required String channelKey,
    required String title,
    String? body,
    required DateTime scheduleAt,
  }) async {
    if (!scheduleAt.isAfter(DateTime.now())) return;

    final isAllowed = await _aw.isNotificationAllowed();
    if (!isAllowed) return;

    await _aw.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body ?? '',
        actionType: ActionType.Default,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduleAt),
    );
  }

  /// 根据 TodoItem 的 notifyBefore* 字段决定是否创建一次性通知
  Future<void> scheduleTodoNotificationIfNeeded(TodoItem todo) async {
    final h = todo.notifyBeforeHours;
    final m = todo.notifyBeforeMinutes;
    if ((h == 0 && m == 0) || todo.id == null) {
      // 0 表示不提醒，或没有 id 无法作为唯一通知 id
      return;
    }
    final scheduleTime =
        todo.startTime.subtract(Duration(hours: h, minutes: m));
    if (!scheduleTime.isAfter(DateTime.now())) return;
    
    await _createOneShotNotification(
      id: todo.id!, // 使用 todo.id 作为 notification id
      channelKey: 'notification',
      title: '待办提醒：${todo.title}',
      body: todo.content,
      scheduleAt: scheduleTime,
    );

    debugPrint('>>> scheduleTodoNotificationIfNeeded: id=${todo.id}');
    debugPrint('>>> notifyBefore ${todo.notifyBeforeHours}h ${todo.notifyBeforeMinutes}m');
    debugPrint('>>> todo.startTime = ${todo.startTime.toIso8601String()}');
    debugPrint('>>> computed scheduleTime = ${scheduleTime.toIso8601String()} now=${DateTime.now().toIso8601String()}');
  }
}
