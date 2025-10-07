import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// 导入主题相关文件
import '../../../shared/config/multiple_theme_mode.dart';
import '../../../shared/view_models/application_view_model.dart';
import '../../../themes/app_theme.dart';

// 导入本地化文件
import '../../../l10n/gen/app_localizations.dart';

class BreathingExercise extends StatefulWidget {
  const BreathingExercise({super.key});

  @override
  _BreathingExerciseState createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = false;
  String _breathText = "";
  String _instructionText = "";
  int _cycleCount = 0;
  int _currentPhase = 0; // 0:吸气, 1:屏息, 2:呼气
  int _prevPhase = -1;
  double _progress = 0.0;

  // 4-7-8呼吸法时间设置（秒）
  final int _inhaleTime = 4;
  final int _holdTime = 7;
  final int _exhaleTime = 8;

  // 中心圆最小/最大尺寸
  final double _minSize = 80.0;
  final double _maxSize = 200.0;

  // 屏息心跳（pulse）相关
  late AnimationController _pulseController;
  late Animation<double> _pulse;
  double _pulseScale = 1.0; // 当前脉动缩放（默认 1.0）

  late AppL10n l10n;
  late AppTheme appTheme;

  // --- 按钮动画相关 ---
  bool _isPressed = false;
  final Duration _animationDuration = const Duration(milliseconds: 300);

  // 统一基准宽度（与 Reset 一致的初始宽度）
  final double _baseButtonWidth = 120.0;
  // 点击后扩展到的宽度（pause 状态）
  final double _expandedButtonWidth = 160.0;
  // 按钮高度（固定）
  final double _buttonHeight = 56.0;
  // 圆角根据状态微调
  double get _borderRadius => _isPlaying ? 28 : 30;

  // 当前按钮宽度（根据播放状态决定）
  double get _buttonWidth => _isPlaying ? _expandedButtonWidth : _baseButtonWidth;
  // ----------------------

  @override
  void initState() {
    super.initState();

    final totalSeconds = _inhaleTime + _holdTime + _exhaleTime;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalSeconds),
    );

    // 监听进度并更新阶段识别（UI 在 AnimatedBuilder 中直接根据 controller 计算尺寸）
    _controller.addListener(() {
      setState(() {
        _progress = _controller.value;
        _updateBreathPhase();
      });
    });

    // 完成一周期后的行为
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _cycleCount++;
        });
        _controller.reset();
        if (_isPlaying) {
          _controller.forward();
        }
      }
    });

    // 屏息脉动控制器（短周期，来回）
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // heart-beat scale: 0.98 -> 1.04 (可根据喜好调整)
    _pulse = Tween<double>(begin: 0.98, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    )..addListener(() {
        // 只更新缩放，不影响其他 UI
        setState(() {
          _pulseScale = _pulse.value;
        });
      });

    _pulseScale = 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppL10n.of(context)!;
    appTheme = AppTheme(context);

    // 初始化文本
    if (_breathText.isEmpty) {
      _breathText = l10n.breathing_ready;
      _instructionText = l10n.breathing_instruction_start;
    }
  }

  // easeInOutSine: 平滑的起止为 0 的曲线
  double _easeInOutSine(double t) {
    // t in [0,1]
    return 0.5 * (1 - math.cos(math.pi * t));
  }

  // 线性插值
  double _lerp(double a, double b, double t) => a + (b - a) * t;

  // 计算当前基础尺寸（不含 pulse）
  double _computeBaseSize() {
    final total = _inhaleTime + _holdTime + _exhaleTime;
    final t = (_controller.value * total);
    if (t <= 0) return _minSize;
    if (t < _inhaleTime) {
      final p = (t / _inhaleTime).clamp(0.0, 1.0);
      final s = _easeInOutSine(p);
      return _lerp(_minSize, _maxSize, s);
    } else if (t < _inhaleTime + _holdTime) {
      // 屏息保持在最大值（pulse 会叠加微小振幅）
      return _maxSize;
    } else if (t < total) {
      final p = ((t - _inhaleTime - _holdTime) / _exhaleTime).clamp(0.0, 1.0);
      final s = _easeInOutSine(p);
      return _lerp(_maxSize, _minSize, s);
    } else {
      return _minSize;
    }
  }

  void _updateBreathPhase() {
    final totalDuration = _inhaleTime + _holdTime + _exhaleTime;
    double phaseProgress = _progress * totalDuration;

    int newPhase;
    if (phaseProgress < _inhaleTime) {
      newPhase = 0;
      _breathText = l10n.breathing_inhale;
      _instructionText = l10n.breathing_instruction_inhale;
    } else if (phaseProgress < _inhaleTime + _holdTime) {
      newPhase = 1;
      int remainingHold = (_inhaleTime + _holdTime - phaseProgress).ceil();
      _breathText = l10n.breathing_hold;
      _instructionText =
          l10n.breathing_instruction_hold(remainingHold.clamp(1, _holdTime));
    } else {
      newPhase = 2;
      int remainingExhale = (totalDuration - phaseProgress).ceil();
      _breathText = l10n.breathing_exhale;
      _instructionText =
          l10n.breathing_instruction_exhale(remainingExhale.clamp(1, _exhaleTime));
    }

    // 处理 pulse 的启动 / 停止（只在阶段变更时切换）
    if (newPhase != _prevPhase) {
      if (newPhase == 1) {
        // 进入屏息，启动心跳脉动（重复，反向）
        _pulseController.repeat(reverse: true);
      } else {
        // 离开屏息，停止脉动并重置 scale 为 1
        if (_pulseController.isAnimating) {
          _pulseController.stop();
        }
        _pulseScale = 1.0;
      }
      _prevPhase = newPhase;
      _currentPhase = newPhase;
    }
  }

  Color _getPhaseColor() {
    final theme = Theme.of(context);

    switch (_currentPhase) {
      case 0: // 吸气 - 使用主题主色
        return theme.colorScheme.primary.withOpacity(0.8);
      case 1: // 屏息 - 使用主题次要色
        return theme.colorScheme.secondary.withOpacity(0.8);
      case 2: // 呼气 - 使用主题强调色
        final cs = theme.colorScheme;
        Color tertiary;
        try {
          tertiary = (cs as dynamic).tertiary ?? cs.secondary;
        } catch (_) {
          tertiary = cs.secondary;
        }
        return tertiary.withOpacity(0.8);
      default:
        return theme.colorScheme.primary.withOpacity(0.8);
    }
  }

  void _toggleBreathing() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        // 如果到达末尾，重置再开始
        if (_controller.value >= 1.0) _controller.reset();
        _controller.forward();
        _breathText = l10n.breathing_inhale;
        _instructionText = l10n.breathing_instruction_inhale;
      } else {
        _controller.stop();
        if (_pulseController.isAnimating) _pulseController.stop();
        _pulseScale = 1.0;
        _instructionText = l10n.breathing_paused;
      }
    });
  }

  void _resetBreathing() {
    setState(() {
      _isPlaying = false;
      _cycleCount = 0;
      _breathText = l10n.breathing_ready;
      _instructionText = l10n.breathing_instruction_start;
      _progress = 0.0;
      _currentPhase = 0;
      _prevPhase = -1;
      _controller.reset();
      if (_pulseController.isAnimating) _pulseController.stop();
      _pulseScale = 1.0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 强制竖屏（可根据全局路由策略调整，若全局已处理可移除）
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.breathing_title),
        backgroundColor: _getPhaseColor(),
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        color: appTheme.isDarkMode
            ? theme.colorScheme.background
            : AppTheme.staticBackgroundColor1,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.breathing_method_478,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                l10n.breathing_method_description,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                l10n.breathing_method_benefit,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // 呼吸动画圆圈（把主动画和 pulseScale 结合）
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: _getPhaseColor().withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),

                  // AnimatedBuilder 使用 controller；内部调用 _computeBaseSize()
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final baseSize = _computeBaseSize();
                      final displaySize = baseSize * _pulseScale;
                      return Container(
                        width: displaySize,
                        height: displaySize,
                        decoration: BoxDecoration(
                          color: _getPhaseColor(),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getPhaseColor().withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Column(
                    children: [
                      Text(
                        _breathText,
                        style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _instructionText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),

              // 进度指示器
              Container(
                width: double.infinity,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: MediaQuery.of(context).size.width * 0.8 * _progress,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getPhaseColor(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // 呼吸阶段指示
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPhaseIndicator(l10n.breathing_inhale, 0, theme),
                  _buildPhaseIndicator(l10n.breathing_hold, 1, theme),
                  _buildPhaseIndicator(l10n.breathing_exhale, 2, theme),
                ],
              ),
              SizedBox(height: 30),

              // 统计信息
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      l10n.stats,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$_cycleCount',
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            Text(
                              l10n.breathing_completed_cycles,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${_cycleCount * 19}',
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            Text(
                              l10n.total_seconds,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // 控制按钮：保持 顺序为 开始/暂停（左） + 重置（右）
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 开始/暂停（AnimatedContainer + InkWell，显示文字）
                  Transform.scale(
                    scale: _isPressed ? 0.97 : 1.0, // 轻微按下缩放反馈
                    child: AnimatedContainer(
                      duration: _animationDuration,
                      curve: Curves.easeInOut,
                      width: _buttonWidth,
                      height: _buttonHeight,
                      decoration: BoxDecoration(
                        color: _getPhaseColor(),
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
                            if (mounted) setState(() => _isPressed = true);
                          },
                          onTapUp: (_) {
                            if (mounted) setState(() => _isPressed = false);
                            _toggleBreathing();
                          },
                          onTapCancel: () {
                            if (mounted) setState(() => _isPressed = false);
                          },
                          child: Center(
                            child: Text(
                              _isPlaying ? l10n.pause : l10n.start_exercise,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  // Reset 按钮：用 SizedBox 固定宽度，保证初始与上面按钮一致
                  SizedBox(
                    width: _baseButtonWidth,
                    height: _buttonHeight,
                    child: ElevatedButton(
                      onPressed: _resetBreathing,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.surfaceVariant,
                        foregroundColor: theme.colorScheme.onSurfaceVariant,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh),
                          SizedBox(width: 8),
                          Text(l10n.reset),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(String text, int phase, ThemeData theme) {
    bool isActive = _currentPhase == phase;
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? _getPhaseColor() : theme.colorScheme.onSurface.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? _getPhaseColor() : theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
