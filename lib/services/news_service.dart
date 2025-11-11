import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsly/core/app_config.dart';
import 'package:newsly/models/article.dart';

class NewsService {
  static const _base = 'https://newsapi.org/v2';

  Future<List<Article>> topHeadlines({String category = 'general'}) async {
    final uri = Uri.parse('$_base/top-headlines?language=en&pageSize=50&category=$category');
    final resp = await http.get(uri, headers: {'X-Api-Key': AppConfig.newsApiKey});
    if (resp.statusCode != 200) {
      throw Exception('News API error: ${resp.statusCode} ${resp.body}');
    }
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final List arts = data['articles'] ?? [];
    return arts.map((e) => Article.fromJson(e)).toList().cast<Article>();
  }
}