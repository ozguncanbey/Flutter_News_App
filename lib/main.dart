import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/news_list_view_model.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsListViewModel>(
      create:
          (_) =>
              NewsListViewModel()
                ..fetchNews(), // Başlangıçta haber verilerini çekiyoruz.
      child: MaterialApp(
        title: 'NewsApp',
        theme: ThemeData(
          primaryColor: const Color(0xFF0D47A1), // Örnek: koyu lacivert ton
        ),
        home: const HomePage(),
      ),
    );
  }
}
