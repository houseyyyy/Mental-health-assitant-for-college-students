import '../../../l10n/gen/app_localizations.dart'; // <- 如果路径不同请修改
import '../../../themes/app_theme.dart'; // <- 如果路径不同请修改

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../utils/utils.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class ChatMessage {
  final String role; // 'user' or 'assistant'
  String text;
  ChatMessage({required this.role, required this.text});
}

class _AiScreenState extends State<AiScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  http.Client? _httpClient;
  StreamSubscription<String>? _streamSubscription;
  bool _isSending = false;

  String get _apiKey => dotenv.env['DEEPSEEK_KEY'] ?? '';

  @override
  void dispose() {
    _cancelStreaming();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    try {
      setState(fn);
    } catch (e, st) {
      debugPrint('safeSetState error: $e\n$st');
    }
  }

  void _cancelStreaming() {
    try {
      _streamSubscription?.cancel();
    } catch (e) {
      debugPrint('cancel stream error: $e');
    }
    _streamSubscription = null;

    try {
      _httpClient?.close();
    } catch (e) {
      debugPrint('http client close error: $e');
    }
    _httpClient = null;

    _safeSetState(() {
      _isSending = false;
    });
  }

  Future<void> _ensureApiKeyPresent(BuildContext ctx, AppL10n l10n) async {
    if (_apiKey.isEmpty) {
      if (!mounted) return;
      await showDialog<void>(
        context: ctx,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(l10n.ai_apiKey_missing_title),
            content: Text(l10n.ai_apiKey_missing_message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: Text(l10n.ai_ok),
              ),
            ],
          );
        },
      );
    }
  }

  /// ---------- DB helpers ----------
  static const String _moodTable = 'mood_info';
  static const String _colCreateTime = 'create_time';
  static const String _colMoodId = 'mood_id';
  static const String _colIcon = 'icon';
  static const String _colTitle = 'title';
  static const String _colScore = 'score';
  static const String _colContent = 'content';
  static const String _colUpdateTime = 'update_time';

  Future<Database> _openAppDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'moodDB.db');
    return openDatabase(path);
  }

  Future<String> _fetchTodayMoodData() async {
    try {
      final db = await _openAppDb();
      final dateStr = Utils.datetimeFormatToString(DateTime.now());
      final List<Map<String, Object?>> rows = await db.query(
        _moodTable,
        where: "$_colCreateTime LIKE ?",
        whereArgs: ['$dateStr%'],
        orderBy: '$_colCreateTime DESC',
        limit: 1,
      );
      if (rows.isEmpty) {
        return '（今天暂无记录）';
      }
      final r = rows.first;
      return _formatMoodRow(r);
    } catch (e) {
      debugPrint('读取当天心情失败：$e');
      return '无法从本地数据库读取当天心情。';
    }
  }

  String _fetchChatHistory({int limit = 20}) {
    try {
      final recentMessages = _messages
          .where((msg) => msg.text.isNotEmpty)
          .toList()
          .reversed
          .take(limit)
          .toList()
          .reversed;

      if (recentMessages.isEmpty) return '（暂无聊天记录）';

      final sb = StringBuffer();
      for (final msg in recentMessages) {
        final role = msg.role == 'user' ? '用户' : '助手';
        sb.writeln('$role: ${msg.text}');
        sb.writeln('---');
      }
      return sb.toString();
    } catch (e) {
      debugPrint('读取聊天历史失败：$e');
      return '无法获取聊天历史记录。';
    }
  }

  String _formatMoodRow(Map<String, Object?> row) {
    final id = row[_colMoodId]?.toString() ?? '';
    final icon = row[_colIcon]?.toString() ?? '';
    final title = row[_colTitle]?.toString() ?? '';
    final score = row[_colScore]?.toString() ?? '';
    final content = row[_colContent]?.toString() ?? '';
    final create = row[_colCreateTime]?.toString() ?? '';
    final update = row[_colUpdateTime]?.toString() ?? '';

    return 'id: $id\n图标: $icon\n标题: $title\n分数: $score\n内容: ${content.isEmpty ? '无' : content}\n创建: $create\n修改: $update';
  }

  Future<void> _sendMessageStream(BuildContext ctx) async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    final l10n = AppL10n.of(ctx);

    if (_apiKey.isEmpty) {
      await _ensureApiKeyPresent(ctx, l10n);
      return;
    }

    _safeSetState(() {
      _messages.add(ChatMessage(role: 'user', text: content));
      _messages.add(ChatMessage(role: 'assistant', text: ''));
      _isSending = true;
    });

    _controller.clear();
    _scrollToBottom();

    _cancelStreaming();
    _httpClient = http.Client();

    try {
      final todayData = await _fetchTodayMoodData();
      final chatHistory = _fetchChatHistory(limit: 50);

      final String detailedTemplate = '''
你是「大学生心理健康助手」。你的身份：温和、非评判、同理且专业，专为大学生提供情绪支持与实用应对策略。当前用户正在向你咨询心理健康相关问题，下面提供两部分输入：

第一部分 — 用户今天记录的心情数据：
{TODAY_MOOD}

第二部分 — 本次聊天的历史记录：
{CHAT_HISTORY}

请严格按照以下规则回复：
1. 首要评估安全风险：若用户表明或暗示有自伤、自杀、严重伤害他人或无法照顾自己等紧急风险，立即用一句话明确告知其处于紧急危险时的行动：联系当地紧急电话或就近医院、联系校园心理危机干预中心或拨打国家/地区自杀危机热线；随后提供简单、具体的下一步联络建议。
2. 风格：语言温暖、有同理心、简洁明了；避免专业术语堆砌、不做医学诊断或病名定性。
3. 回复的语言种类根据用户的记录心情所用语言和用户提问的语言自行调整
4. 要重点关注用户记录的心情数据中的情绪记录以及相关的日记

现在请基于上面的两部分输入生成回答（并严格遵守上述规则）。
''';

      final String systemPrompt = detailedTemplate
          .replaceAll('{TODAY_MOOD}', todayData)
          .replaceAll('{CHAT_HISTORY}', chatHistory);

      final uri = Uri.parse('https://api.deepseek.com/v1/chat/completions');

      final List<Map<String, String>> history = [
        {'role': 'system', 'content': systemPrompt},
        ..._messages
            .where((msg) => msg.text.isNotEmpty)
            .map((msg) => {'role': msg.role, 'content': msg.text})
            .toList(),
      ];

      final payload = {
        'model': 'deepseek-chat',
        'messages': history,
        'stream': true,
        'max_tokens': 1024,
      };

      final request = http.Request('POST', uri)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'text/event-stream',
        })
        ..body = jsonEncode(payload);

      final streamedResponse = await _httpClient!.send(request);

      if (streamedResponse.statusCode != 200) {
        final full = await streamedResponse.stream.bytesToString();
        _appendErrorToAssistant('请求失败：status=${streamedResponse.statusCode} body=$full');
        return;
      }

      final decodedStream = streamedResponse.stream.transform(utf8.decoder).transform(const LineSplitter());

      String? currentData;

      _streamSubscription = decodedStream.listen(
        (line) {
          if (!mounted) {
            _streamSubscription?.cancel();
            return;
          }

          if (line.startsWith('data:')) {
            currentData = line.substring(5).trim();
          } else if (line.isEmpty && currentData != null) {
            _processSseData(currentData!);
            currentData = null;
          }
        },
        onError: (err) {
          _appendErrorToAssistant('流读取错误：$err');
        },
        onDone: () {
          if (currentData != null) {
            _processSseData(currentData!);
          }
          _safeSetState(() {
            _isSending = false;
          });
        },
        cancelOnError: true,
      );
    } catch (e, st) {
      debugPrint('send stream exception: $e\n$st');
      _appendErrorToAssistant('发送失败：$e');
      _cancelStreaming();
    }
  }

  void _processSseData(String data) {
    if (data == '[DONE]') {
      _cancelStreaming();
      return;
    }
    _tryParseAndAppend(data);
  }

  void _appendErrorToAssistant(String text) {
    if (!mounted) return;
    _safeSetState(() {
      final idx = _lastAssistantIndex();
      if (idx != null) {
        _messages[idx].text += '\n\n[错误] $text';
      } else {
        _messages.add(ChatMessage(role: 'assistant', text: '[错误] $text'));
      }
      _isSending = false;
    });
    _scrollToBottom();
  }

  int? _lastAssistantIndex() {
    for (int i = _messages.length - 1; i >= 0; i--) {
      if (_messages[i].role == 'assistant') return i;
    }
    return null;
  }

  void _tryParseAndAppend(String jsonText) {
    try {
      final decoded = jsonDecode(jsonText);
      final extracted = _extractTextFromEvent(decoded);
      if (extracted != null && extracted.isNotEmpty) {
        _appendToAssistant(extracted);
      }
    } catch (e) {
      debugPrint('解析JSON失败：$e，原始文本：$jsonText');
    }
  }

  String? _extractTextFromEvent(dynamic decoded) {
    try {
      if (decoded is Map && decoded.containsKey('choices') && decoded['choices'] is List && decoded['choices'].isNotEmpty) {
        final firstChoice = decoded['choices'][0];
        if (firstChoice is Map && firstChoice.containsKey('delta')) {
          final delta = firstChoice['delta'];
          if (delta is Map && delta.containsKey('content')) {
            final content = delta['content'].toString();
            return content.isNotEmpty ? content : null;
          }
        }
      }
    } catch (e) {
      debugPrint('提取文本失败：$e');
    }
    return null;
  }

  void _appendToAssistant(String frag) {
    if (!mounted) return;
    _safeSetState(() {
      final idx = _lastAssistantIndex();
      if (idx != null) {
        _messages[idx].text += frag;
      } else {
        _messages.add(ChatMessage(role: 'assistant', text: frag));
      }
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!_scrollController.hasClients) return;
      try {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      } catch (e) {
        debugPrint('scroll error: $e');
      }
    });
  }

  Widget _buildBubble(BuildContext ctx, ChatMessage msg) {
    final isUser = msg.role == 'user';
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    // Theme-aware colors
    final theme = Theme.of(ctx);
    final appTheme = AppTheme(ctx);
    final userBg = theme.colorScheme.primary;
    final userText = theme.colorScheme.onPrimary;
    final assistantBg = theme.cardColor; // cardColor usually adapts to theme
    final assistantText = theme.textTheme.bodyMedium?.color ?? Colors.black87;

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: Radius.circular(isUser ? 16 : 6),
      bottomRight: Radius.circular(isUser ? 6 : 16),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: isUser ? 12 : 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(ctx).size.width * 0.78),
          decoration: BoxDecoration(
            color: isUser ? userBg : assistantBg,
            borderRadius: radius,
          ),
          child: isUser
              ? SelectableText(
                  msg.text,
                  style: TextStyle(color: userText, fontSize: 15, height: 1.3),
                )
              : MarkdownBody(
                  data: msg.text,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                    p: TextStyle(color: assistantText, fontSize: 15, height: 1.3),
                    a: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ai_title),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? theme.textTheme.titleLarge?.color,
        elevation: 0.5,
        actions: [
          if (_isSending)
            IconButton(
              tooltip: l10n.ai_stop_tooltip,
              icon: const Icon(Icons.stop_circle_outlined, color: Colors.redAccent),
              onPressed: _cancelStreaming,
            ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length + (_isSending ? 1 : 0),
                  itemBuilder: (ctx, index) {
                    if (index >= _messages.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: theme.dividerColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(width: 8, height: 8, child: CircularProgressIndicator(strokeWidth: 2)),
                                  const SizedBox(width: 8),
                                  Text(l10n.ai_sending_text, style: theme.textTheme.bodyMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    final msg = _messages[index];
                    return _buildBubble(ctx, msg);
                  },
                ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Container(
                color: theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: theme.inputDecorationTheme.fillColor ?? AppTheme.staticBackgroundColor1,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                textInputAction: TextInputAction.send,
                                minLines: 1,
                                maxLines: 6,
                                onSubmitted: (_) => _isSending ? _cancelStreaming() : _sendMessageStream(context),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: l10n.ai_input_hint,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_reaction_outlined, color: theme.iconTheme.color),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _isSending ? _cancelStreaming() : _sendMessageStream(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isSending ? theme.disabledColor : theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isSending ? Icons.stop : Icons.send,
                          color: theme.colorScheme.onPrimary,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
