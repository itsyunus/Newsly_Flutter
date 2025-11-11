import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:newsly/core/app_constants.dart';
import 'package:newsly/models/article.dart';
import 'package:newsly/services/news_service.dart';
import 'package:newsly/widgets/article_card.dart';
import 'package:newsly/widgets/error_view.dart';
import 'package:newsly/widgets/empty_state.dart';
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;
  final _svc = NewsService();
  final _cache = <String, Future<List<Article>>>{};

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: AppConstants.categories.length, vsync: this);
  }

  Future<List<Article>> _load(String cat) {
    return _cache.putIfAbsent(cat, () => _svc.topHeadlines(category: cat));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsly'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabs: [
            for (final c in AppConstants.categories) Tab(text: c[0].toUpperCase() + c.substring(1)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          for (final c in AppConstants.categories)
            FutureBuilder<List<Article>>(
              future: _load(c),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return ErrorView(
                    message: 'Failed to load "$c"',
                    onRetry: () => setState(() => _cache.remove(c)),
                  );
                }
                final items = snap.data ?? [];
                if (items.isEmpty) return const EmptyState();
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final a = items[i];
                    return ArticleCard(
                      article: a,
                      onOpen: () => launchUrlString(a.url, mode: LaunchMode.externalApplication),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: a)),
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}