
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/feature/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/ui/widgets/news_card.dart';

class EverythingList extends StatefulWidget {
  const EverythingList({super.key});

  @override
  State<EverythingList> createState() => _EverythingListState();
}

class _EverythingListState extends State<EverythingList> {
  @override
  Widget build(BuildContext context) {
    context.read<NewsBloc>().add(const GetEverything());
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state){
        if (state is NewsLoaded){
          final everythingNews = state.everythingNews;
           return RefreshIndicator(
            onRefresh: () async {
            setState(() {});
          },
             child: SingleChildScrollView(
                     physics: const BouncingScrollPhysics(),
                     child: ListView.builder(
               physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: everythingNews.length,
                itemBuilder: (context, index) {
                  if (index < everythingNews.length) {
                    return NewsCard(
                      news: everythingNews[index],
                    );
                  } else {
                    return Container();
                  }
                }),
                   ),
           );
        }
        return _loadingindicator();
      }
    );
  }
}

Widget _loadingindicator() {
  return const Padding(
    padding: EdgeInsets.all(8),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
