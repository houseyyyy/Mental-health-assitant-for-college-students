// dart format width=200
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import '../../data/database/database.dart';
import '../../data/database/shared_preferences_db.dart';
import '../../data/dao/application/application_dao.dart';
import '../../data/dao/application/data_import_export_dao.dart';
import '../../data/dao/application/security_key_dao.dart';
import '../../data/dao/mood/mood_data_dao.dart';
import '../../data/dao/mood/mood_category_dao.dart';
import '../../data/dao/statistic/statistic_dao.dart';
import '../../data/repositories/application/application_repository_local.dart';
import '../../data/repositories/application/data_import_export_repository_local.dart';
import '../../data/repositories/application/security_key_repository_local.dart';
import '../../data/repositories/mood/mood_data_repository_local.dart';
import '../../data/repositories/mood/mood_category_repository_local.dart';
import '../../data/repositories/statistic/statistic_repository_local.dart';

import '../../domain/repositories/application/application_repository.dart';
import '../../domain/repositories/application/data_import_export_repository.dart';
import '../../domain/repositories/application/security_key_repository.dart';
import '../../domain/repositories/mood/mood_data_repository.dart';
import '../../domain/repositories/mood/mood_category_repository.dart';
import '../../domain/repositories/statistic/statistic_repository.dart';
import '../../domain/use_cases/application/application_use_case.dart';
import '../../domain/use_cases/application/data_import_export_use_case.dart';
import '../../domain/use_cases/application/security_key_use_case.dart';
import '../../domain/use_cases/mood/mood_data_use_case.dart';
import '../../domain/use_cases/mood/mood_category_load_use_case.dart';
import '../../domain/use_cases/statistic/statistic_use_case.dart';

import '../view_models/application_view_model.dart';
import '../view_models/security_key_view_model.dart';
import '../view_models/notification_view_model.dart';
import '../view_models/mood_view_model.dart';
import '../view_models/statistic_view_model.dart';

abstract final class Dependencies {
  /// 共享的状态管理
  static List<SingleChildWidget> get _sharedProviders => [
        // use case 需要先注册（见下方 _useCaseProviders）
        ..._useCaseProviders,

        ChangeNotifierProvider<ApplicationViewModel>(
          lazy: true,
          create: (context) => ApplicationViewModel(
            applicationUseCase: context.read<ApplicationUseCase>(),
          ),
        ),

        ChangeNotifierProvider<SecurityKeyViewModel>(
          lazy: true,
          create: (context) => SecurityKeyViewModel(
            securityKeyUseCase: context.read<SecurityKeyUseCase>(),
          ),
        ),

        // 关键：显式指定 NotificationViewModel 类型，并显式读取 AwesomeNotifications
        Provider<NotificationService>.value(
            value: NotificationService.instance, // ✅ 使用单例实例
        ),

        ChangeNotifierProvider<MoodViewModel>(
          lazy: true,
          create: (context) => MoodViewModel(
            moodDataUseCase: context.read<MoodDataUseCase>(),
          ),
        ),

        ChangeNotifierProvider<StatisticViewModel>(
          lazy: true,
          create: (context) => StatisticViewModel(
            statisticUseCase: context.read<StatisticUseCase>(),
          ),
        ),
      ];

  /// use case 依赖注入
  static List<SingleChildWidget> get _useCaseProviders => [
        Provider<ApplicationUseCase>(
          lazy: true,
          create: (context) => ApplicationUseCase(
            applicationRepository: context.read<ApplicationRepository>(),
          ),
        ),
        Provider<DataImportExportUseCase>(
          lazy: true,
          create: (context) => DataImportExportUseCase(
            dataImportExportRepository:
                context.read<DataImportExportRepository>(),
          ),
        ),
        Provider<SecurityKeyUseCase>(
          lazy: true,
          create: (context) => SecurityKeyUseCase(
            securityKeyRepository: context.read<SecurityKeyRepository>(),
          ),
        ),
        Provider<MoodDataUseCase>(
          lazy: true,
          create: (context) =>
              MoodDataUseCase(moodDataRepository: context.read<MoodDataRepository>()),
        ),
        Provider<MoodCategoryLoadUseCase>(
          lazy: true,
          create: (context) => MoodCategoryLoadUseCase(
            moodCategoryRepository: context.read<MoodCategoryRepository>(),
          ),
        ),
        Provider<StatisticUseCase>(
          lazy: true,
          create: (context) => StatisticUseCase(
            statisticRepository: context.read<StatisticRepository>(),
          ),
        ),
      ];

  /// 本地数据状态 依赖注入
  static List<SingleChildWidget> get providersLocal => [
        // 把单例显式声明类型，方便后续 context.read<T>()
        Provider<DB>.value(value: DB.instance),
        Provider<SharedPreferencesDB>.value(value: SharedPreferencesDB.instance),
        Provider<AwesomeNotifications>.value(value: AwesomeNotifications()),

        Provider<ApplicationDao>(
          create: (context) =>
              ApplicationDao(sharedPreferencesDB: context.read<SharedPreferencesDB>()),
        ),

        Provider<DataImportExportDao>(
          create: (context) => DataImportExportDao(database: context.read<DB>()),
        ),

        Provider<SecurityKeyDao>(
          create: (context) =>
              SecurityKeyDao(sharedPreferencesDB: context.read<SharedPreferencesDB>()),
        ),

        Provider<MoodDataDao>(
          create: (context) => MoodDataDao(database: context.read<DB>()),
        ),

        Provider<MoodCategoryDao>(
          create: (context) => MoodCategoryDao(
            database: context.read<DB>(),
            sharedPreferencesDB: context.read<SharedPreferencesDB>(),
          ),
        ),

        Provider<StatisticDao>(
          create: (context) => StatisticDao(database: context.read<DB>()),
        ),

        // repositories — 显式类型为 domain 接口类型
        Provider<ApplicationRepository>(
          create: (context) =>
              ApplicationRepositoryLocal(applicationDao: context.read<ApplicationDao>()),
        ),

        Provider<DataImportExportRepository>(
          create: (context) => DataImportExportRepositoryLocal(
            dataImportExportDao: context.read<DataImportExportDao>(),
          ),
        ),

        Provider<SecurityKeyRepository>(
          create: (context) => SecurityKeyRepositoryLocal(
            securityKeyDao: context.read<SecurityKeyDao>(),
          ),
        ),

        Provider<MoodDataRepository>(
          create: (context) => MoodDataRepositoryLocal(
            moodDataDao: context.read<MoodDataDao>(),
          ),
        ),

        Provider<MoodCategoryRepository>(
          create: (context) => MoodCategoryRepositoryLocal(
            moodCategoryDao: context.read<MoodCategoryDao>(),
          ),
        ),

        Provider<StatisticRepository>(
          create: (context) => StatisticRepositoryLocal(
            statisticDao: context.read<StatisticDao>(),
          ),
        ),

        ..._sharedProviders,
      ];
}
