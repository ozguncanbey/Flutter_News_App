import 'package:flutter/material.dart';
import '../custom_views/empty_state_view.dart' show EmptyStateView;
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
  bool _isEditing = false;

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

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _removeBookmark(String url) async {
    await _bookmarkService.removeBookmark(url);
    await _loadBookmarks();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Bookmark removed',
          style: TextStyle(color: Colors.white), // Yazı rengi beyaz
        ),
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor, // Tema rengi
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.bookmark_remove_rounded : Icons.bookmark_remove_outlined),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadBookmarks,
        child:
            _bookmarks.isEmpty
                ? const EmptyStateView(
                  icon: Icons.bookmarks_outlined,
                  message: 'No bookmarked found',
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _bookmarks.length,
                  itemBuilder: (context, index) {
                    final NewsArticle article = _bookmarks[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Card(
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
                                        (context) =>
                                            DetailPage(article: article),
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
                                              fontSize: 16,
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
                                              fontSize: 14,
                                              color:
                                                  theme
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.color ??
                                                  Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (_isEditing)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 48,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () => _removeBookmark(article.url),
                                child: const Icon(
                                  Icons.bookmark_remove_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
      ),
    );
  }
}
