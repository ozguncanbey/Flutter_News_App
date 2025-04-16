import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_views/empty_state_view.dart' show EmptyStateView;
import '../utils/country_enum.dart';
import '../utils/sort_type_enum.dart';
import '../view_models/news_list_view_model.dart';
import '../models/news_article.dart';
import 'detail_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  SortType _selectedSort = SortType.publishedAt;
  bool _isInitialized = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
    _searchFocusNode.addListener(() {
      setState(() {});
    });

    // ScrollController dinleyicisi: Liste sonuna gelindiğinde daha fazla haber yükle
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < 200 &&
          Provider.of<NewsListViewModel>(context, listen: false).hasMore &&
          !Provider.of<NewsListViewModel>(
            context,
            listen: false,
          ).isLoadingMore) {
        Provider.of<NewsListViewModel>(context, listen: false).fetchMoreNews();
      }
    });

    // İlk yükleme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialized) {
        final viewModel = Provider.of<NewsListViewModel>(
          context,
          listen: false,
        );
        if (viewModel.articles.isEmpty) {
          viewModel.initialize();
        }
        _isInitialized = true;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _clearSearch(NewsListViewModel viewModel) {
    _searchController.clear();
    viewModel.updateQuery('');
    FocusScope.of(context).unfocus();
  }

  Future<void> _refreshNews(NewsListViewModel viewModel) async {
    await viewModel.fetchNews(sortType: _selectedSort);
  }

  void _showSortMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final buttonSize = button.size;
    final buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);

    final position = RelativeRect.fromLTRB(
      buttonPosition.dx + buttonSize.width - 120,
      buttonPosition.dy,
      0,
      0,
    );

    final selected = await showMenu<SortType>(
      context: context,
      position: position,
      items: const [
        PopupMenuItem<SortType>(
          value: SortType.popularity,
          child: Text('Popularity'),
        ),
        PopupMenuItem<SortType>(
          value: SortType.publishedAt,
          child: Text('PublishedAt'),
        ),
      ],
    );

    if (selected != null && selected != _selectedSort) {
      setState(() {
        _selectedSort = selected;
        final viewModel = Provider.of<NewsListViewModel>(
          context,
          listen: false,
        );
        viewModel.changeSortType(selected);
      });
    }
  }

  void _showCountryMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final buttonSize = button.size;
    final buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);

    final position = RelativeRect.fromLTRB(
      buttonPosition.dx + buttonSize.width - 120,
      buttonPosition.dy,
      0,
      0,
    );

    final selected = await showMenu<Country>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<Country>(value: Country.us, child: const Text('US')),
        PopupMenuItem<Country>(value: Country.en, child: const Text('England')),
        PopupMenuItem<Country>(value: Country.tr, child: const Text('Turkey')),
        PopupMenuItem<Country>(value: Country.fr, child: const Text('France')),
        PopupMenuItem<Country>(value: Country.es, child: const Text('Spain')),
        PopupMenuItem<Country>(value: Country.it, child: const Text('Italy')),
        PopupMenuItem<Country>(value: Country.de, child: const Text('Germany')),
      ],
    );

    if (selected != null) {
      final viewModel = Provider.of<NewsListViewModel>(context, listen: false);
      viewModel.updateCountry(selected.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsViewModel = Provider.of<NewsListViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter News App'),
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              _searchController.text.isEmpty ? Icons.flag : Icons.sort,
            ),
            onPressed: () {
              if (_searchController.text.isEmpty) {
                _showCountryMenu(context);
              } else {
                _showSortMenu(context);
              }
            },
            tooltip:
                _searchController.text.isEmpty
                    ? 'Select Country'
                    : 'Sort Articles',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    cursorColor: theme.primaryColor,
                    decoration: InputDecoration(
                      hintText: 'Search News...',
                      prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) {
                      newsViewModel.updateQuery(value);
                    },
                  ),
                ),
                if (_searchFocusNode.hasFocus)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                      ),
                      onPressed: () => _clearSearch(newsViewModel),
                      child: const Text('Cancel'),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child:
                newsViewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                      color: theme.primaryColor,
                      onRefresh: () => _refreshNews(newsViewModel),
                      child:
                          newsViewModel.articles.isEmpty
                              ? const EmptyStateView(
                                icon: Icons.inbox,
                                message: 'No news found',
                              )
                              : ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                itemCount:
                                    newsViewModel.articles.length +
                                    (newsViewModel.hasMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == newsViewModel.articles.length &&
                                      newsViewModel.hasMore) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final NewsArticle article =
                                      newsViewModel.articles[index];
                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12.0),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => DetailPage(
                                                  article: article,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child:
                                                  article.imageUrl.isNotEmpty
                                                      ? Image.network(
                                                        article.imageUrl,
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) => Container(
                                                              width: 100,
                                                              height: 100,
                                                              color:
                                                                  theme
                                                                      .primaryColor,
                                                              child: const Icon(
                                                                Icons
                                                                    .broken_image,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ),
                                                      )
                                                      : Container(
                                                        width: 100,
                                                        height: 100,
                                                        color:
                                                            theme.primaryColor,
                                                        child: const Icon(
                                                          Icons.image,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    article.title,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: theme.primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Text(
                                                    article.description,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          theme
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.color ??
                                                          Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
          ),
        ],
      ),
    );
  }
}
