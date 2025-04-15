import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_api_service.dart';
import '../utils/sort_type_enum.dart';

final class NewsListViewModel extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  SortType _currentSortType = SortType.publishedAt; // Default sort type
  String? _currentQuery;

  // UI tarafında haberlere ve loading durumuna erişim sağlamak için getter'lar:
  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  SortType get currentSortType => _currentSortType;

  // Haberleri API'den çekmek için metot, query ve sortType parametreleri:
  Future<void> fetchNews({String? query, SortType? sortType}) async {
    _isLoading = true;
    notifyListeners(); // UI'da loading göstergesi tetiklenir

    try {
      // Query ve sort type'ı güncelle
      _currentQuery = query;
      if (sortType != null) {
        _currentSortType = sortType;
      }

      // API servisini çağır - her zaman sort type değerini gönder
      _articles = await _newsApiService.fetchTopHeadlines(
        query: _currentQuery,
        sortType: _currentSortType, // Bu parametre her zaman gönderilmeli
      );
    } catch (e) {
      // Hata yönetimi yapabilirsiniz (örneğin, snackBar ile bildirmek)
      log(e.toString(), name: "fetchNewsError");
      _articles = []; // Hata durumunda liste temizlenebilir
    } finally {
      _isLoading = false;
      notifyListeners(); // Haberler yüklendiğinde UI güncellenir
    }
  }

  // Arama çubuğundan gelen query'yi güncellemek ve haberleri yeniden çekmek için:
  void updateQuery(String query) {
    // Mevcut sıralama tipini korur
    fetchNews(query: query, sortType: _currentSortType);
  }

  // Sıralama tipini değiştirmek için:
  void changeSortType(SortType sortType) {
    if (sortType != _currentSortType) {
      fetchNews(query: _currentQuery, sortType: sortType);
    }
  }

  // İlk yükleme için:
  void initialize() {
    fetchNews(sortType: _currentSortType);
  }
}
