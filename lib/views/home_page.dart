import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/news_list_view_model.dart';
import '../models/news_article.dart';
import 'detail_page.dart';

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
    _searchController.addListener(() {
      setState(() {});
    });
    _searchFocusNode.addListener(() {
      setState(() {});
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
      FocusScope.of(context).unfocus();
    } else {
      _searchController.clear();
      viewModel.updateQuery('');
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsListViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter News App'),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search News...',
                      prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) {
                      newsViewModel.updateQuery(value);
                    },
                  ),
                ),
                if (_searchFocusNode.hasFocus)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                      ),
                      onPressed: () => _clearSearch(newsViewModel),
                      child: const Text('Cancel'),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child:
                newsViewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: newsViewModel.articles.length,
                      itemBuilder: (context, index) {
                        final NewsArticle article =
                            newsViewModel.articles[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailPage(article: article),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child:
                                        article.imageUrl.isNotEmpty
                                            ? Image.network(
                                              article.imageUrl,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => Container(
                                                    width: 100,
                                                    height: 100,
                                                    color: theme.primaryColor,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                            )
                                            : Container(
                                              width: 100,
                                              height: 100,
                                              color: theme.primaryColor,
                                              child: const Icon(
                                                Icons.image,
                                                color: Colors.white,
                                              ),
                                            ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          article.description,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
