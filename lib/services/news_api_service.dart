import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

final class NewsApiService {
  
  final String _apiKey = 'fe5dd6ca68374ea4aff8c73550a00aaf';
  final String _baseUrl = 'https://newsapi.org/v2';

  // 'query' parametresi boş bırakılırsa, ülkenin (örneğimizde "us") top headlines getirilecek.
  Future<List<NewsArticle>> fetchTopHeadlines({String? query}) async {
    final String url = (query == null || query.isEmpty)
        ? '$_baseUrl/top-headlines?country=us&apiKey=$_apiKey'
        : '$_baseUrl/everything?q=$query&apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];
      // Gelen JSON listesini, NewsArticle modeline dönüştürerek geri döndür.
      return articlesJson.map((articleJson) => NewsArticle.fromJson(articleJson)).toList();
    } else {
      throw Exception('Haberler alınırken hata oluştu: ${response.statusCode}');
    }
  }
}
