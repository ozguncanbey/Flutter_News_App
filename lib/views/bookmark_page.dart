import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/bookmark_service.dart';
import 'detail_page.dart';

final class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

final class _BookmarkPageState extends State<BookmarkPage> {
  final BookmarkService _bookmarkService = BookmarkService();
  List<NewsArticle> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await _bookmarkService.getBookmarks();
    setState(() {
      _bookmarks = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
        elevation: 0,
      ),
      body:
          _bookmarks.isEmpty
              ? const Center(
                child: Text('No bookmarks yet', style: TextStyle(fontSize: 18)),
              )
              : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _bookmarks.length,
                itemBuilder: (context, index) {
                  final NewsArticle article = _bookmarks[index];
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
                            builder: (context) => DetailPage(article: article),
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
                                            (context, error, stackTrace) =>
                                                Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontSize: 12,
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
    );
  }
}
