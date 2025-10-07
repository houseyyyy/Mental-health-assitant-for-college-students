import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

import '../../router.dart';
import '../../themes/app_theme.dart';
import '../../l10n/gen/app_localizations.dart';
import '../../utils/utils.dart';
import '../../widgets/animation/animation.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../domain/models/mood/mood_category_model.dart';
import 'view_models/home_view_model.dart';

/// 首页
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeViewModel(moodCategoryLoadUseCase: context.read());
      },
      child: const Scaffold(body: HomeBody(key: Key('widget_home_body'))),
    );
  }
}

/// 首页主体
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      primary: false,
      shrinkWrap: false,
      slivers: [
        SliverAppBar(
          pinned: false,
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appL10n.home_hi,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    semanticsLabel: appL10n.app_bottomNavigationBar_title_home,
                  ),
                  Image.asset(
                    'assets/images/woolly/woolly-yellow-star.png',
                    height: 60,
                    excludeFromSemantics: true,
                  ),
                ],
              ),
            ),
          ),
          collapsedHeight: 100,
          expandedHeight: 100,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 头部
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
                  child: Semantics(container: true, child: const Header()),
                ),

                /// 情绪选项卡
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: MoodOption(key: Key('widget_mood_option')),
                ),

                /// 公告卡片
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: MergeSemantics(child: NoticeCard()),
                ),

                /// 相关文章（改为左右滑动卡片）
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        container: true,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Text(
                            appL10n.home_help_title,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // 使用新的滑动卡片组件替代原来的Article
                      const SwipeableArticleCards(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            appL10n.home_moodChoice_title,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
          ),
        ),
        Selector<HomeViewModel, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
          selector: (_, homeViewModel) {
            return (loading: homeViewModel.loading, moodCategoryAll: homeViewModel.moodCategoryAll);
          },
          builder: (context, data, child) {
            /// 加载数据的占位
            if (data.loading && data.moodCategoryAll.isEmpty) {
              return const Align(child: CupertinoActivityIndicator(radius: 12));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

/// 情绪选项卡
class MoodOption extends StatelessWidget {
  const MoodOption({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final Map<String, String> localizedTitles = {
      'happy': l10n.mood_category_happy,
      'surprised': l10n.mood_category_surprised,
      'funny': l10n.mood_category_funny,
      'awkward': l10n.mood_category_embarrassed,
      'sad': l10n.mood_category_sad,
      'shocked': l10n.mood_category_shocked,
      'admiring': l10n.mood_category_admire,
      'angry': l10n.mood_category_angry,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Selector<HomeViewModel, ({bool loading, List<MoodCategoryModel> moodCategoryAll})>(
        selector: (_, homeViewModel) {
          return (loading: homeViewModel.loading, moodCategoryAll: homeViewModel.moodCategoryAll);
        },
        builder: (context, data, child) {
          if (data.loading) return const SizedBox();

          /// 所有心情类型数据
          final widgetList = <Widget>[];
          for (final list in data.moodCategoryAll) {
            final localizedTitle = localizedTitles[list.title] ?? list.title;
            widgetList.add(OptionCard(title: localizedTitle, icon: list.icon));
          }

          return Wrap(
            spacing: 24,
            alignment: WrapAlignment.spaceBetween,
            children: widgetList,
          );
        },
      ),
    );
  }
}

/// 小型选项卡片
class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.title, required this.icon});

  /// 标题
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme(context).isDarkMode;
    const double iconSize = 32;

    return GestureDetector(
      onTap: () {
        // 跳转输入内容页
        final nowDateTime = Utils.datetimeFormatToString(DateTime.now());
        final moodData = MoodDataModel(
          icon: icon,
          title: title,
          score: 50,
          create_time: nowDateTime,
          update_time: nowDateTime,
        );
        GoRouter.of(context).pushNamed(
          Routes.moodContentEdit,
          pathParameters: {'moodData': jsonEncode(moodData.toJson())},
        );
      },
      child: Column(
        children: [
          AnimatedPress(
            child: Container(
              constraints: const BoxConstraints(minWidth: 52),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2B3034) : AppTheme.staticBackgroundColor1,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Align(
                  child: Text(icon, style: const TextStyle(fontSize: iconSize)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

/// 公告卡片
class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 328),
      child: Stack(
        children: [
          /// 阴影
          shadow(opacity: 0.2, margin: const EdgeInsets.only(left: 24, right: 24, top: 16)),
          shadow(opacity: 0.4, margin: const EdgeInsets.only(left: 12, right: 12, top: 8)),

          /// 正文
          const SizedBox(height: 190, child: NoticeMainCard()),
        ],
      ),
    );
  }

  /// 阴影
  Widget shadow({EdgeInsetsGeometry? margin, required double opacity}) {
    return Container(
      height: 190,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFFFFBBBB).withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

/// 公告主卡片
class NoticeMainCard extends StatelessWidget {
  const NoticeMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFBBBB), Color(0xFFFFBBBB), Color(0xFFFFC5C5)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                /// 图片或装饰
                Positioned(
                  bottom: -18,
                  left: 140,
                  child: Image.asset(
                    'assets/images/onboarding/onboarding_3.png',
                    fit: BoxFit.contain,
                    width: 180,
                  ),
                ),

                /// 文字和按钮
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appL10n.home_upgrade_title,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              appL10n.home_upgrade_content,
                              style: const TextStyle(color: Colors.black87, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 45, minWidth: 95),
                      child: AnimatedPress(
                        child: OutlinedButton(
                          onPressed: () {
                            GoRouter.of(context).pushNamed(Routes.onboarding);
                          },
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                            backgroundColor: WidgetStateProperty.all(Colors.black87),
                            textStyle: WidgetStateProperty.all(
                              const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            overlayColor: WidgetStateProperty.all(Colors.white10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  appL10n.home_upgrade_button,
                                  strutStyle: const StrutStyle(forceStrutHeight: false, leading: 1),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              const Icon(Remix.play_circle_fill, size: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 新增：支持左右滑动的文章卡片组件（固定卡片高度，图片允许上下左右溢出且不被裁剪）
// ==========================================

class SwipeableArticleCards extends StatefulWidget {
  const SwipeableArticleCards({super.key});

  @override
  State<SwipeableArticleCards> createState() => _SwipeableArticleCardsState();
}

class _SwipeableArticleCardsState extends State<SwipeableArticleCards> {
  late final PageController _pageController;
  int _currentIndex = 0;

  // 固定卡片高度
  static const double cardHeight = 260.0;

  // 允许图片在上下方向溢出可见的额外空间（PageView 总高度 = cardHeight + verticalOverflowAllowance）
  static const double verticalOverflowAllowance = 80.0;
  double get pageViewHeight => cardHeight + verticalOverflowAllowance;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appL10n = AppL10n.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8;

    // 每篇文章指定 image 的目标位置（使用 top/right/left/bottom，可以为负值）
    // imageScale 表示图片高度 = cardHeight * imageScale（你可以调节这个值）
    final articles = [
      {
        'gradient': const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFFFCEBD), Color(0xFFFFCEBD), Color(0xFFFFDCCF)],
        ),
        'title': appL10n.home_help_article_title_1,
        'content': appL10n.home_help_article_content_1,
        'image': 'assets/images/onboarding/onboarding_2.png',
        // 把图片放到右上角，稍微溢出（top: -20, right: -20）
        'imageTop': 80.0,
        'imageRight': 0.0,
        'imageScale': 0.65,
        'paddingTop': 0.0,
        'paddingBottom': 100.0,
        'onTap': () {
          GoRouter.of(context).pushNamed(Routes.aiScreen);
        }
      },
      {
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD390), Color(0xFFFFD390), Color(0xFFFFE1B3)],
        ),
        'title': appL10n.home_help_article_title_2,
        'content': appL10n.home_help_article_content_2,
        'image': 'assets/images/onboarding/tomatoes.png',
        // 西红柿也放到右上角，但位置不同（更靠内侧），你可以微调
        'imageTop': 0.0,
        'imageRight': 0.0,
        'imageScale': 0.58,
        'paddingTop': 110.0,
        'paddingBottom': 0.0,
        'onTap': () {
          GoRouter.of(context).pushNamed(Routes.pomodoro_clock);
        }
      },
      {
        'gradient': const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFFBDE0FE), Color(0xFFBDE0FE), Color(0xFFDBEAFE)],
        ),
        'title': appL10n.home_help_article_title_3,
        'content': appL10n.home_help_article_content_3,
        'image': 'assets/images/onboarding/list.png',
        // 列表图放右下角，稍微溢出底部
        'imageBottom': 0.0,
        'imageRight': 0.0,
        'imageScale': 0.62,
        'paddingTop': 20.0,
        'paddingBottom': 90.0,
        'onTap': () {
          GoRouter.of(context).pushNamed(Routes.todolist);
        }
      },
      {
        'gradient': const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB7F8DB), Color(0xFFB7F8DB), Color(0xFFCCFBF1)],
        ),
        'title': appL10n.home_help_article_title_4,
        'content': appL10n.home_help_article_content_4,
        'image': 'assets/images/onboarding/breath.png',
        // 放右上、但更靠内侧
        'imageTop': 0.0,
        'imageRight': -10.0,
        'imageScale': 0.55,
        'paddingTop': 100.0,
        'paddingBottom': 10.0,
        'onTap': () {
          GoRouter.of(context).pushNamed(Routes.breath);
        }
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: pageViewHeight,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: articles.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final article = articles[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: ArticleCard(
                      width: cardWidth,
                      height: cardHeight,
                      gradient: article['gradient'] as Gradient,
                      onTap: article['onTap'] as VoidCallback?,
                      children: [
                        // 核心：使用 Positioned 放置图片，便于精确控制 top/right/left/bottom（可为负）
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // 图片（放在最底层）
                            Positioned(
                              top: article.containsKey('imageTop') ? (article['imageTop'] as double) : null,
                              bottom: article.containsKey('imageBottom') ? (article['imageBottom'] as double) : null,
                              left: article.containsKey('imageLeft') ? (article['imageLeft'] as double) : null,
                              right: article.containsKey('imageRight') ? (article['imageRight'] as double) : null,
                              child: Image.asset(
                                article['image'] as String,
                                // 图片高度基于卡片高度与 imageScale（比例）
                                height: cardHeight * (article['imageScale'] as double),
                                fit: BoxFit.fitHeight, // 纵向填满所设置的高度
                              ),
                            ),

                            // 前景文字（放在卡片内部，使用 Positioned.fill + Padding）
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: article['paddingTop'] as double),
                                    Text(
                                      article['title'] as String,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      child: Text(
                                        article['content'] as String,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Icon(
                                        Remix.arrow_right_circle_fill,
                                        size: 24,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: article['paddingBottom'] as double),
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
            },
          ),
        ),

        // 指示器
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(articles.length, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == i ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentIndex == i
                      ? Theme.of(context).primaryColor
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// 文章卡片 (固定高度，内部用 Stack + Positioned.fill 限制 Column 尺寸)
class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.width,
    required this.height,
    required this.gradient,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.children,
    this.onTap,
  });

  final double width;
  final double height;
  final Gradient gradient;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      scaleEnd: 0.9,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 卡片内部内容（children 通常是一个 Stack：图片 + 文本）
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}