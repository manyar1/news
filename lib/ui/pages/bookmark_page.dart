import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:news/ui/widgets/bookmark_widget/news_item_list_widget.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});
  void _getAllBookmark(BuildContext context) {
    context.read<BookmarkBloc>().add(const GetAllBookmarkEvent());
  }

  @override
  Widget build(BuildContext context) {
    _getAllBookmark(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Закладки',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<BookmarkBloc, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkLoaded) {
            final news = state.news;
            return Column(
              children: <Widget>[
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    itemCount: _length(news),
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      return NewsItemList(news: news[index]);
                    },
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  int _length(List<NewsEntity> news) {
    final setFoods = news.toSet();
    return setFoods.length;
  }
}
