import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/news_list_view_model.dart';
import 'views/bookmark_page.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsListViewModel>(
      create: (_) => NewsListViewModel()..fetchNews(),
      child: MaterialApp(
        title: 'NewsApp',
        theme: ThemeData(
          primaryColor: const Color(0xFF0D47A1),
          textTheme: const TextTheme(
            bodySmall: TextStyle(color: Colors.grey),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: const MainNavigation(),
      ),
    );
  }
}

final class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

final class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomePage(), const BookmarkPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
