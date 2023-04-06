import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecases/usecase.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class GetAllBookmarkUsecases extends UseCase<List<NewsEntity>, GetAllBookmarkParamsUsecases> {
  final NewsRepository newsRepository;

  GetAllBookmarkUsecases(this.newsRepository);
  @override
  Future<Either<Failure, List<NewsEntity>>> call(GetAllBookmarkParamsUsecases params) async {
    return newsRepository.getAllBookmark();
  }
}

class GetAllBookmarkParamsUsecases extends Equatable {
  const GetAllBookmarkParamsUsecases();
  @override
  List<Object?> get props => [];
}
