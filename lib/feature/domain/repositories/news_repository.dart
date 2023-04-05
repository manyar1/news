import 'package:dartz/dartz.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<NewsEntity>>> getAllNews(int page, int pageSize);
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines(int page, int pageSize);
}
