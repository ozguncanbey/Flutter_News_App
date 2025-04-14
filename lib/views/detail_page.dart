import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_article.dart';

class DetailPage extends StatelessWidget {
  final NewsArticle article;

  const DetailPage({super.key, required this.article});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    // URL'i tarayıcıda dış uygulama olarak açmaya çalışıyoruz.
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haber Detayı'),
        actions: [
          // Paylaşma butonu
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('${article.title}\n\n${article.url}');
            },
          ),
          // Favorilere ekleme butonu (işlevsellik eklenebilir)
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Favorilere ekleme işlemi burada yapılabilir.
              // Örneğin, yerel storage veya Provider ile favorileri yönetebilirsiniz.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Haber başlığı
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Eğer görsel URL'i varsa, resmi gösteriyoruz
            article.imageUrl.isNotEmpty
                ? Image.network(article.imageUrl)
                : const SizedBox(),
            const SizedBox(height: 8),
            // Haber açıklaması
            Text(
              article.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            // "Read More" butonu, orijinal haberi açacak
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _launchURL(article.url);
                },
                child: const Text('Read More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
