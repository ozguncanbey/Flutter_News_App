import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../models/news_article.dart';
import '../services/bookmark_service.dart';

final class DetailPage extends StatefulWidget {
  final NewsArticle article;

  const DetailPage({super.key, required this.article});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

final class _DetailPageState extends State<DetailPage> {
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final isBookmarked = await BookmarkService().isBookmarked(
      widget.article.url,
    );
    setState(() {
      _isBookmarked = isBookmarked;
    });
  }

  Future<void> _toggleBookmark() async {
    final bookmarkService = BookmarkService();
    if (_isBookmarked) {
      await bookmarkService.removeBookmark(widget.article.url);
    } else {
      await bookmarkService.addBookmark(widget.article);
    }
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _shareArticle() {
    Share.share('${widget.article.title}\n${widget.article.url}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.white,
            onPressed: _shareArticle,
          ),
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            color: Colors.white,
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.article.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 16.0),
            if (widget.article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.article.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 200,
                        color: theme.primaryColor,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                ),
              ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.article.author.isNotEmpty
                      ? widget.article.author
                      : 'Unknown Author',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(widget.article.publishedAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.article.description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.article.content.isNotEmpty
                  ? widget.article.content
                  : 'No content available',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
            const SizedBox(height: 16.0),
            if (widget.article.url.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => _launchUrl(widget.article.url),
                  child: Text(
                    'Read More',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
