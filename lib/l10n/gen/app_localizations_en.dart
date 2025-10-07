// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get app_bottomNavigationBar_title_home => 'Home';

  @override
  String get app_bottomNavigationBar_title_mood => 'Mood';

  @override
  String get app_bottomNavigationBar_title_statistic => 'Statistic';

  @override
  String get app_setting_database => 'Database';

  @override
  String get app_setting_database_export_data => 'Export data';

  @override
  String get app_setting_database_export_data_toast_success => 'Export succeeded';

  @override
  String get app_setting_database_import_data => 'Import data';

  @override
  String get app_setting_database_import_data_button_error => 'ERR';

  @override
  String get app_setting_database_import_data_button_template => 'TMPL';

  @override
  String get app_setting_database_import_data_toast_error =>
      'Import failed. Please download the wrong data, modify it and try again.';

  @override
  String get app_setting_database_import_data_toast_success => 'Import succeeded';

  @override
  String get app_setting_security => 'Security';

  @override
  String get app_setting_security_content => 'You need to unlock the app when you reopen it.';

  @override
  String get app_setting_security_lock => 'Security lock';

  @override
  String get app_setting_security_biometric_weak => 'TouchID / FaceID auth';

  @override
  String get app_setting_security_biometric_iris => 'Iris auth';

  @override
  String get app_setting_security_biometric_face => 'Face auth';

  @override
  String get app_setting_security_biometric_fingerprint => 'Fingerprint auth';

  @override
  String get app_setting_security_lock_title_1 => 'Set password';

  @override
  String get app_setting_security_lock_title_2 => 'Confirm password';

  @override
  String get app_setting_security_lock_cancel => 'Cancel';

  @override
  String get app_setting_security_lock_resetinput => 'Reset input';

  @override
  String get app_setting_security_lock_error_1 => 'The two passwords are inconsistent';

  @override
  String get app_setting_security_lock_screen_title => 'Security lock';

  @override
  String get app_setting_security_localauth_localizedreason => 'Please identify';

  @override
  String get app_setting_security_localauth_signIntitle => 'Authentication required';

  @override
  String get app_setting_security_localauth_cancel => 'Cancel';

  @override
  String get app_setting_security_localauth_error_1 =>
      'You have failed many times, please try again later';

  @override
  String get app_setting_theme => 'Theme';

  @override
  String get app_setting_theme_appearance => 'Appearance';

  @override
  String get app_setting_theme_appearance_system => 'System';

  @override
  String get app_setting_theme_appearance_light => 'Light';

  @override
  String get app_setting_theme_appearance_dark => 'Dark';

  @override
  String get app_setting_theme_themes => 'Themes';

  @override
  String get app_setting_language => 'Language';

  @override
  String get app_setting_language_system => 'System';

  @override
  String get app_setting_laboratory => 'Laboratory';

  @override
  String get app_setting_about => 'About';

  @override
  String get onboarding_title_1 => 'Managing thoughts';

  @override
  String get onboarding_content_1_1 => 'Release all your feelings';

  @override
  String get onboarding_content_1_2 => 'Easily record what you see and think every moment';

  @override
  String get onboarding_title_2 => 'Careful statistics';

  @override
  String get onboarding_content_2_1 => 'Count your joys and sorrows';

  @override
  String get onboarding_content_2_2 => 'Let you know your mental activity';

  @override
  String get onboarding_title_3 => 'Start now';

  @override
  String get onboarding_content_3_1 => 'Start recording a better version of yourself now';

  @override
  String get home_hi => 'Hi~';

  @override
  String get home_moodChoice_title => 'How are you feeling now';

  @override
  String get home_upgrade_title => 'Upgrade';

  @override
  String get home_upgrade_content => 'Learn the latest\nusage scenarios';

  @override
  String get home_upgrade_button => 'Read';

  @override
  String get home_help_title => 'Functions';

  @override
  String get home_help_article_title_1 => 'Psychological Assistant';

  @override
  String get home_help_article_content_1 => 'A ChatGPT that understands your mood...';

  @override
  String get home_help_article_title_2 => 'Pomodoro Timer';

  @override
  String get home_help_article_content_2 => 'Might be useful for focus...';

  @override
  String get home_help_article_title_3 => 'ToDo';

  @override
  String get home_help_article_content_3 => 'record and remind your deadline...';

  @override
  String get home_help_article_title_4 => 'Deep Breathing';

  @override
  String get home_help_article_content_4 => 'Take a deep breath and relax';

  @override
  String get mood_title => 'Mood';

  @override
  String get mood_add_button => 'Add';

  @override
  String get mood_data_delete_button_title => 'Confirm deletion?';

  @override
  String get mood_data_delete_button_content => 'Cannot recover after deletion';

  @override
  String get mood_data_delete_button_cancel => 'Cancel';

  @override
  String get mood_data_delete_button_confirm => 'Delete';

  @override
  String get mood_data_content_empty => 'Nothing there';

  @override
  String get mood_data_score_title => 'Mood level';

  @override
  String get mood_category_select_title_1 => 'How are you feeling now';

  @override
  String get mood_category_select_title_2 => 'Change your mood?';

  @override
  String get mood_content_hintText => 'Tell me, what happened?';

  @override
  String get mood_content_close_button_title => 'Confirm closing?';

  @override
  String get mood_content_close_button_content => 'The content will not be saved';

  @override
  String get mood_content_close_button_cancel => 'Cancel';

  @override
  String get mood_content_close_button_confirm => 'Confirm';

  @override
  String get statistic_title => 'Statistic';

  @override
  String get statistic_filter_7d => '7d';

  @override
  String get statistic_filter_15d => '15d';

  @override
  String get statistic_filter_30d => '30d';

  @override
  String statistic_overall_daysCount_title(Object daysCount) {
    return '$daysCount days';
  }

  @override
  String get statistic_overall_daysCount_subTitle => 'Cumulative\nrecord days';

  @override
  String statistic_overall_moodCount_title(Object moodCount) {
    return '$moodCount mood';
  }

  @override
  String get statistic_overall_moodCount_subTitle => 'Cumulative\nrecord mood';

  @override
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage) {
    return '$moodScoreAverage';
  }

  @override
  String get statistic_overall_moodScoreAverage_subTitle => 'Average\ntotal score';

  @override
  String statistic_moodScoreAverage_title(Object moodScoreAverage) {
    return 'Average $moodScoreAverage';
  }

  @override
  String statistic_moodScoreAverage_content(Object moodDays) {
    return 'Mood swings are calculated on a $moodDays-day basis';
  }

  @override
  String get statistic_moodScore_title => 'Mood swings';

  @override
  String statistic_moodScore_content(Object moodDays) {
    return 'Mood swings in recent $moodDays days';
  }

  @override
  String get statistic_moodStatistics_title => 'Mood statistics';

  @override
  String statistic_moodStatistics_content(Object moodDays) {
    return 'Statistics of mood in recent $moodDays days';
  }

  @override
  String get widgets_will_pop_scope_route_toast => 'Press again to exit';

  @override
  String get web_view_loading_text => 'Loading';

  @override
  String get local_notification_welcome_title => '👋 Hi';

  @override
  String get local_notification_welcome_body =>
      'Send you a notification that the notification has been initialized.';

  @override
  String get local_notification_dialog_allow_title => 'Notifications';

  @override
  String get local_notification_dialog_allow_content => 'Allow Notifications?';

  @override
  String get local_notification_dialog_allow_cancel => 'Cancel';

  @override
  String get local_notification_dialog_allow_confirm => 'Settings';

  @override
  String get local_notification_schedule_title => '📅 Scheduling a Notification';

  @override
  String get local_notification_schedule_body => 'Every 1 minute';

  @override
  String get ai_title => 'Psychological assitant';

  @override
  String get ai_input_hint => 'Type your question or message...';

  @override
  String get ai_stop_tooltip => 'Stop';

  @override
  String get ai_sending_text => 'AI is typing...';

  @override
  String get ai_apiKey_missing_title => 'API Key missing';

  @override
  String get ai_apiKey_missing_message =>
      'Please add DEEPSEEK_KEY=<your_key> to a .env file at project root and restart the app.';

  @override
  String get ai_ok => 'OK';

  @override
  String get pomodoro_mode_work_title => 'Work Mode';

  @override
  String get pomodoro_mode_break_title => 'Break Mode';

  @override
  String get pomodoro_completed_label => 'Completed Pomodoros';

  @override
  String get pomodoro_snack_work_end => 'Break time over — back to work!';

  @override
  String get pomodoro_snack_break_end => 'Work time over — take a break!';

  @override
  String get pomodoro_reset_tooltip => 'Reset';

  @override
  String get pomodoro_toggle_tooltip => 'Toggle mode';

  @override
  String get todo_app_title => 'Todo Application';

  @override
  String get todo_list_title => 'Todo List';

  @override
  String get todo_confirm_delete_title => 'Confirm Delete';

  @override
  String get todo_confirm_delete_content => 'Are you sure you want to delete this todo item?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add_todo => 'Add Todo';

  @override
  String get start_time => 'Start Time';

  @override
  String get end_time => 'End Time';

  @override
  String get priority => 'Priority';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String get unknown => 'Unknown';

  @override
  String get title => 'Title';

  @override
  String get content => 'Content';

  @override
  String get select_start_date => 'Select Start Date';

  @override
  String get select_end_date => 'Select End Date';

  @override
  String get confirm => 'Confirm';

  @override
  String get save_todo => 'Save Todo';

  @override
  String get update_todo => 'Update Todo';

  @override
  String get todo_title_required => 'Title is required';

  @override
  String get todo_end_time_invalid => 'End time must be after start time';

  @override
  String get edit_todo => 'Edit Todo';

  @override
  String get breathing_app_title => 'Breathing Exercise';

  @override
  String get breathing_title => 'Breathing Exercise';

  @override
  String get breathing_ready => 'Ready to start';

  @override
  String get breathing_instruction_start => 'Click start to begin 4-7-8 breathing exercise';

  @override
  String get breathing_method_478 => '4-7-8 Breathing Method';

  @override
  String get breathing_method_description =>
      'Inhale for 4 seconds, hold for 7 seconds, exhale for 8 seconds';

  @override
  String get breathing_method_benefit =>
      'This method helps calm the nervous system and reduce anxiety';

  @override
  String get breathing_inhale => 'Inhale';

  @override
  String get breathing_hold => 'Hold';

  @override
  String get breathing_exhale => 'Exhale';

  @override
  String get breathing_instruction_inhale => 'Slowly inhale through your nose... 4 seconds';

  @override
  String breathing_instruction_hold(int seconds) {
    return 'Hold your breath... $seconds seconds';
  }

  @override
  String breathing_instruction_exhale(int seconds) {
    return 'Slowly exhale through your mouth... $seconds seconds';
  }

  @override
  String get breathing_paused => 'Paused';

  @override
  String get breathing_completed_cycles => 'Completed cycles';

  @override
  String get start_exercise => 'Start Exercise';

  @override
  String get stats => 'Statistics';

  @override
  String get total_seconds => 'Total seconds';

  @override
  String get pause => 'Pause';

  @override
  String get reset => 'Reset';

  @override
  String get todo_notify_before_hours => 'Remind in advance (hours)';

  @override
  String get todo_notify_before_minutes => 'Remind in advance (minutes)';

  @override
  String get todo_notify_time_invalid => 'Reminder time is invalid';

  @override
  String get daily_sentences => 'daily sentences';

  @override
  String get tilt_card_message_0 => 'Keep going — every small step counts!';

  @override
  String get tilt_card_message_1 => 'One day, one step. You\'ve got this.';

  @override
  String get tilt_card_message_2 => 'Make today meaningful — start now.';

  @override
  String get tilt_card_message_3 => 'Small progress is still progress.';

  @override
  String get tilt_card_message_4 => 'Breathe. Focus. Move forward.';

  @override
  String get tilt_card_message_5 => 'Your consistency builds your future.';

  @override
  String get tilt_card_message_6 => 'Little wins add up to big changes.';

  @override
  String get tilt_card_message_7 => 'Start where you are; use what you have.';

  @override
  String get tilt_card_message_8 => 'Progress, not perfection.';

  @override
  String get tilt_card_message_9 => 'Do it for the person you\'ll become.';

  @override
  String get tilt_card_message_10 => 'A calm mind creates clear action.';

  @override
  String get tilt_card_message_11 => 'Celebrate tiny victories today.';

  @override
  String get tilt_touch_and_move => 'Touch and move around';

  @override
  String get mood_category_happy => 'Happy';

  @override
  String get mood_category_surprised => 'Surprised';

  @override
  String get mood_category_funny => 'Funny';

  @override
  String get mood_category_embarrassed => 'Embarrassed';

  @override
  String get mood_category_sad => 'Sad';

  @override
  String get mood_category_shocked => 'Shocked';

  @override
  String get mood_category_admire => 'Admiring';

  @override
  String get mood_category_angry => 'Angry';
}
