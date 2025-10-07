import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n)!;
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @app_bottomNavigationBar_title_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get app_bottomNavigationBar_title_home;

  /// No description provided for @app_bottomNavigationBar_title_mood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get app_bottomNavigationBar_title_mood;

  /// No description provided for @app_bottomNavigationBar_title_statistic.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get app_bottomNavigationBar_title_statistic;

  /// No description provided for @app_setting_database.
  ///
  /// In en, this message translates to:
  /// **'Database'**
  String get app_setting_database;

  /// No description provided for @app_setting_database_export_data.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get app_setting_database_export_data;

  /// No description provided for @app_setting_database_export_data_toast_success.
  ///
  /// In en, this message translates to:
  /// **'Export succeeded'**
  String get app_setting_database_export_data_toast_success;

  /// No description provided for @app_setting_database_import_data.
  ///
  /// In en, this message translates to:
  /// **'Import data'**
  String get app_setting_database_import_data;

  /// No description provided for @app_setting_database_import_data_button_error.
  ///
  /// In en, this message translates to:
  /// **'ERR'**
  String get app_setting_database_import_data_button_error;

  /// No description provided for @app_setting_database_import_data_button_template.
  ///
  /// In en, this message translates to:
  /// **'TMPL'**
  String get app_setting_database_import_data_button_template;

  /// No description provided for @app_setting_database_import_data_toast_error.
  ///
  /// In en, this message translates to:
  /// **'Import failed. Please download the wrong data, modify it and try again.'**
  String get app_setting_database_import_data_toast_error;

  /// No description provided for @app_setting_database_import_data_toast_success.
  ///
  /// In en, this message translates to:
  /// **'Import succeeded'**
  String get app_setting_database_import_data_toast_success;

  /// No description provided for @app_setting_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get app_setting_security;

  /// No description provided for @app_setting_security_content.
  ///
  /// In en, this message translates to:
  /// **'You need to unlock the app when you reopen it.'**
  String get app_setting_security_content;

  /// No description provided for @app_setting_security_lock.
  ///
  /// In en, this message translates to:
  /// **'Security lock'**
  String get app_setting_security_lock;

  /// No description provided for @app_setting_security_biometric_weak.
  ///
  /// In en, this message translates to:
  /// **'TouchID / FaceID auth'**
  String get app_setting_security_biometric_weak;

  /// No description provided for @app_setting_security_biometric_iris.
  ///
  /// In en, this message translates to:
  /// **'Iris auth'**
  String get app_setting_security_biometric_iris;

  /// No description provided for @app_setting_security_biometric_face.
  ///
  /// In en, this message translates to:
  /// **'Face auth'**
  String get app_setting_security_biometric_face;

  /// No description provided for @app_setting_security_biometric_fingerprint.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint auth'**
  String get app_setting_security_biometric_fingerprint;

  /// No description provided for @app_setting_security_lock_title_1.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get app_setting_security_lock_title_1;

  /// No description provided for @app_setting_security_lock_title_2.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get app_setting_security_lock_title_2;

  /// No description provided for @app_setting_security_lock_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get app_setting_security_lock_cancel;

  /// No description provided for @app_setting_security_lock_resetinput.
  ///
  /// In en, this message translates to:
  /// **'Reset input'**
  String get app_setting_security_lock_resetinput;

  /// No description provided for @app_setting_security_lock_error_1.
  ///
  /// In en, this message translates to:
  /// **'The two passwords are inconsistent'**
  String get app_setting_security_lock_error_1;

  /// No description provided for @app_setting_security_lock_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Security lock'**
  String get app_setting_security_lock_screen_title;

  /// No description provided for @app_setting_security_localauth_localizedreason.
  ///
  /// In en, this message translates to:
  /// **'Please identify'**
  String get app_setting_security_localauth_localizedreason;

  /// No description provided for @app_setting_security_localauth_signIntitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication required'**
  String get app_setting_security_localauth_signIntitle;

  /// No description provided for @app_setting_security_localauth_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get app_setting_security_localauth_cancel;

  /// No description provided for @app_setting_security_localauth_error_1.
  ///
  /// In en, this message translates to:
  /// **'You have failed many times, please try again later'**
  String get app_setting_security_localauth_error_1;

  /// No description provided for @app_setting_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get app_setting_theme;

  /// No description provided for @app_setting_theme_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get app_setting_theme_appearance;

  /// No description provided for @app_setting_theme_appearance_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get app_setting_theme_appearance_system;

  /// No description provided for @app_setting_theme_appearance_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get app_setting_theme_appearance_light;

  /// No description provided for @app_setting_theme_appearance_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get app_setting_theme_appearance_dark;

  /// No description provided for @app_setting_theme_themes.
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get app_setting_theme_themes;

  /// No description provided for @app_setting_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get app_setting_language;

  /// No description provided for @app_setting_language_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get app_setting_language_system;

  /// No description provided for @app_setting_laboratory.
  ///
  /// In en, this message translates to:
  /// **'Laboratory'**
  String get app_setting_laboratory;

  /// No description provided for @app_setting_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get app_setting_about;

  /// No description provided for @onboarding_title_1.
  ///
  /// In en, this message translates to:
  /// **'Managing thoughts'**
  String get onboarding_title_1;

  /// No description provided for @onboarding_content_1_1.
  ///
  /// In en, this message translates to:
  /// **'Release all your feelings'**
  String get onboarding_content_1_1;

  /// No description provided for @onboarding_content_1_2.
  ///
  /// In en, this message translates to:
  /// **'Easily record what you see and think every moment'**
  String get onboarding_content_1_2;

  /// No description provided for @onboarding_title_2.
  ///
  /// In en, this message translates to:
  /// **'Careful statistics'**
  String get onboarding_title_2;

  /// No description provided for @onboarding_content_2_1.
  ///
  /// In en, this message translates to:
  /// **'Count your joys and sorrows'**
  String get onboarding_content_2_1;

  /// No description provided for @onboarding_content_2_2.
  ///
  /// In en, this message translates to:
  /// **'Let you know your mental activity'**
  String get onboarding_content_2_2;

  /// No description provided for @onboarding_title_3.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get onboarding_title_3;

  /// No description provided for @onboarding_content_3_1.
  ///
  /// In en, this message translates to:
  /// **'Start recording a better version of yourself now'**
  String get onboarding_content_3_1;

  /// No description provided for @home_hi.
  ///
  /// In en, this message translates to:
  /// **'Hi~'**
  String get home_hi;

  /// No description provided for @home_moodChoice_title.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling now'**
  String get home_moodChoice_title;

  /// No description provided for @home_upgrade_title.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get home_upgrade_title;

  /// No description provided for @home_upgrade_content.
  ///
  /// In en, this message translates to:
  /// **'Learn the latest\nusage scenarios'**
  String get home_upgrade_content;

  /// No description provided for @home_upgrade_button.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get home_upgrade_button;

  /// No description provided for @home_help_title.
  ///
  /// In en, this message translates to:
  /// **'Functions'**
  String get home_help_title;

  /// No description provided for @home_help_article_title_1.
  ///
  /// In en, this message translates to:
  /// **'Psychological Assistant'**
  String get home_help_article_title_1;

  /// No description provided for @home_help_article_content_1.
  ///
  /// In en, this message translates to:
  /// **'A ChatGPT that understands your mood...'**
  String get home_help_article_content_1;

  /// No description provided for @home_help_article_title_2.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro Timer'**
  String get home_help_article_title_2;

  /// No description provided for @home_help_article_content_2.
  ///
  /// In en, this message translates to:
  /// **'Might be useful for focus...'**
  String get home_help_article_content_2;

  /// No description provided for @home_help_article_title_3.
  ///
  /// In en, this message translates to:
  /// **'ToDo'**
  String get home_help_article_title_3;

  /// No description provided for @home_help_article_content_3.
  ///
  /// In en, this message translates to:
  /// **'record and remind your deadline...'**
  String get home_help_article_content_3;

  /// No description provided for @home_help_article_title_4.
  ///
  /// In en, this message translates to:
  /// **'Deep Breathing'**
  String get home_help_article_title_4;

  /// No description provided for @home_help_article_content_4.
  ///
  /// In en, this message translates to:
  /// **'Take a deep breath and relax'**
  String get home_help_article_content_4;

  /// No description provided for @mood_title.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get mood_title;

  /// No description provided for @mood_add_button.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get mood_add_button;

  /// No description provided for @mood_data_delete_button_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm deletion?'**
  String get mood_data_delete_button_title;

  /// No description provided for @mood_data_delete_button_content.
  ///
  /// In en, this message translates to:
  /// **'Cannot recover after deletion'**
  String get mood_data_delete_button_content;

  /// No description provided for @mood_data_delete_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mood_data_delete_button_cancel;

  /// No description provided for @mood_data_delete_button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get mood_data_delete_button_confirm;

  /// No description provided for @mood_data_content_empty.
  ///
  /// In en, this message translates to:
  /// **'Nothing there'**
  String get mood_data_content_empty;

  /// No description provided for @mood_data_score_title.
  ///
  /// In en, this message translates to:
  /// **'Mood level'**
  String get mood_data_score_title;

  /// No description provided for @mood_category_select_title_1.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling now'**
  String get mood_category_select_title_1;

  /// No description provided for @mood_category_select_title_2.
  ///
  /// In en, this message translates to:
  /// **'Change your mood?'**
  String get mood_category_select_title_2;

  /// No description provided for @mood_content_hintText.
  ///
  /// In en, this message translates to:
  /// **'Tell me, what happened?'**
  String get mood_content_hintText;

  /// No description provided for @mood_content_close_button_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm closing?'**
  String get mood_content_close_button_title;

  /// No description provided for @mood_content_close_button_content.
  ///
  /// In en, this message translates to:
  /// **'The content will not be saved'**
  String get mood_content_close_button_content;

  /// No description provided for @mood_content_close_button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mood_content_close_button_cancel;

  /// No description provided for @mood_content_close_button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get mood_content_close_button_confirm;

  /// No description provided for @statistic_title.
  ///
  /// In en, this message translates to:
  /// **'Statistic'**
  String get statistic_title;

  /// No description provided for @statistic_filter_7d.
  ///
  /// In en, this message translates to:
  /// **'7d'**
  String get statistic_filter_7d;

  /// No description provided for @statistic_filter_15d.
  ///
  /// In en, this message translates to:
  /// **'15d'**
  String get statistic_filter_15d;

  /// No description provided for @statistic_filter_30d.
  ///
  /// In en, this message translates to:
  /// **'30d'**
  String get statistic_filter_30d;

  /// No description provided for @statistic_overall_daysCount_title.
  ///
  /// In en, this message translates to:
  /// **'{daysCount} days'**
  String statistic_overall_daysCount_title(Object daysCount);

  /// No description provided for @statistic_overall_daysCount_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative\nrecord days'**
  String get statistic_overall_daysCount_subTitle;

  /// No description provided for @statistic_overall_moodCount_title.
  ///
  /// In en, this message translates to:
  /// **'{moodCount} mood'**
  String statistic_overall_moodCount_title(Object moodCount);

  /// No description provided for @statistic_overall_moodCount_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Cumulative\nrecord mood'**
  String get statistic_overall_moodCount_subTitle;

  /// No description provided for @statistic_overall_moodScoreAverage_title.
  ///
  /// In en, this message translates to:
  /// **'{moodScoreAverage}'**
  String statistic_overall_moodScoreAverage_title(Object moodScoreAverage);

  /// No description provided for @statistic_overall_moodScoreAverage_subTitle.
  ///
  /// In en, this message translates to:
  /// **'Average\ntotal score'**
  String get statistic_overall_moodScoreAverage_subTitle;

  /// No description provided for @statistic_moodScoreAverage_title.
  ///
  /// In en, this message translates to:
  /// **'Average {moodScoreAverage}'**
  String statistic_moodScoreAverage_title(Object moodScoreAverage);

  /// No description provided for @statistic_moodScoreAverage_content.
  ///
  /// In en, this message translates to:
  /// **'Mood swings are calculated on a {moodDays}-day basis'**
  String statistic_moodScoreAverage_content(Object moodDays);

  /// No description provided for @statistic_moodScore_title.
  ///
  /// In en, this message translates to:
  /// **'Mood swings'**
  String get statistic_moodScore_title;

  /// No description provided for @statistic_moodScore_content.
  ///
  /// In en, this message translates to:
  /// **'Mood swings in recent {moodDays} days'**
  String statistic_moodScore_content(Object moodDays);

  /// No description provided for @statistic_moodStatistics_title.
  ///
  /// In en, this message translates to:
  /// **'Mood statistics'**
  String get statistic_moodStatistics_title;

  /// No description provided for @statistic_moodStatistics_content.
  ///
  /// In en, this message translates to:
  /// **'Statistics of mood in recent {moodDays} days'**
  String statistic_moodStatistics_content(Object moodDays);

  /// No description provided for @widgets_will_pop_scope_route_toast.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit'**
  String get widgets_will_pop_scope_route_toast;

  /// WebView加载文字
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get web_view_loading_text;

  /// No description provided for @local_notification_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'👋 Hi'**
  String get local_notification_welcome_title;

  /// No description provided for @local_notification_welcome_body.
  ///
  /// In en, this message translates to:
  /// **'Send you a notification that the notification has been initialized.'**
  String get local_notification_welcome_body;

  /// No description provided for @local_notification_dialog_allow_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get local_notification_dialog_allow_title;

  /// No description provided for @local_notification_dialog_allow_content.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications?'**
  String get local_notification_dialog_allow_content;

  /// No description provided for @local_notification_dialog_allow_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get local_notification_dialog_allow_cancel;

  /// No description provided for @local_notification_dialog_allow_confirm.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get local_notification_dialog_allow_confirm;

  /// No description provided for @local_notification_schedule_title.
  ///
  /// In en, this message translates to:
  /// **'📅 Scheduling a Notification'**
  String get local_notification_schedule_title;

  /// No description provided for @local_notification_schedule_body.
  ///
  /// In en, this message translates to:
  /// **'Every 1 minute'**
  String get local_notification_schedule_body;

  /// No description provided for @ai_title.
  ///
  /// In en, this message translates to:
  /// **'Psychological assitant'**
  String get ai_title;

  /// No description provided for @ai_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Type your question or message...'**
  String get ai_input_hint;

  /// No description provided for @ai_stop_tooltip.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get ai_stop_tooltip;

  /// No description provided for @ai_sending_text.
  ///
  /// In en, this message translates to:
  /// **'AI is typing...'**
  String get ai_sending_text;

  /// No description provided for @ai_apiKey_missing_title.
  ///
  /// In en, this message translates to:
  /// **'API Key missing'**
  String get ai_apiKey_missing_title;

  /// No description provided for @ai_apiKey_missing_message.
  ///
  /// In en, this message translates to:
  /// **'Please add DEEPSEEK_KEY=<your_key> to a .env file at project root and restart the app.'**
  String get ai_apiKey_missing_message;

  /// No description provided for @ai_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ai_ok;

  /// AppBar title when in work mode
  ///
  /// In en, this message translates to:
  /// **'Work Mode'**
  String get pomodoro_mode_work_title;

  /// AppBar title when in break mode
  ///
  /// In en, this message translates to:
  /// **'Break Mode'**
  String get pomodoro_mode_break_title;

  /// Label above the completed pomodoro indicators
  ///
  /// In en, this message translates to:
  /// **'Completed Pomodoros'**
  String get pomodoro_completed_label;

  /// Snackbar text when break ends and switching to work
  ///
  /// In en, this message translates to:
  /// **'Break time over — back to work!'**
  String get pomodoro_snack_work_end;

  /// Snackbar text when work ends and switching to break
  ///
  /// In en, this message translates to:
  /// **'Work time over — take a break!'**
  String get pomodoro_snack_break_end;

  /// Tooltip for reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get pomodoro_reset_tooltip;

  /// Tooltip for toggling between work and break
  ///
  /// In en, this message translates to:
  /// **'Toggle mode'**
  String get pomodoro_toggle_tooltip;

  /// Title of the todo application
  ///
  /// In en, this message translates to:
  /// **'Todo Application'**
  String get todo_app_title;

  /// Title of the todo list screen
  ///
  /// In en, this message translates to:
  /// **'Todo List'**
  String get todo_list_title;

  /// Title of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get todo_confirm_delete_title;

  /// Content of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this todo item?'**
  String get todo_confirm_delete_content;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Add todo button text
  ///
  /// In en, this message translates to:
  /// **'Add Todo'**
  String get add_todo;

  /// Label for start time
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get start_time;

  /// Label for end time
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get end_time;

  /// Label for priority
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// High priority
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// Medium priority
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Low priority
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// Unknown priority
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Label for title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Label for content field
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// Label for start date picker
  ///
  /// In en, this message translates to:
  /// **'Select Start Date'**
  String get select_start_date;

  /// Label for end date picker
  ///
  /// In en, this message translates to:
  /// **'Select End Date'**
  String get select_end_date;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Save todo button text
  ///
  /// In en, this message translates to:
  /// **'Save Todo'**
  String get save_todo;

  /// Update todo button text
  ///
  /// In en, this message translates to:
  /// **'Update Todo'**
  String get update_todo;

  /// Error message when title is empty
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get todo_title_required;

  /// Error message when end time is before start time
  ///
  /// In en, this message translates to:
  /// **'End time must be after start time'**
  String get todo_end_time_invalid;

  /// Title for editing a todo item
  ///
  /// In en, this message translates to:
  /// **'Edit Todo'**
  String get edit_todo;

  /// Title of the breathing exercise app
  ///
  /// In en, this message translates to:
  /// **'Breathing Exercise'**
  String get breathing_app_title;

  /// Title of the breathing exercise page
  ///
  /// In en, this message translates to:
  /// **'Breathing Exercise'**
  String get breathing_title;

  /// Text when ready to start breathing exercise
  ///
  /// In en, this message translates to:
  /// **'Ready to start'**
  String get breathing_ready;

  /// Initial instruction for breathing exercise
  ///
  /// In en, this message translates to:
  /// **'Click start to begin 4-7-8 breathing exercise'**
  String get breathing_instruction_start;

  /// Title of the 4-7-8 breathing method
  ///
  /// In en, this message translates to:
  /// **'4-7-8 Breathing Method'**
  String get breathing_method_478;

  /// Description of the 4-7-8 breathing method
  ///
  /// In en, this message translates to:
  /// **'Inhale for 4 seconds, hold for 7 seconds, exhale for 8 seconds'**
  String get breathing_method_description;

  /// Benefits of the breathing method
  ///
  /// In en, this message translates to:
  /// **'This method helps calm the nervous system and reduce anxiety'**
  String get breathing_method_benefit;

  /// Text for inhale phase
  ///
  /// In en, this message translates to:
  /// **'Inhale'**
  String get breathing_inhale;

  /// Text for hold phase
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get breathing_hold;

  /// Text for exhale phase
  ///
  /// In en, this message translates to:
  /// **'Exhale'**
  String get breathing_exhale;

  /// Instruction for inhale phase
  ///
  /// In en, this message translates to:
  /// **'Slowly inhale through your nose... 4 seconds'**
  String get breathing_instruction_inhale;

  /// Instruction for hold phase with remaining seconds
  ///
  /// In en, this message translates to:
  /// **'Hold your breath... {seconds} seconds'**
  String breathing_instruction_hold(int seconds);

  /// Instruction for exhale phase with remaining seconds
  ///
  /// In en, this message translates to:
  /// **'Slowly exhale through your mouth... {seconds} seconds'**
  String breathing_instruction_exhale(int seconds);

  /// Text when exercise is paused
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get breathing_paused;

  /// Label for completed cycles count
  ///
  /// In en, this message translates to:
  /// **'Completed cycles'**
  String get breathing_completed_cycles;

  /// Text for start exercise button
  ///
  /// In en, this message translates to:
  /// **'Start Exercise'**
  String get start_exercise;

  /// Label for statistics section
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// Label for total seconds
  ///
  /// In en, this message translates to:
  /// **'Total seconds'**
  String get total_seconds;

  /// Text for pause button
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Text for reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @todo_notify_before_hours.
  ///
  /// In en, this message translates to:
  /// **'Remind in advance (hours)'**
  String get todo_notify_before_hours;

  /// No description provided for @todo_notify_before_minutes.
  ///
  /// In en, this message translates to:
  /// **'Remind in advance (minutes)'**
  String get todo_notify_before_minutes;

  /// No description provided for @todo_notify_time_invalid.
  ///
  /// In en, this message translates to:
  /// **'Reminder time is invalid'**
  String get todo_notify_time_invalid;

  /// No description provided for @daily_sentences.
  ///
  /// In en, this message translates to:
  /// **'daily sentences'**
  String get daily_sentences;

  /// Positive message 0
  ///
  /// In en, this message translates to:
  /// **'Keep going — every small step counts!'**
  String get tilt_card_message_0;

  /// Positive message 1
  ///
  /// In en, this message translates to:
  /// **'One day, one step. You\'ve got this.'**
  String get tilt_card_message_1;

  /// Positive message 2
  ///
  /// In en, this message translates to:
  /// **'Make today meaningful — start now.'**
  String get tilt_card_message_2;

  /// Positive message 3
  ///
  /// In en, this message translates to:
  /// **'Small progress is still progress.'**
  String get tilt_card_message_3;

  /// Positive message 4
  ///
  /// In en, this message translates to:
  /// **'Breathe. Focus. Move forward.'**
  String get tilt_card_message_4;

  /// Positive message 5
  ///
  /// In en, this message translates to:
  /// **'Your consistency builds your future.'**
  String get tilt_card_message_5;

  /// Positive message 6
  ///
  /// In en, this message translates to:
  /// **'Little wins add up to big changes.'**
  String get tilt_card_message_6;

  /// Positive message 7
  ///
  /// In en, this message translates to:
  /// **'Start where you are; use what you have.'**
  String get tilt_card_message_7;

  /// Positive message 8
  ///
  /// In en, this message translates to:
  /// **'Progress, not perfection.'**
  String get tilt_card_message_8;

  /// Positive message 9
  ///
  /// In en, this message translates to:
  /// **'Do it for the person you\'ll become.'**
  String get tilt_card_message_9;

  /// Positive message 10
  ///
  /// In en, this message translates to:
  /// **'A calm mind creates clear action.'**
  String get tilt_card_message_10;

  /// Positive message 11
  ///
  /// In en, this message translates to:
  /// **'Celebrate tiny victories today.'**
  String get tilt_card_message_11;

  /// Prompt shown on tilt card
  ///
  /// In en, this message translates to:
  /// **'Touch and move around'**
  String get tilt_touch_and_move;

  /// Mood category: happy
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get mood_category_happy;

  /// Mood category: surprised
  ///
  /// In en, this message translates to:
  /// **'Surprised'**
  String get mood_category_surprised;

  /// Mood category: funny / silly
  ///
  /// In en, this message translates to:
  /// **'Funny'**
  String get mood_category_funny;

  /// Mood category: embarrassed
  ///
  /// In en, this message translates to:
  /// **'Embarrassed'**
  String get mood_category_embarrassed;

  /// Mood category: sad
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get mood_category_sad;

  /// Mood category: shocked / astonished
  ///
  /// In en, this message translates to:
  /// **'Shocked'**
  String get mood_category_shocked;

  /// Mood category: admire / impressed
  ///
  /// In en, this message translates to:
  /// **'Admiring'**
  String get mood_category_admire;

  /// Mood category: angry
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get mood_category_angry;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppL10nZhCn();
          case 'HK':
            return AppL10nZhHk();
          case 'TW':
            return AppL10nZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
    case 'zh':
      return AppL10nZh();
  }

  throw FlutterError(
    'AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
