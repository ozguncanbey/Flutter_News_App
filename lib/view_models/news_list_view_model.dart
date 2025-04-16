import 'dart:developer';
import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_api_service.dart';
import '../utils/sort_type_enum.dart';

final class NewsListViewModel extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  SortType _currentSortType = SortType.publishedAt; // Varsayılan sıralama
  String? _currentQuery;
  String _currentCountry = 'us'; // Varsayılan ülke

  // Getter'lar:
  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  SortType get currentSortType => _currentSortType;
  String get currentCountry => _currentCountry;

  // Haberleri API'den çekmek için; country bilgisi de gönderiliyor.
  Future<void> fetchNews({String? query, SortType? sortType}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Query ve sortType'ı güncelle
      _currentQuery = query;
      if (sortType != null) {
        _currentSortType = sortType;
      }

      // Servis çağrısı; eğer query boşsa, serviste country parametresine göre top-headlines getirilecek.
      _articles = await _newsApiService.fetchTopHeadlines(
        query: _currentQuery,
        sortType: _currentSortType,
        country:
            _currentCountry, // Servis içerisinde country parametresi olarak kullanılıyor
      );
    } catch (e) {
      log(e.toString(), name: "fetchNewsError");
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Arama çubuğundan gelen query'yi güncellemek ve haberleri yeniden çekmek için:
  void updateQuery(String query) {
    fetchNews(query: query, sortType: _currentSortType);
  }

  // Sıralama tipini değiştirmek için:
  void changeSortType(SortType sortType) {
    if (sortType != _currentSortType) {
      fetchNews(query: _currentQuery, sortType: sortType);
    }
  }

  // Ülke bilgisini güncellemek için:
  void updateCountry(String country) {
    _currentCountry = country;
    fetchNews(query: _currentQuery, sortType: _currentSortType);
  }

  // İlk yükleme için:
  void initialize() {
    fetchNews(sortType: _currentSortType);
  }
}
