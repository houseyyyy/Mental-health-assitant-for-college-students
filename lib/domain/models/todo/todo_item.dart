// dart format width=60
import 'package:flutter/widgets.dart';

@immutable
class TodoItem {
  const TodoItem({
    this.id,
    required this.title,
    this.content,
    required this.startTime,
    required this.endTime,
    required this.priority,
    required this.gradient1,
    required this.gradient2,
    this.notifyBeforeHours = 0,
    this.notifyBeforeMinutes = 0,
  });

  /// 从数据库 Map 构建对象（添加容错）
  factory TodoItem.fromMap(Map<String, dynamic> map) {
    DateTime parseDateTime(dynamic value) {
      if (value == null) return DateTime.now();
      if (value is DateTime) return value;
      if (value is int) {
        // unix timestamp (毫秒)
        try {
          return DateTime.fromMillisecondsSinceEpoch(value);
        } catch (_) {
          return DateTime.now();
        }
      }
      if (value is String && value.isNotEmpty) {
        try {
          return DateTime.parse(value);
        } catch (e) {
          debugPrint('日期解析错误: $e, 原始值: $value');
          return DateTime.now();
        }
      }
      return DateTime.now();
    }

    int parseInt(dynamic v, [int fallback = 0]) {
      if (v == null) return fallback;
      if (v is int) return v;
      if (v is String && v.isNotEmpty) {
        return int.tryParse(v) ?? fallback;
      }
      return fallback;
    }

    return TodoItem(
      id: map['id'] is int ? map['id'] as int : null,
      title: map['title'] ?? '',
      content: map['content'],
      startTime: parseDateTime(map['startTime']),
      endTime: parseDateTime(map['endTime']),
      priority: parseInt(map['priority'], 2),
      gradient1: map['gradient1'] ?? 'ffcccccc',
      gradient2: map['gradient2'] ?? 'ff999999',
      notifyBeforeHours:
          parseInt(map['notifyBeforeHours'], 0),
      notifyBeforeMinutes:
          parseInt(map['notifyBeforeMinutes'], 0),
    );
  }

  final int? id;
  final String title;
  final String? content;
  final DateTime startTime;
  final DateTime endTime;
  final int priority;
  final String gradient1;
  final String gradient2;

  /// 新增：提前通知（小时）
  final int notifyBeforeHours;

  /// 新增：提前通知（分钟）
  final int notifyBeforeMinutes;

  /// 转换为数据库 Map（用于插入/更新）
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'priority': priority,
      'gradient1': gradient1,
      'gradient2': gradient2,
      'notifyBeforeHours': notifyBeforeHours,
      'notifyBeforeMinutes': notifyBeforeMinutes,
    };
  }

  TodoItem copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? startTime,
    DateTime? endTime,
    int? priority,
    String? gradient1,
    String? gradient2,
    int? notifyBeforeHours,
    int? notifyBeforeMinutes,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
      gradient1: gradient1 ?? this.gradient1,
      gradient2: gradient2 ?? this.gradient2,
      notifyBeforeHours:
          notifyBeforeHours ?? this.notifyBeforeHours,
      notifyBeforeMinutes:
          notifyBeforeMinutes ?? this.notifyBeforeMinutes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          priority == other.priority &&
          gradient1 == other.gradient1 &&
          gradient2 == other.gradient2 &&
          notifyBeforeHours == other.notifyBeforeHours &&
          notifyBeforeMinutes == other.notifyBeforeMinutes;

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        content,
        startTime,
        endTime,
        priority,
        gradient1,
        gradient2,
        notifyBeforeHours,
        notifyBeforeMinutes,
      ]);
}
