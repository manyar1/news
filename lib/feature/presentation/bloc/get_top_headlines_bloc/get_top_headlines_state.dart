part of 'get_top_headlines_bloc.dart';

abstract class GetTopHeadlinesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTopHeadlinesEmpty extends GetTopHeadlinesState {
  @override
  List<Object?> get props => [];
}

class GetTopHeadlinesLoading extends GetTopHeadlinesState {
  final List<NewsEntity> oldNewsList;

  GetTopHeadlinesLoading(this.oldNewsList);

  @override
  List<Object?> get props => [];
}

class GetTopHeadlinesLoaded extends GetTopHeadlinesState {
  final List<NewsEntity> newsList;

  GetTopHeadlinesLoaded(this.newsList);
  @override
  List<Object?> get props => [newsList];
}

class TopHeadlinesError extends GetTopHeadlinesState {
  final Failure failure;

  TopHeadlinesError({required this.failure});
  @override
  List<Object?> get props => [failure];
}
