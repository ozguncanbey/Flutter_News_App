import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/news_list_view_model.dart';
import '../models/news_article.dart';
import 'detail_page.dart'; // Detay sayfasını daha sonra oluşturacağız.

final class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider aracılığıyla NewsListViewModel'e erişiyoruz.
    final newsViewModel = Provider.of<NewsListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Favoriler sayfası için yönlendirme yapılacak.
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama çubuğu: Kullanıcı arama yaparken metin değiştikçe updateQuery metodu çağrılır.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Haber Ara...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                newsViewModel.updateQuery(value);
              },
            ),
          ),
          // Haber listesini göstermek için:
          Expanded(
            child: newsViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: newsViewModel.articles.length,
                    itemBuilder: (context, index) {
                      final NewsArticle article = newsViewModel.articles[index];
                      return ListTile(
                        title: Text(article.title),
                        subtitle: Text(
                          article.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          // Haber detaylarına geçiş: Detay sayfasını oluşturduğunuzda, geçiş burada gerçekleşecek.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(article: article),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
