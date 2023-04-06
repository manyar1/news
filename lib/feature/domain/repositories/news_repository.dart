import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getEverything(int page, int pageSize);
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines(int page, int pageSize);
  Future<void> addBookmarks(List<NewsEntity> bookmarks);
  Future<void> removeBookmark(List<NewsEntity> bookmarks);
  Future<Either<Failure, List<NewsEntity>>> getAllBookmark();
}
