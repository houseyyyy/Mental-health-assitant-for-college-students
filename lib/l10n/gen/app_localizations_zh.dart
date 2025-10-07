// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppL10nZh extends AppL10n {
  AppL10nZh([String locale = 'zh']) : super(locale);

  @override
  String get app_bottomNavigationBar_title_home => '首页';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '统计';

  @override
  String get app_setting_database => '数据';

  @override
  String get app_setting_database_export_data => '导出数据';

  @override
  String get app_setting_database_export_data_toast_success => '导出成功';

  @override
  String get app_setting_database_import_data => '导入数据';

  @override
  String get app_setting_database_import_data_button_error => '错误';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '导入失败，请下载错误数据，修改后再试。';

  @override
  String get app_setting_database_import_data_toast_success => '导入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打开应用时需要进行解锁。';

  @override
  String get app_setting_security_lock => '密码锁';

  @override
  String get app_setting_security_biometric_weak => '指纹、面部等识别';

  @override
  String get app_setting_security_biometric_iris => '虹膜识别';

  @override
  String get app_setting_security_biometric_face => '面部识别';

  @override
  String get app_setting_security_biometric_fingerprint => '指纹识别';

  @override
  String get app_setting_security_lock_title_1 => '设置密码';

  @override
  String get app_setting_security_lock_title_2 => '再次输入确认密码';

  @override
  String get app_setting_security_lock_cancel => '关闭';

  @override
  String get app_setting_security_lock_resetinput => '重新输入';

  @override
  String get app_setting_security_lock_error_1 => '两次密码不一致';

  @override
  String get app_setting_security_lock_screen_title => '输入密码解锁';

  @override
  String get app_setting_security_localauth_localizedreason => '请进行识别';

  @override
  String get app_setting_security_localauth_signIntitle => '身份认证';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失败多次，请稍后重试';

  @override
  String get app_setting_theme => '主题';

  @override
  String get app_setting_theme_appearance => '主题外观';

  @override
  String get app_setting_theme_appearance_system => '跟随系统';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主题';

  @override
  String get app_setting_language => '语言';

  @override
  String get app_setting_language_system => '跟随系统';

  @override
  String get app_setting_laboratory => '实验室';

  @override
  String get app_setting_about => '关于';

  @override
  String get onboarding_title_1 => '管理思绪';

  @override
  String get onboarding_content_1_1 => '释放你的所有心情';

  @override
  String get onboarding_content_1_2 => '轻松记录你每刻的所见所想';

  @override
  String get onboarding_title_2 => '精心统计';

  @override
  String get onboarding_content_2_1 => '统计你的喜怒哀乐';

  @override
  String get onboarding_content_2_2 => '让你了解自己心理活动状况';

  @override
  String get onboarding_title_3 => '即刻开始';

  @override
  String get onboarding_content_3_1 => '从现在开始记录更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '现在感觉如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用场景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '功能';

  @override
  String get home_help_article_title_1 => '心理助手';

  @override
  String get home_help_article_content_1 => '了解你心情的chat-gpt...';

  @override
  String get home_help_article_title_2 => '番茄钟';

  @override
  String get home_help_article_content_2 => '对专注说不定有用...';

  @override
  String get home_help_article_title_3 => '待办事项';

  @override
  String get home_help_article_content_3 => '记录并提醒您的截止日期……';

  @override
  String get home_help_article_title_4 => '深呼吸';

  @override
  String get home_help_article_content_4 => '科学的深呼吸练习...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '记录';

  @override
  String get mood_data_delete_button_title => '确认删除？';

  @override
  String get mood_data_delete_button_content => '删除后无法恢复';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '删除';

  @override
  String get mood_data_content_empty => '什么都没有说';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '现在感觉如何';

  @override
  String get mood_category_select_title_2 => '换一种心情？';

  @override
  String get mood_content_hintText => '跟我说说，发生什么事情？';

  @override
  String get mood_content_close_button_title => '确认关闭？';

  @override
  String get mood_content_close_button_content => '内容不会保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '确认';

  @override
  String get statistic_title => '统计';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累计记录天数';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 条';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累计记录心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波动';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日计算情绪波动';
  }

  @override
  String get statistic_moodScore_title => '情绪波动';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情绪波动';
  }

  @override
  String get statistic_moodStatistics_title => '心情统计';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情数量统计';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加载中';

  @override
  String get local_notification_welcome_title => '👋 欢迎来到这里';

  @override
  String get local_notification_welcome_body => '进入给你发送一条通知，证明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知权限';

  @override
  String get local_notification_dialog_allow_content => '打开权限后通知才会生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往设置';

  @override
  String get local_notification_schedule_title => '📅 定时计划通知';

  @override
  String get local_notification_schedule_body => '每1分钟你将看见此通知';

  @override
  String get ai_title => '心理助手';

  @override
  String get ai_input_hint => '请输入你的问题或消息...';

  @override
  String get ai_stop_tooltip => '停止';

  @override
  String get ai_sending_text => 'AI 正在输入...';

  @override
  String get ai_apiKey_missing_title => 'API Key 未配置';

  @override
  String get ai_apiKey_missing_message => '请在项目根目录创建 .env 并添加 DEEPSEEK_KEY=<your_key>，然后重启应用。';

  @override
  String get ai_ok => '知道了';

  @override
  String get pomodoro_mode_work_title => '工作模式';

  @override
  String get pomodoro_mode_break_title => '休息模式';

  @override
  String get pomodoro_completed_label => '已完成的番茄钟';

  @override
  String get pomodoro_snack_work_end => '休息时间结束——回到工作吧！';

  @override
  String get pomodoro_snack_break_end => '工作时间结束——休息一下吧！';

  @override
  String get pomodoro_reset_tooltip => '重置';

  @override
  String get pomodoro_toggle_tooltip => '切换模式';

  @override
  String get todo_app_title => '待办事项应用';

  @override
  String get todo_list_title => '待办事项';

  @override
  String get todo_confirm_delete_title => '确认删除';

  @override
  String get todo_confirm_delete_content => '确定要删除该待办事项吗？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get add_todo => '添加待办事项';

  @override
  String get start_time => '开始时间';

  @override
  String get end_time => '结束时间';

  @override
  String get priority => '优先级';

  @override
  String get high => '高';

  @override
  String get medium => '中';

  @override
  String get low => '低';

  @override
  String get unknown => '未知';

  @override
  String get title => '标题';

  @override
  String get content => '内容';

  @override
  String get select_start_date => '选择开始日期';

  @override
  String get select_end_date => '选择结束日期';

  @override
  String get confirm => '确认';

  @override
  String get save_todo => '保存待办事项';

  @override
  String get update_todo => '更新待办事项';

  @override
  String get todo_title_required => '标题不能为空';

  @override
  String get todo_end_time_invalid => '结束时间必须晚于开始时间';

  @override
  String get edit_todo => '编辑待办事项';

  @override
  String get breathing_app_title => '呼吸练习';

  @override
  String get breathing_title => '呼吸练习';

  @override
  String get breathing_ready => '准备开始';

  @override
  String get breathing_instruction_start => '点击开始按钮进行4-7-8呼吸练习';

  @override
  String get breathing_method_478 => '4-7-8 呼吸法';

  @override
  String get breathing_method_description => '吸气4秒，屏息7秒，呼气8秒';

  @override
  String get breathing_method_benefit => '这种方法可以帮助平静神经系统，减少焦虑';

  @override
  String get breathing_inhale => '吸气';

  @override
  String get breathing_hold => '屏息';

  @override
  String get breathing_exhale => '呼气';

  @override
  String get breathing_instruction_inhale => '通过鼻子缓慢吸气... 4秒';

  @override
  String breathing_instruction_hold(int seconds) {
    return '屏住呼吸... $seconds秒';
  }

  @override
  String breathing_instruction_exhale(int seconds) {
    return '通过嘴巴缓慢呼气... $seconds秒';
  }

  @override
  String get breathing_paused => '已暂停';

  @override
  String get breathing_completed_cycles => '完成周期';

  @override
  String get start_exercise => '开始练习';

  @override
  String get stats => '统计信息';

  @override
  String get total_seconds => '总秒数';

  @override
  String get pause => '暂停';

  @override
  String get reset => '重置';

  @override
  String get todo_notify_before_hours => '提前提醒(小时)';

  @override
  String get todo_notify_before_minutes => '提前提醒(分钟)';

  @override
  String get todo_notify_time_invalid => '提醒时间不合法';

  @override
  String get daily_sentences => '每日一句';

  @override
  String get tilt_card_message_0 => '坚持前行，小步亦能成就大事！';

  @override
  String get tilt_card_message_1 => '每天一小步，离目标更近一点。';

  @override
  String get tilt_card_message_2 => '让今天变得有意义——从现在开始。';

  @override
  String get tilt_card_message_3 => '哪怕微小的进步，依然是进步。';

  @override
  String get tilt_card_message_4 => '深呼吸，专注向前。';

  @override
  String get tilt_card_message_5 => '一点一滴的坚持，成就你的未来。';

  @override
  String get tilt_card_message_6 => '小小的胜利会汇聚成巨大改变。';

  @override
  String get tilt_card_message_7 => '从你所在之处开始，利用你拥有的。';

  @override
  String get tilt_card_message_8 => '追求进步，而非完美。';

  @override
  String get tilt_card_message_9 => '为未来的自己行动。';

  @override
  String get tilt_card_message_10 => '平静的心才能带来清晰的行动。';

  @override
  String get tilt_card_message_11 => '为今天的微小胜利庆祝。';

  @override
  String get tilt_touch_and_move => '摇晃手机试试';

  @override
  String get mood_category_happy => '开心';

  @override
  String get mood_category_surprised => '惊喜';

  @override
  String get mood_category_funny => '滑稽';

  @override
  String get mood_category_embarrassed => '尴尬';

  @override
  String get mood_category_sad => '伤心';

  @override
  String get mood_category_shocked => '惊讶';

  @override
  String get mood_category_admire => '崇拜';

  @override
  String get mood_category_angry => '生气';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppL10nZhCn extends AppL10nZh {
  AppL10nZhCn() : super('zh_CN');

  @override
  String get app_bottomNavigationBar_title_home => '首页';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '统计';

  @override
  String get app_setting_database => '数据';

  @override
  String get app_setting_database_export_data => '导出数据';

  @override
  String get app_setting_database_export_data_toast_success => '导出成功';

  @override
  String get app_setting_database_import_data => '导入数据';

  @override
  String get app_setting_database_import_data_button_error => '错误';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '导入失败，请下载错误数据，修改后再试。';

  @override
  String get app_setting_database_import_data_toast_success => '导入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打开应用时需要进行解锁。';

  @override
  String get app_setting_security_lock => '密码锁';

  @override
  String get app_setting_security_biometric_weak => '指纹、面部等识别';

  @override
  String get app_setting_security_biometric_iris => '虹膜识别';

  @override
  String get app_setting_security_biometric_face => '面部识别';

  @override
  String get app_setting_security_biometric_fingerprint => '指纹识别';

  @override
  String get app_setting_security_lock_title_1 => '设置密码';

  @override
  String get app_setting_security_lock_title_2 => '再次输入确认密码';

  @override
  String get app_setting_security_lock_cancel => '关闭';

  @override
  String get app_setting_security_lock_resetinput => '重新输入';

  @override
  String get app_setting_security_lock_error_1 => '两次密码不一致';

  @override
  String get app_setting_security_lock_screen_title => '输入密码解锁';

  @override
  String get app_setting_security_localauth_localizedreason => '请进行识别';

  @override
  String get app_setting_security_localauth_signIntitle => '身份认证';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失败多次，请稍后重试';

  @override
  String get app_setting_theme => '主题';

  @override
  String get app_setting_theme_appearance => '主题外观';

  @override
  String get app_setting_theme_appearance_system => '跟随系统';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主题';

  @override
  String get app_setting_language => '语言';

  @override
  String get app_setting_language_system => '跟随系统';

  @override
  String get app_setting_laboratory => '实验室';

  @override
  String get app_setting_about => '关于';

  @override
  String get onboarding_title_1 => '管理思绪';

  @override
  String get onboarding_content_1_1 => '释放你的所有心情';

  @override
  String get onboarding_content_1_2 => '轻松记录你每刻的所见所想';

  @override
  String get onboarding_title_2 => '精心统计';

  @override
  String get onboarding_content_2_1 => '统计你的喜怒哀乐';

  @override
  String get onboarding_content_2_2 => '让你了解自己心理活动状况';

  @override
  String get onboarding_title_3 => '即刻开始';

  @override
  String get onboarding_content_3_1 => '从现在开始记录更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '现在感觉如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用场景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '功能';

  @override
  String get home_help_article_title_1 => '心理助手';

  @override
  String get home_help_article_content_1 => '了解你心情的chat-gpt...';

  @override
  String get home_help_article_title_2 => '番茄钟';

  @override
  String get home_help_article_content_2 => '对专注说不定有用...';

  @override
  String get home_help_article_title_3 => '待办事项';

  @override
  String get home_help_article_content_3 => '记录并提醒您的截止日期……';

  @override
  String get home_help_article_title_4 => '深呼吸';

  @override
  String get home_help_article_content_4 => '科学的深呼吸练习...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '记录';

  @override
  String get mood_data_delete_button_title => '确认删除？';

  @override
  String get mood_data_delete_button_content => '删除后无法恢复';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '删除';

  @override
  String get mood_data_content_empty => '什么都没有说';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '现在感觉如何';

  @override
  String get mood_category_select_title_2 => '换一种心情？';

  @override
  String get mood_content_hintText => '跟我说说，发生什么事情？';

  @override
  String get mood_content_close_button_title => '确认关闭？';

  @override
  String get mood_content_close_button_content => '内容不会保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '确认';

  @override
  String get statistic_title => '统计';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累计记录天数';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 条';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累计记录心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波动';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日计算情绪波动';
  }

  @override
  String get statistic_moodScore_title => '情绪波动';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情绪波动';
  }

  @override
  String get statistic_moodStatistics_title => '心情统计';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情数量统计';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加载中';

  @override
  String get local_notification_welcome_title => '👋 欢迎来到这里';

  @override
  String get local_notification_welcome_body => '进入给你发送一条通知，证明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知权限';

  @override
  String get local_notification_dialog_allow_content => '打开权限后通知才会生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往设置';

  @override
  String get local_notification_schedule_title => '📅 定时计划通知';

  @override
  String get local_notification_schedule_body => '每1分钟你将看见此通知';

  @override
  String get ai_title => '心理助手';

  @override
  String get ai_input_hint => '请输入你的问题或消息...';

  @override
  String get ai_stop_tooltip => '停止';

  @override
  String get ai_sending_text => 'AI 正在输入...';

  @override
  String get ai_apiKey_missing_title => 'API Key 未配置';

  @override
  String get ai_apiKey_missing_message => '请在项目根目录创建 .env 并添加 DEEPSEEK_KEY=<your_key>，然后重启应用。';

  @override
  String get ai_ok => '知道了';

  @override
  String get pomodoro_mode_work_title => '工作模式';

  @override
  String get pomodoro_mode_break_title => '休息模式';

  @override
  String get pomodoro_completed_label => '已完成的番茄钟';

  @override
  String get pomodoro_snack_work_end => '休息时间结束——回到工作吧！';

  @override
  String get pomodoro_snack_break_end => '工作时间结束——休息一下吧！';

  @override
  String get pomodoro_reset_tooltip => '重置';

  @override
  String get pomodoro_toggle_tooltip => '切换模式';

  @override
  String get todo_app_title => '待办事项应用';

  @override
  String get todo_list_title => '待办事项';

  @override
  String get todo_confirm_delete_title => '确认删除';

  @override
  String get todo_confirm_delete_content => '确定要删除该待办事项吗？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get add_todo => '添加待办事项';

  @override
  String get start_time => '开始时间';

  @override
  String get end_time => '结束时间';

  @override
  String get priority => '优先级';

  @override
  String get high => '高';

  @override
  String get medium => '中';

  @override
  String get low => '低';

  @override
  String get unknown => '未知';

  @override
  String get title => '标题';

  @override
  String get content => '内容';

  @override
  String get select_start_date => '选择开始日期';

  @override
  String get select_end_date => '选择结束日期';

  @override
  String get confirm => '确认';

  @override
  String get save_todo => '保存待办事项';

  @override
  String get update_todo => '更新待办事项';

  @override
  String get todo_title_required => '标题不能为空';

  @override
  String get todo_end_time_invalid => '结束时间必须晚于开始时间';

  @override
  String get edit_todo => '编辑待办事项';

  @override
  String get breathing_app_title => '呼吸练习';

  @override
  String get breathing_title => '呼吸练习';

  @override
  String get breathing_ready => '准备开始';

  @override
  String get breathing_instruction_start => '点击开始按钮进行4-7-8呼吸练习';

  @override
  String get breathing_method_478 => '4-7-8 呼吸法';

  @override
  String get breathing_method_description => '吸气4秒，屏息7秒，呼气8秒';

  @override
  String get breathing_method_benefit => '这种方法可以帮助平静神经系统，减少焦虑';

  @override
  String get breathing_inhale => '吸气';

  @override
  String get breathing_hold => '屏息';

  @override
  String get breathing_exhale => '呼气';

  @override
  String get breathing_instruction_inhale => '通过鼻子缓慢吸气... 4秒';

  @override
  String breathing_instruction_hold(int seconds) {
    return '屏住呼吸... $seconds秒';
  }

  @override
  String breathing_instruction_exhale(int seconds) {
    return '通过嘴巴缓慢呼气... $seconds秒';
  }

  @override
  String get breathing_paused => '已暂停';

  @override
  String get breathing_completed_cycles => '完成周期';

  @override
  String get start_exercise => '开始练习';

  @override
  String get stats => '统计信息';

  @override
  String get total_seconds => '总秒数';

  @override
  String get pause => '暂停';

  @override
  String get reset => '重置';

  @override
  String get todo_notify_before_hours => '提前提醒(小时)';

  @override
  String get todo_notify_before_minutes => '提前提醒(分钟)';

  @override
  String get todo_notify_time_invalid => '提醒时间不合法';

  @override
  String get daily_sentences => '每日一句';

  @override
  String get tilt_card_message_0 => '坚持前行，小步亦能成就大事！';

  @override
  String get tilt_card_message_1 => '每天一小步，离目标更近一点。';

  @override
  String get tilt_card_message_2 => '让今天变得有意义——从现在开始。';

  @override
  String get tilt_card_message_3 => '哪怕微小的进步，依然是进步。';

  @override
  String get tilt_card_message_4 => '深呼吸，专注向前。';

  @override
  String get tilt_card_message_5 => '一点一滴的坚持，成就你的未来。';

  @override
  String get tilt_card_message_6 => '小小的胜利会汇聚成巨大改变。';

  @override
  String get tilt_card_message_7 => '从你所在之处开始，利用你拥有的。';

  @override
  String get tilt_card_message_8 => '追求进步，而非完美。';

  @override
  String get tilt_card_message_9 => '为未来的自己行动。';

  @override
  String get tilt_card_message_10 => '平静的心才能带来清晰的行动。';

  @override
  String get tilt_card_message_11 => '为今天的微小胜利庆祝。';

  @override
  String get tilt_touch_and_move => '摇晃手机试试';

  @override
  String get mood_category_happy => '开心';

  @override
  String get mood_category_surprised => '惊喜';

  @override
  String get mood_category_funny => '滑稽';

  @override
  String get mood_category_embarrassed => '尴尬';

  @override
  String get mood_category_sad => '伤心';

  @override
  String get mood_category_shocked => '惊讶';

  @override
  String get mood_category_admire => '崇拜';

  @override
  String get mood_category_angry => '生气';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppL10nZhHk extends AppL10nZh {
  AppL10nZhHk() : super('zh_HK');

  @override
  String get app_bottomNavigationBar_title_home => '首頁';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '統計';

  @override
  String get app_setting_database => '數據';

  @override
  String get app_setting_database_export_data => '導出數據';

  @override
  String get app_setting_database_export_data_toast_success => '導出成功';

  @override
  String get app_setting_database_import_data => '導入數據';

  @override
  String get app_setting_database_import_data_button_error => '錯誤';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '導入失敗，請下載錯誤數據，修改後再試。';

  @override
  String get app_setting_database_import_data_toast_success => '導入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打開應用時需要進行解鎖。';

  @override
  String get app_setting_security_lock => '密碼鎖';

  @override
  String get app_setting_security_biometric_weak => '指紋、面部等識別';

  @override
  String get app_setting_security_biometric_iris => '虹膜識別';

  @override
  String get app_setting_security_biometric_face => '面部識別';

  @override
  String get app_setting_security_biometric_fingerprint => '指紋識別';

  @override
  String get app_setting_security_lock_title_1 => '設置密碼';

  @override
  String get app_setting_security_lock_title_2 => '再次輸入確認密碼';

  @override
  String get app_setting_security_lock_cancel => '關閉';

  @override
  String get app_setting_security_lock_resetinput => '重新輸入';

  @override
  String get app_setting_security_lock_error_1 => '兩次密碼不一致';

  @override
  String get app_setting_security_lock_screen_title => '輸入密碼解鎖';

  @override
  String get app_setting_security_localauth_localizedreason => '請進行識別';

  @override
  String get app_setting_security_localauth_signIntitle => '身份認證';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失敗多次，請稍後重試';

  @override
  String get app_setting_theme => '主題';

  @override
  String get app_setting_theme_appearance => '主題外觀';

  @override
  String get app_setting_theme_appearance_system => '跟隨系統';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主題';

  @override
  String get app_setting_language => '語言';

  @override
  String get app_setting_language_system => '跟隨系統';

  @override
  String get app_setting_laboratory => '實驗室';

  @override
  String get app_setting_about => '關於';

  @override
  String get onboarding_title_1 => '管理思緒';

  @override
  String get onboarding_content_1_1 => '釋放你的所有心情';

  @override
  String get onboarding_content_1_2 => '輕鬆記錄你每刻的所見所想';

  @override
  String get onboarding_title_2 => '精心統計';

  @override
  String get onboarding_content_2_1 => '統計你的喜怒哀樂';

  @override
  String get onboarding_content_2_2 => '讓你了解自己心理活動狀況';

  @override
  String get onboarding_title_3 => '即刻開始';

  @override
  String get onboarding_content_3_1 => '從現在開始記錄更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '現在感覺如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用場景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '功能';

  @override
  String get home_help_article_title_1 => '心理助手';

  @override
  String get home_help_article_content_1 => '了解你心情的chat-gpt...';

  @override
  String get home_help_article_title_2 => '番茄鐘';

  @override
  String get home_help_article_content_2 => '對專注說不定有用...';

  @override
  String get home_help_article_title_3 => '待辦事項';

  @override
  String get home_help_article_content_3 => '記錄並提醒您的截止日期……';

  @override
  String get home_help_article_title_4 => '深呼吸';

  @override
  String get home_help_article_content_4 => '科學的深呼吸練習...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '記錄';

  @override
  String get mood_data_delete_button_title => '確認刪除？';

  @override
  String get mood_data_delete_button_content => '刪除後無法恢復';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '刪除';

  @override
  String get mood_data_content_empty => '什麼都沒有說';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '現在感覺如何';

  @override
  String get mood_category_select_title_2 => '換一種心情？';

  @override
  String get mood_content_hintText => '跟我說說，發生什麼事情？';

  @override
  String get mood_content_close_button_title => '確認關閉？';

  @override
  String get mood_content_close_button_content => '內容不會保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '確認';

  @override
  String get statistic_title => '統計';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累計記錄天數';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 條';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累計記錄心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波動';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日計算情緒波動';
  }

  @override
  String get statistic_moodScore_title => '情緒波動';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情緒波動';
  }

  @override
  String get statistic_moodStatistics_title => '心情統計';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情數量統計';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加載中';

  @override
  String get local_notification_welcome_title => '👋 歡迎來到這裏';

  @override
  String get local_notification_welcome_body => '進入給你發送一條通知，證明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知權限';

  @override
  String get local_notification_dialog_allow_content => '打開權限後通知才會生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往設置';

  @override
  String get local_notification_schedule_title => '📅 定時計劃通知';

  @override
  String get local_notification_schedule_body => '每1分鐘你將看見此通知';

  @override
  String get ai_title => '心理助手';

  @override
  String get ai_input_hint => '請輸入你的問題或訊息...';

  @override
  String get ai_stop_tooltip => '停止';

  @override
  String get ai_sending_text => 'AI 正在輸入...';

  @override
  String get ai_apiKey_missing_title => '未設定 API Key';

  @override
  String get ai_apiKey_missing_message => '請在專案根目錄建立 .env，並加入 DEEPSEEK_KEY=<your_key>，然後重新啟動應用程式。';

  @override
  String get ai_ok => '知道了';

  @override
  String get pomodoro_mode_work_title => '工作模式';

  @override
  String get pomodoro_mode_break_title => '休息模式';

  @override
  String get pomodoro_completed_label => '已完成的番茄鐘';

  @override
  String get pomodoro_snack_work_end => '休息時間結束——回到工作吧！';

  @override
  String get pomodoro_snack_break_end => '工作時間結束——休息一下吧！';

  @override
  String get pomodoro_reset_tooltip => '重置';

  @override
  String get pomodoro_toggle_tooltip => '切換模式';

  @override
  String get todo_app_title => '待辦事項應用';

  @override
  String get todo_list_title => '待辦事項';

  @override
  String get todo_confirm_delete_title => '確認刪除';

  @override
  String get todo_confirm_delete_content => '確定要刪除該待辦事項嗎？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get edit => '編輯';

  @override
  String get add_todo => '新增待辦事項';

  @override
  String get start_time => '開始時間';

  @override
  String get end_time => '結束時間';

  @override
  String get priority => '優先級';

  @override
  String get high => '高';

  @override
  String get medium => '中';

  @override
  String get low => '低';

  @override
  String get unknown => '未知';

  @override
  String get title => '標題';

  @override
  String get content => '內容';

  @override
  String get select_start_date => '選擇開始日期';

  @override
  String get select_end_date => '選擇結束日期';

  @override
  String get confirm => '確認';

  @override
  String get save_todo => '儲存待辦事項';

  @override
  String get update_todo => '更新待辦事項';

  @override
  String get todo_title_required => '標題不能為空';

  @override
  String get todo_end_time_invalid => '結束時間必須晚於開始時間';

  @override
  String get edit_todo => '編輯待辦事項';

  @override
  String get breathing_app_title => '呼吸練習';

  @override
  String get breathing_title => '呼吸練習';

  @override
  String get breathing_ready => '準備開始';

  @override
  String get breathing_instruction_start => '點擊開始按鈕進行4-7-8呼吸練習';

  @override
  String get breathing_method_478 => '4-7-8 呼吸法';

  @override
  String get breathing_method_description => '吸氣4秒，屏息7秒，呼氣8秒';

  @override
  String get breathing_method_benefit => '這種方法可以幫助平靜神經系統，減少焦慮';

  @override
  String get breathing_inhale => '吸氣';

  @override
  String get breathing_hold => '屏息';

  @override
  String get breathing_exhale => '呼氣';

  @override
  String get breathing_instruction_inhale => '通過鼻子緩慢吸氣... 4秒';

  @override
  String breathing_instruction_hold(int seconds) {
    return '屏住呼吸... $seconds秒';
  }

  @override
  String breathing_instruction_exhale(int seconds) {
    return '通過嘴巴緩慢呼氣... $seconds秒';
  }

  @override
  String get breathing_paused => '已暫停';

  @override
  String get breathing_completed_cycles => '完成週期';

  @override
  String get start_exercise => '開始練習';

  @override
  String get stats => '統計資訊';

  @override
  String get total_seconds => '總秒數';

  @override
  String get pause => '暫停';

  @override
  String get reset => '重置';

  @override
  String get todo_notify_before_hours => '提前提醒(小時)';

  @override
  String get todo_notify_before_minutes => '提前提醒(分鐘)';

  @override
  String get todo_notify_time_invalid => '提醒時間不合法';

  @override
  String get daily_sentences => '每日一句';

  @override
  String get tilt_card_message_0 => '堅持前行，小步亦能成就大事！';

  @override
  String get tilt_card_message_1 => '每天一小步，離目標更近一點。';

  @override
  String get tilt_card_message_2 => '讓今天變得有意義—從現在開始。';

  @override
  String get tilt_card_message_3 => '哪怕微小的進步，依然是進步。';

  @override
  String get tilt_card_message_4 => '深呼吸，專注向前。';

  @override
  String get tilt_card_message_5 => '一點一滴的堅持，成就你的未來。';

  @override
  String get tilt_card_message_6 => '小小的勝利會匯聚成巨大改變。';

  @override
  String get tilt_card_message_7 => '從你所在之處開始，利用你擁有的。';

  @override
  String get tilt_card_message_8 => '追求進步，而非完美。';

  @override
  String get tilt_card_message_9 => '為未來的自己行動。';

  @override
  String get tilt_card_message_10 => '平靜的心才能帶來清晰的行動。';

  @override
  String get tilt_card_message_11 => '為今天的微小勝利慶祝。';

  @override
  String get tilt_touch_and_move => '觸摸並四處移動';

  @override
  String get mood_category_happy => '開心';

  @override
  String get mood_category_surprised => '驚喜';

  @override
  String get mood_category_funny => '滑稽';

  @override
  String get mood_category_embarrassed => '尷尬';

  @override
  String get mood_category_sad => '傷心';

  @override
  String get mood_category_shocked => '驚訝';

  @override
  String get mood_category_admire => '崇拜';

  @override
  String get mood_category_angry => '生氣';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppL10nZhTw extends AppL10nZh {
  AppL10nZhTw() : super('zh_TW');

  @override
  String get app_bottomNavigationBar_title_home => '首頁';

  @override
  String get app_bottomNavigationBar_title_mood => '心情';

  @override
  String get app_bottomNavigationBar_title_statistic => '統計';

  @override
  String get app_setting_database => '數據';

  @override
  String get app_setting_database_export_data => '導出數據';

  @override
  String get app_setting_database_export_data_toast_success => '導出成功';

  @override
  String get app_setting_database_import_data => '導入數據';

  @override
  String get app_setting_database_import_data_button_error => '錯誤';

  @override
  String get app_setting_database_import_data_button_template => '模板';

  @override
  String get app_setting_database_import_data_toast_error => '導入失敗，請下載錯誤數據，修改後再試。';

  @override
  String get app_setting_database_import_data_toast_success => '導入成功';

  @override
  String get app_setting_security => '安全';

  @override
  String get app_setting_security_content => '重新打開應用時需要進行解鎖。';

  @override
  String get app_setting_security_lock => '密碼鎖';

  @override
  String get app_setting_security_biometric_weak => '指紋、面部等識別';

  @override
  String get app_setting_security_biometric_iris => '虹膜識別';

  @override
  String get app_setting_security_biometric_face => '面部識別';

  @override
  String get app_setting_security_biometric_fingerprint => '指紋識別';

  @override
  String get app_setting_security_lock_title_1 => '設置密碼';

  @override
  String get app_setting_security_lock_title_2 => '再次輸入確認密碼';

  @override
  String get app_setting_security_lock_cancel => '關閉';

  @override
  String get app_setting_security_lock_resetinput => '重新輸入';

  @override
  String get app_setting_security_lock_error_1 => '兩次密碼不一致';

  @override
  String get app_setting_security_lock_screen_title => '輸入密碼解鎖';

  @override
  String get app_setting_security_localauth_localizedreason => '請進行識別';

  @override
  String get app_setting_security_localauth_signIntitle => '身份認證';

  @override
  String get app_setting_security_localauth_cancel => '取消';

  @override
  String get app_setting_security_localauth_error_1 => '失敗多次，請稍後重試';

  @override
  String get app_setting_theme => '主題';

  @override
  String get app_setting_theme_appearance => '主題外觀';

  @override
  String get app_setting_theme_appearance_system => '跟隨系統';

  @override
  String get app_setting_theme_appearance_light => '普通模式';

  @override
  String get app_setting_theme_appearance_dark => '深色模式';

  @override
  String get app_setting_theme_themes => '多主題';

  @override
  String get app_setting_language => '語言';

  @override
  String get app_setting_language_system => '跟隨系統';

  @override
  String get app_setting_laboratory => '實驗室';

  @override
  String get app_setting_about => '關於';

  @override
  String get onboarding_title_1 => '管理思緒';

  @override
  String get onboarding_content_1_1 => '釋放你的所有心情';

  @override
  String get onboarding_content_1_2 => '輕鬆記錄你每刻的所見所想';

  @override
  String get onboarding_title_2 => '精心統計';

  @override
  String get onboarding_content_2_1 => '統計你的喜怒哀樂';

  @override
  String get onboarding_content_2_2 => '讓你了解自己心理活動狀況';

  @override
  String get onboarding_title_3 => '即刻開始';

  @override
  String get onboarding_content_3_1 => '從現在開始記錄更好的自己';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => '現在感覺如何';

  @override
  String get home_upgrade_title => '功能更新';

  @override
  String get home_upgrade_content => '了解最新使用場景';

  @override
  String get home_upgrade_button => '查看';

  @override
  String get home_help_title => '功能';

  @override
  String get home_help_article_title_1 => '心理助手';

  @override
  String get home_help_article_content_1 => '了解你心情的chat-gpt...';

  @override
  String get home_help_article_title_2 => '番茄鐘';

  @override
  String get home_help_article_content_2 => '對專注說不定有用...';

  @override
  String get home_help_article_title_3 => '待辦事項';

  @override
  String get home_help_article_content_3 => '記錄並提醒您的截止日期……';

  @override
  String get home_help_article_title_4 => '深呼吸';

  @override
  String get home_help_article_content_4 => '科學的深呼吸練習...';

  @override
  String get mood_title => '心情';

  @override
  String get mood_add_button => '記錄';

  @override
  String get mood_data_delete_button_title => '確認刪除？';

  @override
  String get mood_data_delete_button_content => '刪除後無法恢復';

  @override
  String get mood_data_delete_button_cancel => '取消';

  @override
  String get mood_data_delete_button_confirm => '刪除';

  @override
  String get mood_data_content_empty => '什麼都沒有說';

  @override
  String get mood_data_score_title => '心情程度';

  @override
  String get mood_category_select_title_1 => '現在感覺如何';

  @override
  String get mood_category_select_title_2 => '換一種心情？';

  @override
  String get mood_content_hintText => '跟我說說，發生什麼事情？';

  @override
  String get mood_content_close_button_title => '確認關閉？';

  @override
  String get mood_content_close_button_content => '內容不會保存';

  @override
  String get mood_content_close_button_cancel => '取消';

  @override
  String get mood_content_close_button_confirm => '確認';

  @override
  String get statistic_title => '統計';

  @override
  String get statistic_filter_7d => '7天';

  @override
  String get statistic_filter_15d => '15天';

  @override
  String get statistic_filter_30d => '30天';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount 天';
  }

  @override
  String get statistic_overall_daysCount_subTitle => '累計記錄天數';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount 條';
  }

  @override
  String get statistic_overall_moodCount_subTitle => '累計記錄心情';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => '平均全部波動';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return '平均 $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return '按 $moodDays 日計算情緒波動';
  }

  @override
  String get statistic_moodScore_title => '情緒波動';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return '近 $moodDays 日情緒波動';
  }

  @override
  String get statistic_moodStatistics_title => '心情統計';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return '近 $moodDays 日心情數量統計';
  }

  @override
  String get widgets_will_pop_scope_route_toast => '再按一次退出';

  @override
  String get web_view_loading_text => '加載中';

  @override
  String get local_notification_welcome_title => '👋 歡迎來到這裡';

  @override
  String get local_notification_welcome_body => '進入給你發送一條通知，證明通知已初始化。';

  @override
  String get local_notification_dialog_allow_title => '通知權限';

  @override
  String get local_notification_dialog_allow_content => '打開權限後通知才會生效';

  @override
  String get local_notification_dialog_allow_cancel => '取消';

  @override
  String get local_notification_dialog_allow_confirm => '前往設置';

  @override
  String get local_notification_schedule_title => '📅 定時計劃通知';

  @override
  String get local_notification_schedule_body => '每1分鐘你將看見此通知';

  @override
  String get ai_title => '心理助手';

  @override
  String get ai_input_hint => '請輸入你的問題或訊息...';

  @override
  String get ai_stop_tooltip => '停止';

  @override
  String get ai_sending_text => 'AI 正在輸入...';

  @override
  String get ai_apiKey_missing_title => '尚未設定 API 金鑰';

  @override
  String get ai_apiKey_missing_message => '請在專案根目錄建立 .env，並新增 DEEPSEEK_KEY=<your_key>，然後重新啟動應用程式。';

  @override
  String get ai_ok => '知道了';

  @override
  String get pomodoro_mode_work_title => '工作模式';

  @override
  String get pomodoro_mode_break_title => '休息模式';

  @override
  String get pomodoro_completed_label => '已完成的番茄鐘';

  @override
  String get pomodoro_snack_work_end => '休息時間結束——回到工作吧！';

  @override
  String get pomodoro_snack_break_end => '工作時間結束——休息一下吧！';

  @override
  String get pomodoro_reset_tooltip => '重置';

  @override
  String get pomodoro_toggle_tooltip => '切換模式';

  @override
  String get todo_app_title => '待辦事項應用';

  @override
  String get todo_list_title => '待辦事項';

  @override
  String get todo_confirm_delete_title => '確認刪除';

  @override
  String get todo_confirm_delete_content => '確定要刪除該待辦事項嗎？';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get edit => '編輯';

  @override
  String get add_todo => '新增待辦事項';

  @override
  String get start_time => '開始時間';

  @override
  String get end_time => '結束時間';

  @override
  String get priority => '優先級';

  @override
  String get high => '高';

  @override
  String get medium => '中';

  @override
  String get low => '低';

  @override
  String get unknown => '未知';

  @override
  String get title => '標題';

  @override
  String get content => '內容';

  @override
  String get select_start_date => '選擇開始日期';

  @override
  String get select_end_date => '選擇結束日期';

  @override
  String get confirm => '確認';

  @override
  String get save_todo => '儲存待辦事項';

  @override
  String get update_todo => '更新待辦事項';

  @override
  String get todo_title_required => '標題不能為空';

  @override
  String get todo_end_time_invalid => '結束時間必須晚於開始時間';

  @override
  String get edit_todo => '編輯待辦事項';

  @override
  String get breathing_app_title => '呼吸練習';

  @override
  String get breathing_title => '呼吸練習';

  @override
  String get breathing_ready => '準備開始';

  @override
  String get breathing_instruction_start => '點擊開始按鈕進行4-7-8呼吸練習';

  @override
  String get breathing_method_478 => '4-7-8 呼吸法';

  @override
  String get breathing_method_description => '吸氣4秒，屏息7秒，呼氣8秒';

  @override
  String get breathing_method_benefit => '這種方法可以幫助平靜神經系統，減少焦慮';

  @override
  String get breathing_inhale => '吸氣';

  @override
  String get breathing_hold => '屏息';

  @override
  String get breathing_exhale => '呼氣';

  @override
  String get breathing_instruction_inhale => '通過鼻子緩慢吸氣... 4秒';

  @override
  String breathing_instruction_hold(int seconds) {
    return '屏住呼吸... $seconds秒';
  }

  @override
  String breathing_instruction_exhale(int seconds) {
    return '通過嘴巴緩慢呼氣... $seconds秒';
  }

  @override
  String get breathing_paused => '已暫停';

  @override
  String get breathing_completed_cycles => '完成週期';

  @override
  String get start_exercise => '開始練習';

  @override
  String get stats => '統計資訊';

  @override
  String get total_seconds => '總秒數';

  @override
  String get pause => '暫停';

  @override
  String get reset => '重置';

  @override
  String get todo_notify_before_hours => '提前提醒(小時)';

  @override
  String get todo_notify_before_minutes => '提前提醒(分鐘)';

  @override
  String get todo_notify_time_invalid => '提醒時間不合法';

  @override
  String get daily_sentences => '每日一句';

  @override
  String get tilt_card_message_0 => '堅持前行，小步亦能成就大事！';

  @override
  String get tilt_card_message_1 => '每天一小步，離目標更近一點。';

  @override
  String get tilt_card_message_2 => '讓今天變得有意義—從現在開始。';

  @override
  String get tilt_card_message_3 => '哪怕微小的進步，依然是進步。';

  @override
  String get tilt_card_message_4 => '深呼吸，專注向前。';

  @override
  String get tilt_card_message_5 => '一點一滴的堅持，成就你的未來。';

  @override
  String get tilt_card_message_6 => '小小的勝利會匯聚成巨大改變。';

  @override
  String get tilt_card_message_7 => '從你所在之處開始，利用你擁有的。';

  @override
  String get tilt_card_message_8 => '追求進步，而非完美。';

  @override
  String get tilt_card_message_9 => '為未來的自己行動。';

  @override
  String get tilt_card_message_10 => '平靜的心才能帶來清晰的行動。';

  @override
  String get tilt_card_message_11 => '為今天的微小勝利慶祝。';

  @override
  String get tilt_touch_and_move => '觸摸並四處移動';

  @override
  String get mood_category_happy => '開心';

  @override
  String get mood_category_surprised => '驚喜';

  @override
  String get mood_category_funny => '滑稽';

  @override
  String get mood_category_embarrassed => '尷尬';

  @override
  String get mood_category_sad => '傷心';

  @override
  String get mood_category_shocked => '驚訝';

  @override
  String get mood_category_admire => '崇拜';

  @override
  String get mood_category_angry => '生氣';
}
