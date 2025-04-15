import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';
import '../utils/sort_type_enum.dart';

final class NewsApiService {
  final String _apiKey = 'fe5dd6ca68374ea4aff8c73550a00aaf';
  final String _baseUrl = 'https://newsapi.org/v2';

  // 'query' parametresi boş bırakılırsa, ülkenin (örneğimizde "us") top headlines getirilecek.
  // 'sortType' ile sıralama türü belirtilir (popularity veya publishedAt).
  Future<List<NewsArticle>> fetchTopHeadlines({
    String? query,
    required SortType sortType,
  }) async {
    String url;
    if (query == null || query.isEmpty) {
      if (sortType == SortType.popularity) {
        // top-headlines sortBy desteklemiyor, popularity için everything kullan
        url =
            '$_baseUrl/everything?q=general&sortBy=popularity&apiKey=$_apiKey';
      } else {
        // top-headlines için publishedAt varsayılan sıralama
        url = '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey';
      }
    } else {
      // everything endpoint'i için sortBy parametresi
      final sortBy =
          sortType == SortType.popularity ? 'popularity' : 'publishedAt';
      url = '$_baseUrl/everything?q=$query&sortBy=$sortBy&apiKey=$_apiKey';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];
      return articlesJson
          .map((articleJson) => NewsArticle.fromJson(articleJson))
          .toList();
    } else {
      throw Exception('Haberler alınırken hata oluştu: ${response.statusCode}');
    }
  }
}
