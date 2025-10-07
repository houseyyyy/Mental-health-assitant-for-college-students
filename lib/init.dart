// dart format width=60
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'data/database/database.dart';
import 'shared/view_models/security_key_view_model.dart';
import 'shared/view_models/notification_view_model.dart';

class Init extends StatefulWidget {
  const Init({super.key, required this.child});

  final Widget child;

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> {
  late final AppLifecycleListener appLifecycleListener;
  late final SecurityKeyViewModel securityKeyViewModel;

  @override
  void initState() {
    super.initState();

    securityKeyViewModel = context.read<SecurityKeyViewModel>();

    /// App 生命周期
    appLifecycleListener = AppLifecycleListener(
      onResume: () => debugPrint('App Resume'),
      onInactive: () => debugPrint('App Inactive'),
      onHide: () => debugPrint('App Hide'),
      onShow: () => debugPrint('App Show'),
      onPause: () {
        debugPrint('App Pause');
        securityKeyViewModel.loadlockScreen(context);
      },
      onRestart: () => debugPrint('App Restart'),
      onDetach: () => debugPrint('App Detach'),
    );

    // 延后到 frame 后再做需要 context 的弹窗/权限请求
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  @override
  void dispose() {
    appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Android 使用沉浸（edge to edge）
    if (defaultTargetPlatform == TargetPlatform.android) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    return widget.child;
  }

  Future<void> init() async {
    debugPrint('Init.init: open DB & init notification');

    // 初始化数据库（触发单例打开）
    try {
      await DB.instance.database;
      debugPrint('DB initialized');
    } catch (e) {
      debugPrint('DB init error: $e');
    }

    // 锁屏
    try {
      securityKeyViewModel.loadlockScreen(context);
    } catch (e) {
      debugPrint('loadlockScreen error: $e');
    }

    // 通知：直接使用 NotificationService 单例请求权限（无自定义UI）
    try {
      debugPrint('NotificationService: requesting permission...');
      final allowed = await NotificationService.instance.isPermissionGranted();
      debugPrint('NotificationService: isPermissionGranted=$allowed');

      if (!allowed) {
        final granted =
            await NotificationService.instance.requestPermission();
        debugPrint('NotificationService: requestPermission result=$granted');
      }

      // 也可以初始化 service（如果你放了初始化逻辑）
      await NotificationService.instance.initialize();
      debugPrint('NotificationService initialized');
    } catch (e, st) {
      debugPrint('NotificationService init/request error: $e\n$st');
    }
  }
}
