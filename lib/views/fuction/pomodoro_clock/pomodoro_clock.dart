// 根据你项目实际路径调整下面两行 import
import '../../../l10n/gen/app_localizations.dart';
import '../../../themes/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:numberpicker/numberpicker.dart'; // 添加 numberpicker 依赖，如果未添加，请在 pubspec.yaml 中添加 numberpicker: ^2.1.2

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

enum TimerMode { work, breakTime }

class _PomodoroTimerState extends State<PomodoroTimer> with SingleTickerProviderStateMixin {
  // 时间设置（秒）
  late int _workTotalSeconds;
  late int _breakTotalSeconds;

  TimerMode _currentMode = TimerMode.work;
  late int _totalSeconds; // 当前模式的总秒数
  bool _isRunning = false;
  int _completedPomodoros = 0;
  bool _isPressed = false;

  // 按钮动画相关参数
  double get _buttonWidth => _isRunning ? 120 : 72;
  double get _buttonHeight => _isRunning ? 60 : 72;
  double get _borderRadius => _isRunning ? 30 : 36;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  // 进度条参数
  final double _progressStrokeWidth = 16.0; // 加粗进度条

  // 动画控制器
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _workTotalSeconds = 25 * 60; // 默认工作时间
    _breakTotalSeconds = 5 * 60; // 默认休息时间
    _totalSeconds = _workTotalSeconds;

    // AnimationController duration uses the TOTAL seconds for current mode.
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    // 如果 Animation 完成（例如通过 animateTo 完成），触发完成回调
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 确保只有在运行状态并且剩余为 0 时才调用完成逻辑
        if (_isRunning) {
          _completeTimer();
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // 格式化时间显示
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // 切换工作/休息模式
  void _toggleMode() {
    _stopTimer(); // 停止并重置当前计时（保留逻辑）
    if (mounted) {
      setState(() {
        _currentMode = _currentMode == TimerMode.work ? TimerMode.breakTime : TimerMode.work;
        _totalSeconds = _currentMode == TimerMode.work ? _workTotalSeconds : _breakTotalSeconds;
        // 重设 controller 的 duration 为新的 totalSeconds，并 reset
        _animationController.duration = Duration(seconds: _totalSeconds);
        _animationController.reset();
      });
    }
  }

  // 开始计时器
  void _startTimer() {
    if (!_isRunning) {
      if (mounted) {
        setState(() => _isRunning = true);
      } else {
        _isRunning = true;
      }

      // 保证 controller.duration 与 totalSeconds 保持一致
      _animationController.duration = Duration(seconds: _totalSeconds);

      // 如果剩余为 0（极端情况），直接完成
      if (_animationController.value >= 1.0) {
        _completeTimer();
        return;
      }

      // 继续从当前 value 推进到 1.0（线性）
      _animationController.forward();
    }
  }

  // 暂停计时器
  void _pauseTimer() {
    if (_isRunning) {
      _animationController.stop();
      if (mounted) {
        setState(() => _isRunning = false);
      } else {
        _isRunning = false;
      }
    }
  }

  // 停止计时器并重置
  void _stopTimer() {
    _pauseTimer();
    if (mounted) {
      // 重置动画到 0（视觉重置）
      _animationController.reset();
    }
  }

  // 完成一个番茄钟周期
  void _completeTimer() {
    _animationController.reset();
    if (!mounted) return;

    if (_currentMode == TimerMode.work) {
      if (mounted) {
        setState(() => _completedPomodoros++);
      } else {
        _completedPomodoros++;
      }
    }

    // 切换模式（保留原逻辑）
    final finishedMode = _currentMode;
    // 切换模式会调用 _stopTimer 与重设 totalSeconds
    _toggleMode();

    if (!mounted) return;

    final l10n = AppL10n.of(context);
    final snack = SnackBar(
      content: Text(
        finishedMode == TimerMode.work ? l10n.pomodoro_snack_work_end : l10n.pomodoro_snack_break_end,
      ),
      duration: const Duration(seconds: 2),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  // 显示时间调整对话框
  Future<void> _showTimeAdjustmentDialog() async {
    // 如果正在运行，暂停
    _pauseTimer();

    int hours = _totalSeconds ~/ 3600;
    int minutes = (_totalSeconds ~/ 60) % 60;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              content: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker(
                      value: hours,
                      minValue: 0,
                      maxValue: 24,
                      itemHeight: 70,
                      textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 42),
                      selectedTextStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 54),
                      onChanged: (value) => setDialogState(() {
                        hours = value;
                        if (hours == 24) minutes = 0;
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: const Text(':', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                    ),
                    NumberPicker(
                      value: minutes,
                      minValue: 0,
                      maxValue: 59,
                      itemHeight: 70,
                      textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 42),
                      selectedTextStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 54),
                      onChanged: (value) => setDialogState(() {
                        if (hours < 24) minutes = value;
                      }),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    final newTotalSeconds = hours * 3600 + minutes * 60;
                    if (newTotalSeconds > 0 && newTotalSeconds <= 24 * 3600) {
                      if (_currentMode == TimerMode.work) {
                        _workTotalSeconds = newTotalSeconds;
                      } else {
                        _breakTotalSeconds = newTotalSeconds;
                      }
                      _totalSeconds = newTotalSeconds;
                      _animationController.duration = Duration(seconds: _totalSeconds);
                      _animationController.reset();
                      if (mounted) {
                        setState(() {});
                      }
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 构建自定义圆角进度条
  Widget _buildRoundedProgressIndicator(double size, double progress, Color color, Color background) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RoundedProgressPainter(
        progress: progress,
        color: color,
        strokeWidth: _progressStrokeWidth,
        backgroundColor: background,
      ),
    );
  }

  // 构建圆形进度指示器
  Widget _buildTimerCircle(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size.width * 0.7;
    final progressColor = _currentMode == TimerMode.work
        ? theme.colorScheme.primary
        : (theme.colorScheme.secondary != Colors.transparent ? theme.colorScheme.secondary : Colors.greenAccent);
    final backgroundColor = theme.colorScheme.surfaceVariant;

    return GestureDetector(
      onTap: _showTimeAdjustmentDialog,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double elapsed = _animation.value * _totalSeconds;
          final int elapsedSeconds = elapsed.floor();
          final int remainingSeconds = _totalSeconds - elapsedSeconds;

          return Stack(
            alignment: Alignment.center,
            children: [
              // 背景圆（用 surfaceVariant）
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
              // 自定义圆角进度条（旋转 -90deg 让起点在顶部）
              Transform.rotate(
                angle: -0.5 * 3.1415926535,
                child: _buildRoundedProgressIndicator(size, _animation.value, progressColor, backgroundColor),
              ),
              // 中间时间文本（使用主题文字样式）
              Text(
                _formatTime(remainingSeconds),
                style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: progressColor,
                    ) ??
                    TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: progressColor),
              ),
            ],
          );
        },
      ),
    );
  }

  // 构建控制按钮（主题化）
  Widget _buildControlButtons(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = _currentMode == TimerMode.work ? theme.colorScheme.primary : theme.colorScheme.secondary;
    final pressedColor = baseColor.withOpacity(0.8);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh, size: 32),
          color: theme.iconTheme.color,
          tooltip: AppL10n.of(context).pomodoro_reset_tooltip,
          onPressed: _stopTimer,
        ),
        const SizedBox(width: 32),
        AnimatedContainer(
          duration: _animationDuration,
          curve: Curves.easeInOut,
          width: _buttonWidth,
          height: _buttonHeight,
          decoration: BoxDecoration(
            color: _isPressed ? pressedColor : baseColor,
            borderRadius: BorderRadius.circular(_borderRadius),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(_borderRadius),
              onTapDown: (_) {
                if (mounted) {
                  setState(() => _isPressed = true);
                }
              },
              onTapUp: (_) {
                if (mounted) {
                  setState(() => _isPressed = false);
                }
                _isRunning ? _pauseTimer() : _startTimer();
              },
              onTapCancel: () {
                if (mounted) {
                  setState(() => _isPressed = false);
                }
              },
              child: Center(
                child: _isRunning
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 4, height: 20, color: theme.colorScheme.onPrimary),
                          const SizedBox(width: 8),
                          Container(width: 4, height: 20, color: theme.colorScheme.onPrimary),
                        ],
                      )
                    : Icon(Icons.play_arrow, color: theme.colorScheme.onPrimary, size: 36),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: const Icon(Icons.swap_horiz, size: 32),
          color: theme.iconTheme.color,
          tooltip: AppL10n.of(context).pomodoro_toggle_tooltip,
          onPressed: _toggleMode,
        ),
      ],
    );
  }

  // 构建已完成番茄钟指示器
  Widget _buildCompletedIndicators(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppL10n.of(context);
    return Column(
      children: [
        Text(
          l10n.pomodoro_completed_label,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _completedPomodoros,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.circle,
                size: 12,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 强制竖屏（保留）
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final theme = Theme.of(context);
    final l10n = AppL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentMode == TimerMode.work ? l10n.pomodoro_mode_work_title : l10n.pomodoro_mode_break_title,
          style: theme.appBarTheme.titleTextStyle ?? theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: AppTheme(context).isDarkMode ? theme.colorScheme.background : AppTheme.staticBackgroundColor1,
      body: Container(
        color: AppTheme(context).isDarkMode ? theme.colorScheme.background : AppTheme.staticBackgroundColor1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimerCircle(context),
            _buildControlButtons(context),
            _buildCompletedIndicators(context),
          ],
        ),
      ),
    );
  }
}

// 自定义圆角进度条绘制器（支持背景色）
class _RoundedProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;

  _RoundedProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // 绘制背景圆（用 backgroundColor 的更深/浅版本）
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // 绘制进度圆
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.1415926535 * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -0.5 * 3.1415926535, // 从顶部开始
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RoundedProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}