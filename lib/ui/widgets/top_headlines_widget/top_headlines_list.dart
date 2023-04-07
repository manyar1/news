import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/feature/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/ui/widgets/news_card.dart';

class TopHeadlinesList extends StatefulWidget {
  const TopHeadlinesList({super.key});

  @override
  State<TopHeadlinesList> createState() => _TopHeadlinesListState();
}

class _TopHeadlinesListState extends State<TopHeadlinesList> {
  Timer? timer;

  void initTimer() {
    if (timer != null && timer!.isActive) return;

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      context.read<NewsBloc>().add(const GetTopHeadlines());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initTimer();
    context.read<NewsBloc>().add(const GetTopHeadlines());
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsLoaded) {
        final topHeadlinesNews = state.topHeadlinesNews;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: topHeadlinesNews.length,
            itemBuilder: (context, index) {
              if (index < topHeadlinesNews.length) {
                return NewsCard(
                  news: topHeadlinesNews[index],
                );
              } else {
                return Container();
              }
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        );
      }
      return _loadingindicator();
    });
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
