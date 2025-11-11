import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newsly/models/article.dart';

class FavoritesService {
  static const _key = 'favorites';

  Future<List<Article>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    return raw.map((s) => Article.fromJson(jsonDecode(s))).toList();
  }

  Future<void> toggle(Article a) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    final encoded = jsonEncode({
      'title': a.title,
      'description': a.description,
      'url': a.url,
      'urlToImage': a.imageUrl,
      'source': {'name': a.source},
      'publishedAt': a.publishedAt?.toIso8601String(),
    });
    if (raw.contains(encoded)) {
      raw.remove(encoded);
    } else {
      raw.add(encoded);
    }
    await prefs.setStringList(_key, raw);
  }

  Future<bool> isFavorite(Article a) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    final encoded = jsonEncode({
      'title': a.title,
      'description': a.description,
      'url': a.url,
      'urlToImage': a.imageUrl,
      'source': {'name': a.source},
      'publishedAt': a.publishedAt?.toIso8601String(),
    });
    return raw.contains(encoded);
  }
}