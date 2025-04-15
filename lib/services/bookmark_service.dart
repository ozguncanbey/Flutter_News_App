import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_article.dart';

final class BookmarkService {
  static const String _bookmarkKey = 'bookmarked_articles';

  Future<void> addBookmark(NewsArticle article) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    if (!bookmarks.any((item) => item.url == article.url)) {
      bookmarks.add(article);
      final bookmarkJson = bookmarks.map((item) => item.toJson()).toList();
      await prefs.setString(_bookmarkKey, jsonEncode(bookmarkJson));
    }
  }

  Future<void> removeBookmark(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((item) => item.url == url);
    final bookmarkJson = bookmarks.map((item) => item.toJson()).toList();
    await prefs.setString(_bookmarkKey, jsonEncode(bookmarkJson));
  }

  Future<List<NewsArticle>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkJson = prefs.getString(_bookmarkKey);
    if (bookmarkJson == null) return [];
    final List<dynamic> decoded = jsonDecode(bookmarkJson);
    return decoded.map((json) => NewsArticle.fromJson(json)).toList();
  }

  Future<bool> isBookmarked(String url) async {
    final bookmarks = await getBookmarks();
    return bookmarks.any((item) => item.url == url);
  }
}

extension NewsArticleExtension on NewsArticle {
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}
