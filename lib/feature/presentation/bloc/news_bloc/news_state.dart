part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  final List<NewsEntity> oldNewsList;

  const NewsLoading({required this.oldNewsList});

  @override
  List<Object?> get props => [oldNewsList];
}

class NewsLoaded extends NewsState {
  final List<NewsEntity> everythingNews;
  final List<NewsEntity> topHeadlinesNews;

  const NewsLoaded({required this.topHeadlinesNews, required this.everythingNews});

  NewsLoaded copywith({List<NewsEntity>? everythingNews, List<NewsEntity>? topHeadlinesNews}) {
    return NewsLoaded(
        topHeadlinesNews: topHeadlinesNews ?? this.topHeadlinesNews,
        everythingNews: everythingNews ?? this.everythingNews);
  }

  @override
  List<Object?> get props => [everythingNews];
}

class NewsError extends NewsState {
  final Failure failure;

  const NewsError({required this.failure});
  @override
  List<Object?> get props => [failure];
}
