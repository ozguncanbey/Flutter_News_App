import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_api_service.dart';

final class NewsListViewModel extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();
  
  List<NewsArticle> _articles = [];
  bool _isLoading = false;

  // UI tarafında haberlere ve loading durumuna erişim sağlamak için getter'lar:
  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;

  // Haberleri API'den çekmek için metot, query parametresi isteğe bağlı:
  Future<void> fetchNews({String? query}) async {
    _isLoading = true;
    notifyListeners(); // UI'da loading göstergesi tetiklenir

    try {
      _articles = await _newsApiService.fetchTopHeadlines(query: query);
    } catch (e) {
      // Hata yönetimi yapabilirsiniz (örneğin, snackBar ile bildirmek)
      log(e.toString(), name: "fetchNewsError");
    } finally {
      _isLoading = false;
      notifyListeners(); // Haberler yüklendiğinde UI güncellenir
    }
  }

  // Arama çubuğundan gelen query'yi güncellemek ve haberleri yeniden çekmek için:
  void updateQuery(String query) {
    fetchNews(query: query);
  }
}
