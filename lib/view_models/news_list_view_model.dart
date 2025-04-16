import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_api_service.dart';
import '../utils/sort_type_enum.dart';

final class NewsListViewModel extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  SortType _currentSortType = SortType.publishedAt; // Varsayılan sıralama
  String? _currentQuery;
  String _currentCountry = 'us'; // Varsayılan ülke
  int _currentPage = 1;
  int _pageSize = 20;
  int _totalResults = 0;

  // Getter'lar
  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  SortType get currentSortType => _currentSortType;
  String get currentCountry => _currentCountry;
  bool get hasMore => _articles.length < _totalResults;

  // Haberleri API'den çekmek için (ilk sayfa)
  Future<void> fetchNews({String? query, SortType? sortType}) async {
    _isLoading = true;
    _currentPage = 1;
    _articles = [];
    notifyListeners();

    try {
      final trimmedQuery = (query ?? '').trim();

      // Eğer query boşsa, _currentQuery'yi temizle ve sortType’ı zorunlu olarak publishedAt yap
      if (trimmedQuery.isEmpty) {
        _currentQuery = '';
        _currentSortType = SortType.publishedAt;
      } else {
        _currentQuery = trimmedQuery;
        if (sortType != null) {
          _currentSortType = sortType;
        }
      }

      final result = await _newsApiService.fetchTopHeadlines(
        query: (_currentQuery?.isEmpty ?? true) ? null : _currentQuery,
        sortType: _currentSortType,
        country: _currentCountry,
        page: _currentPage,
        pageSize: _pageSize,
      );

      _articles = result['articles'] as List<NewsArticle>;
      _totalResults = result['totalResults'] as int;
    } catch (e) {
      log(e.toString(), name: "fetchNewsError");
      _articles = [];
      _totalResults = 0;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Daha fazla haber çekmek için (sonraki sayfalar)
  Future<void> fetchMoreNews() async {
    if (_isLoadingMore || !hasMore) return;

    _isLoadingMore = true;
    _currentPage++;
    notifyListeners();

    try {
      final result = await _newsApiService.fetchTopHeadlines(
        query: _currentQuery,
        sortType: _currentSortType,
        country: _currentCountry,
        page: _currentPage,
        pageSize: _pageSize,
      );

      _articles.addAll(result['articles'] as List<NewsArticle>);
      _totalResults = result['totalResults'] as int;
    } catch (e) {
      log(e.toString(), name: "fetchMoreNewsError");
      _currentPage--; // Hata olursa sayfayı geri al
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  // Arama çubuğundan gelen query'yi güncellemek
  void updateQuery(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery != _currentQuery) {
      fetchNews(query: trimmedQuery.isEmpty ? null : trimmedQuery);
    }
  }

  // Sıralama tipini değiştirmek
  void changeSortType(SortType sortType) {
    if (sortType != _currentSortType) {
      // Mevcut sorguyu kaybetmemek için, _currentQuery boş değilse gönderiyoruz.
      fetchNews(
        query:
            (_currentQuery != null && _currentQuery!.isNotEmpty)
                ? _currentQuery
                : null,
        sortType: sortType,
      );
    }
  }

  // Ülke bilgisini güncellemek
  void updateCountry(String country) {
    if (country != _currentCountry) {
      _currentCountry = country;
      fetchNews();
    }
  }

  // İlk yükleme için
  void initialize() {
    if (_articles.isEmpty && !_isLoading) {
      fetchNews();
    }
  }
}
