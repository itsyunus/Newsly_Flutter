import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsly/core/app_config.dart';

class AiService {
  Future<String> summarize(String title, String description, String url) async {
    final apiKey = AppConfig.openAiKey;
    if (apiKey.isEmpty) {
      return 'OpenAI / OpenRouter key not set. Add OPENAI_API_KEY to your .env';
    }

    final baseUrl = AppConfig.baseUrl;
    final body = {
      'model': AppConfig.openAiModel,
      'messages': [
        {
          'role': 'system',
          'content':
              'You are a concise news summarizer. Return 3-5 bullet points under 20 words each, plus a 1-line TL;DR.'
        },
        {
          'role': 'user',
          'content':
              'Title: $title\nDescription: $description\nURL: $url\nSummarize.'
        }
      ],
      'temperature': 0.3,
    };

    final resp = await http.post(
      Uri.parse('$baseUrl/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        'HTTP-Referer': 'https://openrouter.ai/',
        'X-Title': 'Newsly',
      },
      body: jsonEncode(body),
    );

    if (resp.statusCode != 200) {
      return 'AI summary error: ${resp.statusCode} ${resp.body}';
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    return (data['choices']?[0]?['message']?['content'] ?? '').toString().trim();
  }
}
