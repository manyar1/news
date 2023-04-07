import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/colors/app_colors.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:news/ui/pages/news_page.dart';

class NewsCard extends StatelessWidget {
  final NewsEntity news;

  const NewsCard({super.key, required this.news});

  void _addToBookmark(BuildContext context) {
    context.read<BookmarkBloc>().add(AddBookmarkEvent(addBookmark: news));
  }

  void _deleteFromBookmark(BuildContext context) {
    context.read<BookmarkBloc>().add(RemoveBookmarkEvent(removeBookmark: news));
  }

  bool _isFavourite(NewsEntity news, BookmarkState state) {
    if (state is! BookmarkLoaded) {
      return false;
    }

    return state.news.any((bookmarkNews) => bookmarkNews == news);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkBloc, BookmarkState>(builder: (context, state) {
      final isFavourite = _isFavourite(news, state);
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(news: news),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.mainBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(news.urlToImage ??
                    'https://img.alicdn.com/imgextra/i2/6000000000654/O1CN01wTeZKY1GhZeUmF7iw_!!6000000000654-0-tbvideo.jpg'),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      news.description.toString(),
                      style: const TextStyle(color: Colors.white),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      news.publishedAt.toString(),
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              IconButton(
                onPressed: () {
                  if (isFavourite) {
                    _deleteFromBookmark(context);
                  } else {
                    _addToBookmark(context);
                  }
                },
                icon: Icon(isFavourite ? Icons.favorite_rounded : Icons.favorite_outline),
              ),
            ],
          ),
        ),
      );
    });
  }
}
