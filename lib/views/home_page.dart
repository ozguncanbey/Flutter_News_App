import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/news_list_view_model.dart';
import '../models/news_article.dart';
import 'detail_page.dart'; // Detay sayfası

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Hem TextEditingController hem FocusNode dinleyicilerini ekliyoruz.
    _searchController.addListener(() {
      setState(() {}); // Text değiştiğinde UI güncellenir.
    });
    _searchFocusNode.addListener(() {
      setState(() {}); // Focus değişiminde UI güncellenir.
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _clearSearch(NewsListViewModel viewModel) {
    if (_searchController.text.isEmpty) {
      // Metin zaten boşsa, sadece odağı kaldır.
      FocusScope.of(context).unfocus();
    } else {
      // Metin varsa temizle, sorguyu resetle, ve ardından odağı kaldır.
      _searchController.clear();
      viewModel.updateQuery('');
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter News App')),
      body: Column(
        children: [
          // Arama çubuğu ve cancel butonunu aynı satıra koyuyoruz.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // TextField için Expanded widget. FocusNode burada atanıyor.
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Search News...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      newsViewModel.updateQuery(value);
                    },
                  ),
                ),
                // Cancel butonu yalnızca textfield focus aldığında gösterilir.
                if (_searchFocusNode.hasFocus)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => _clearSearch(newsViewModel),
                      child: const Text('Cancel'),
                    ),
                  ),
              ],
            ),
          ),
          // Haber listesini göstermek için:
          Expanded(
            child:
                newsViewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      itemCount: newsViewModel.articles.length,
                      itemBuilder: (context, index) {
                        final NewsArticle article =
                            newsViewModel.articles[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child:
                                article.imageUrl.isNotEmpty
                                    ? Image.network(
                                      article.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                    : Container(
                                      width: 80,
                                      height: 80,
                                      color: Theme.of(context).primaryColor,
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                          title: Text(article.title),
                          subtitle: Text(
                            article.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => DetailPage(article: article),
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
