part of 'bookmark_bloc.dart';

abstract class BookmarkState extends Equatable {
  const BookmarkState();
  @override
  List<Object?> get props => [];
}

class BookmarkLoaded extends BookmarkState {
  final List<NewsEntity> news;

  const BookmarkLoaded({required this.news});

  @override
  List<Object?> get props => [news];
}

class BookmarkLoading extends BookmarkState {
  const BookmarkLoading();
  @override
  List<Object?> get props => [];
}

class BookmarkFailure extends BookmarkState {
  final Failure failure;

  const BookmarkFailure({required this.failure});
  @override
  List<Object?> get props => [failure];
}
