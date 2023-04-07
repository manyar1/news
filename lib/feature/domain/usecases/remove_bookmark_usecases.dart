import 'package:equatable/equatable.dart';

import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class RemoveBookmarkUsecases {
  final NewsRepository bookmarkRepository;

  RemoveBookmarkUsecases(this.bookmarkRepository);

  Future<void> call(RemoveBookmarkParamsUsecases params) async {
    return bookmarkRepository.removeBookmark(params.bookmarks);
  }
}

class RemoveBookmarkParamsUsecases extends Equatable {
  final List<NewsEntity> bookmarks;
  const RemoveBookmarkParamsUsecases({required this.bookmarks});
  @override
  List<Object?> get props => [bookmarks];
}
