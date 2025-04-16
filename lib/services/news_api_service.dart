import 'dart:convert';
import 'package:flutter_news_app/config/config.dart';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';
import '../utils/sort_type_enum.dart';

final class NewsApiService {
  final String _apiKey = apiKey;
  final String _baseUrl = 'https://newsapi.org/v2';

  // 'query' parametresi boş bırakılırsa, ülkenin (örneğimizde "us") top headlines getirilecek.
  // 'sortType' ile sıralama türü belirtilir (popularity veya publishedAt).
  Future<Map<String, Object>> fetchTopHeadlines({
    String? query,
    required SortType sortType,
    String? country,
    int page = 1,
    int pageSize = 20,
  }) async {
    String url;
    if (query == null || query.isEmpty) {
      // top-headlines için publishedAt varsayılan sıralama
      url =
          '$_baseUrl/top-headlines?country=$country&apiKey=$_apiKey&page=$page&pageSize=$pageSize';
    } else {
      // everything endpoint'i için sortBy parametresi
      final sortBy =
          sortType == SortType.popularity ? 'popularity' : 'publishedAt';
      url =
          '$_baseUrl/everything?q=$query&sortBy=$sortBy&apiKey=$_apiKey&page=$page&pageSize=$pageSize';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];
      return {
        'articles':
            articlesJson
                .map((articleJson) => NewsArticle.fromJson(articleJson))
                .toList(),
        'totalResults': jsonData['totalResults'] as int,
      };
    } else {
      throw Exception('Haberler alınırken hata oluştu: ${response.statusCode}');
    }
  }
}
