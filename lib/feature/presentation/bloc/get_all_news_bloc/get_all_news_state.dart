part of 'get_all_news_bloc.dart';


abstract class GetAllNewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNewsEmpty extends GetAllNewsState {
  @override
  List<Object?> get props => [];
}

class GetFoodLoading extends GetAllNewsState {
  final List<NewsEntity> oldNewsList;

  GetFoodLoading(this.oldNewsList);

  @override
  List<Object?> get props => [];
}

class GetAllNewsLoaded extends GetAllNewsState {
  final List<NewsEntity> newsList;

  GetAllNewsLoaded(this.newsList);
  @override
  List<Object?> get props => [newsList];
}

class NewsError extends GetAllNewsState {
  final Failure failure;

  NewsError({required this.failure});
  @override
  List<Object?> get props => [failure];
}
