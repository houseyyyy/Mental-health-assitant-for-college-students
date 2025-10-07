// 请保持文件顶部已有这些 import（按你项目路径调整本地化 import）
import '../../../l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import '../../../widgets/action_button/action_button.dart';

class TiltExampleScreen extends StatelessWidget {
  const TiltExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F3),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF1F2F3),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: Text(l10n.daily_sentences),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: const SafeArea(child: TiltExample()),
      ),
    );
  }
}

class TiltExample extends StatelessWidget {
  const TiltExample({super.key});

  // 这里声明你希望支持的消息数量（在 l10n 中添加相应数量的键）
  static const int _messagesCount = 12; // <-- 修改为你实际添加的条目数

  // 计算今天应该显示的索引（基于本地日期；每天 00:00 切换）
  int _todayIndex(int itemCount) {
    // 用 local date 的 days since epoch 保证在本地每天变一次
    final now = DateTime.now().toLocal();
    // 使用 UTC epoch 或自定义基准都可以；这里直接用 Unix epoch
    final epochDays = now.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
    return (epochDays % itemCount).abs();
  }

  // 从 l10n 中收集消息列表 —— 按照你 ARB 中的键名排列
  List<String> _collectLocalizedMessages(AppL10n l10n) {
    // 请确保在 l10n .arb 中按下面的键名添加对应条目：
    // tilt_card_message_0, tilt_card_message_1, ..., tilt_card_message_N
    // 这里硬编码调用每个键（gen_l10n 会为每个键生成 getter）
    return [
      l10n.tilt_card_message_0,
      l10n.tilt_card_message_1,
      l10n.tilt_card_message_2,
      l10n.tilt_card_message_3,
      l10n.tilt_card_message_4,
      l10n.tilt_card_message_5,
      l10n.tilt_card_message_6,
      l10n.tilt_card_message_7,
      l10n.tilt_card_message_8,
      l10n.tilt_card_message_9,
      l10n.tilt_card_message_10,
      l10n.tilt_card_message_11
      // 如果 _messagesCount > 6，请在这里继续加入对应的 l10n.xx
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    // 收集消息并计算要显示哪一条
    final messages = _collectLocalizedMessages(l10n);
    // 以实际 messages.length 为准（以防你把 _messagesCount 和实际不一致）
    final count = messages.length;
    final index = _todayIndex(count);
    final todayMessage = messages[index];

    final innerBox = <Widget>[];
    for (var i = 1; i <= 10; i++) {
      innerBox.add(
        TiltParallax(
          size: Offset(-20.0 * i, -30.0 * i),
          child: Container(
            width: 200 * (1 - i * 0.05),
            height: 200 * (1 - i * 0.05),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 4 * (1 - i * 0.05),
                color: Colors.white.withOpacity(1 - (i - 1) * 0.1),
              ),
            ),
          ),
        ),
      );
    }

    return Center(
      child: Tilt(
        borderRadius: BorderRadius.circular(24.0),
        tiltConfig: const TiltConfig(
          angle: 20,
          leaveCurve: Curves.easeInOutCubicEmphasized,
          leaveDuration: Duration(milliseconds: 1200),
        ),
        lightConfig: const LightConfig(disable: true),
        shadowConfig: const ShadowConfig(disable: true),
        childLayout: ChildLayout(
          inner: [
            ...innerBox,
            // 这里把原先的硬编码文本替换为本地化调用（key: tilt_touch_and_move）
            Positioned(
              left: 30.0,
              bottom: 30.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.tilt_touch_and_move, // <-- 本地化 key 占位，按你实际 key 替换
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // 替换为支持每天变化的消息，并用 AnimatedSwitcher 做淡入淡出效果
            Positioned.fill(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      // 淡入 + 轻微向上移动
                      final offsetAnimation = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
                          .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: offsetAnimation, child: child),
                      );
                    },
                    child: Text(
                      todayMessage,
                      key: ValueKey<String>(todayMessage), // 依 message 变化触发切换动画
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            blurRadius: 8,
                            offset: Offset(0, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.26),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Container(
          width: 300,
          height: 500,
          decoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
