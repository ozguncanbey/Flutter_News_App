import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/news_list_view_model.dart';
import 'views/bookmark_page.dart';
import 'views/home_page.dart';
import 'utils/sort_type_enum.dart';

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
              NewsListViewModel(), // initialize() çağrısı HomePage'de yapılacak
      child: MaterialApp(
        title: 'NewsApp',
        theme: ThemeData(
          primaryColor: const Color(0xFF0D47A1), // Mevcut tema rengi korundu
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, // primaryColor ile uyumlu
          ).copyWith(
            primary: const Color(0xFF0D47A1), // RefreshIndicator için
            secondary: const Color(0xFF0D47A1),
          ),
          textTheme: const TextTheme(
            bodySmall: TextStyle(color: Colors.grey),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          useMaterial3: true,
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

  // PageView için bir controller
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Sayfa geçişlerinde animasyon ekledik
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack yerine PageView kullanarak sayfaların durumlarını koruyoruz
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Kaydırarak geçişi engelliyoruz
        children: const [HomePage(), BookmarkPage()],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
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
