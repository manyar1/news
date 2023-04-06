
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:news/ui/widgets/bookmark_widget/news_item_widget.dart';

class NewsItemList extends StatelessWidget {
   final NewsEntity news;
  const NewsItemList({super.key, required this.news, });
   void _deleteFromBookmark(BuildContext context) {
    context.read<BookmarkBloc>().add(RemoveBookmarkEvent(removeBookmark: news));
  }
  @override
  Widget build(BuildContext context) {
    return Dismissible(key: ValueKey(news),  background: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => _deleteFromBookmark(context),
              child: NewsItem(news: news,)
              
            );
  }
}
