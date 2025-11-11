import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsly/models/article.dart';
import 'package:newsly/services/ai_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;
  const ArticleDetailScreen({super.key, required this.article});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final _ai = AiService();
  final _tts = FlutterTts();
  Future<String>? _summary;

  @override
  void initState() {
    super.initState();
    _summary = _ai.summarize(widget.article.title, widget.article.description, widget.article.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      floatingActionButton: FutureBuilder<String>(
        future: _summary,
        builder: (context, snap) {
          final canSpeak = snap.hasData && (snap.data ?? '').isNotEmpty;
          return FloatingActionButton.extended(
            onPressed: canSpeak ? () async { await _tts.speak(snap.data!); } : null,
            icon: const Icon(Icons.volume_up),
            label: const Text('Listen'),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.article.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (widget.article.source.isNotEmpty)
              Text(widget.article.source, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => launchUrlString(widget.article.url, mode: LaunchMode.externalApplication),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Source'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<String>(
                future: _summary,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final text = snap.data ?? 'No summary available.';
                  return SingleChildScrollView(child: Text(text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}