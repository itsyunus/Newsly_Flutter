import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newsly/models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final VoidCallback onOpen;
  const ArticleCard({super.key, required this.article, required this.onTap, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                child: Image.network(
                  article.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(width: 120, height: 120, child: Icon(Icons.image_not_supported)),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, style: Theme.of(context).textTheme.titleMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    if (article.publishedAt != null)
                      Text(DateFormat('yMMMd • hh:mm a').format(article.publishedAt!.toLocal()),
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        TextButton.icon(onPressed: onOpen, icon: const Icon(Icons.open_in_new), label: const Text('Open')),
                      ],
                    )
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