final class NewsArticle {
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  NewsArticle({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  // API'dan gelen JSON verisini NewsArticle modeline dönüştürmek için factory constructor
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(
        json['publishedAt'] ?? DateTime.now().toString(),
      ),
      content: json['content'] ?? '',
    );
  }

  // toJson metodu, NewsArticle modelini JSON formatına dönüştürmek için kullanılır
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
