import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:bonfire/bonfire.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'domain/models/mood/mood_data_model.dart';

import 'init.dart';
import 'views/main_screen.dart';
import 'views/home/home.dart';
import 'views/mood/view_models/mood_category_select_view_model.dart';
import 'views/onboarding/onboarding.dart';
import 'views/mood/mood.dart';
import 'views/mood/mood_category_select.dart';
import 'views/mood/mood_content_edit.dart';
import 'views/statistic/statistic.dart';
import 'views/laboratory/tilt_example/tilt_example.dart';
import 'views/web_view/web_view.dart';

import 'views/fuction/aichat/ai.dart';
import 'views/fuction/pomodoro_clock/pomodoro_clock.dart';
import 'views/fuction/todo/todolist.dart';
import 'views/fuction/release_stress/release_stress.dart';

/// 定义路由名称
abstract final class Routes {
  /// 主页
  static const String home = 'home';

  /// 用户引导页
  static const String onboarding = 'onboarding';

  /// 心情详情列表页
  static const String mood = 'mood';

  /// 添加心情选择页
  ///
  /// - [type] 状态 [MoodCategorySelectType] add: 添加 edit: 编辑
  /// - [selectDateTime] 当前选择的时间
  static const String moodCategorySelect = 'moodCategorySelect';

  /// 添加心情内容编辑页
  ///
  /// - [moodData] 心情数据 [MoodDataModel]
  static const String moodContentEdit = 'moodContentEdit';

  /// 统计页
  static const String statistic = 'statistic';

  /// 设置页-实验室-倾斜视差卡片
  static const String laboratoryTiltExample = 'laboratoryTiltExample';

  /// 功能页- ai -聊天
  static const String aiScreen = 'AiScreen';
  /// 功能页- 番茄钟
  static const String pomodoro_clock = 'PomodoroApp';
  /// 功能页- todo
  static const String todolist = 'TodoListScreen';
  /// 功能页- 呼吸
  static const String breath = 'BreathingExercise';

  /// WebView
  ///
  /// - [url] 访问的 URL （通过 ValueConvert 编码传递）
  static const String webViewPage = 'webViewPage';

}

/// 路由管理
abstract final class AppRouter {
  const AppRouter._();

  /// 根路由
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  /// 子路由-主屏幕-主页
  static final GlobalKey<NavigatorState> shellHomeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );

  /// 子路由-主屏幕-心情详情列表页
  static final GlobalKey<NavigatorState> shellMoodNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellMood',
  );

  /// 子路由-主屏幕-统计页
  static final GlobalKey<NavigatorState> shellStatisticNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'shellStatistic',
  );

  /// 路由配置
  static final config = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    observers: [FlutterSmartDialog.observer],
    initialLocation: '/${Routes.home}',
    routes: [
      /// 主屏幕（有状态嵌套路由）
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: rootNavigatorKey,
        builder:
            (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
              /// 主屏幕
              return Init(
                child: MainScreen(
                  key: const Key('widget_menu_page'),
                  navigationShell: navigationShell,
                ),
              );
            },
        branches: [
          /// 主页
          StatefulShellBranch(
            navigatorKey: shellHomeNavigatorKey,
            initialLocation: '/${Routes.home}',
            routes: [
              GoRoute(
                path: '/${Routes.home}',
                name: Routes.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),

          /// 心情详情列表页
          StatefulShellBranch(
            navigatorKey: shellMoodNavigatorKey,
            initialLocation: '/${Routes.mood}',
            routes: [
              GoRoute(
                path: '/${Routes.mood}',
                name: Routes.mood,
                builder: (_, _) => const MoodScreen(),
              ),
            ],
          ),

          /// 统计页
          StatefulShellBranch(
            navigatorKey: shellStatisticNavigatorKey,
            initialLocation: '/${Routes.statistic}',
            routes: [
              GoRoute(
                path: '/${Routes.statistic}',
                name: Routes.statistic,
                builder: (_, _) => const StatisticScreen(),
              ),
            ],
          ),
        ],
      ),

      /// 用户引导页
      GoRoute(
        path: '/${Routes.onboarding}',
        name: Routes.onboarding,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const OnboardingScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 添加心情选择页
      GoRoute(
        path: '/${Routes.moodCategorySelect}/:type/:selectDateTime',
        name: Routes.moodCategorySelect,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) {
          final screenType = MoodCategorySelectType.fromString(state.pathParameters['type'] ?? '');
          final selectDateTime = DateTime.parse(state.pathParameters['selectDateTime'] ?? '');

          return CustomTransitionPage(
            child: MoodCategorySelectScreen(screenType: screenType, selectDateTime: selectDateTime),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(
                primaryRouteAnimation: animation,
                secondaryRouteAnimation: secondaryAnimation,
                linearTransition: false,
                child: child,
              );
            },
          );
        },
      ),

      /// 添加心情内容页
      GoRoute(
        path: '/${Routes.moodContentEdit}/:moodData',
        name: Routes.moodContentEdit,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) {
          final moodData = MoodDataModel.fromJson(
            jsonDecode(state.pathParameters['moodData'] ?? ''),
          );

          return CustomTransitionPage(
            child: MoodContentEditScreen(moodData: moodData),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(
                primaryRouteAnimation: animation,
                secondaryRouteAnimation: secondaryAnimation,
                linearTransition: false,
                child: child,
              );
            },
          );
        },
      ),

      /// 设置页-实验室
      GoRoute(
        path: '/${Routes.laboratoryTiltExample}',
        name: Routes.laboratoryTiltExample,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, _) => CustomTransitionPage(
          child: const TiltExampleScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),


      /// WebView
      GoRoute(
        path: '/${Routes.webViewPage}/:url',
        name: Routes.webViewPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, state) => CustomTransitionPage(
          child: WebViewScreen(url: state.pathParameters['url'] ?? ''),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 功能页 -aichat
      GoRoute(
        path: '/${Routes.aiScreen}',
        name: Routes.aiScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, __) => CustomTransitionPage(
          child: const AiScreen(), // <- 如果类名不是 AiScreen，改成你实际的类名
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),

      /// 功能页 -pomodoro clock
      GoRoute(
        path: '/${Routes.pomodoro_clock}',
        name: Routes.pomodoro_clock,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, __) => CustomTransitionPage(
          child: const PomodoroTimer(), // <- 如果类名不是 AiScreen，改成你实际的类名
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),
      /// 功能页 - todo list
      GoRoute(
        path: '/${Routes.todolist}',
        name: Routes.todolist,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, __) => CustomTransitionPage(
          child: const TodoListScreen(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),


      /// 功能页 - todo list
      GoRoute(
        path: '/${Routes.breath}',
        name: Routes.breath,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (_, __) => CustomTransitionPage(
          child: const BreathingExercise(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),


    ],
  );
}
