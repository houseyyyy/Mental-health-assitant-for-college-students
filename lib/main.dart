import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'main_local.dart' as local;
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 加载根目录下的 .env 文件
  await dotenv.load(fileName: '.env');
  // shared_preferences 模拟器需要使用（防止异常）
  // 该操作会清空所有 SharedPreferences 值
  // SharedPreferences.setMockInitialValues({});

  local.main();

  /// 强制竖屏
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
