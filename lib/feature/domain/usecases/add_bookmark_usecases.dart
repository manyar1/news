import 'package:equatable/equatable.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class AddBookmarkUsecases  {
  final NewsRepository bookmarkRepository;

  AddBookmarkUsecases(this.bookmarkRepository);

  Future<void> call(AddBookmarkParamsUsecases params) async {
    return bookmarkRepository.addBookmarks(params.bookmarks);
  }
}

class AddBookmarkParamsUsecases extends Equatable {
  final List<NewsEntity> bookmarks;
  const AddBookmarkParamsUsecases({required this.bookmarks});
  @override
  List<Object?> get props => [bookmarks];
}
