import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecases/usecase.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class GetTopHeadlinesUsecases extends UseCase<List<NewsEntity>, PageTopHeadlinesParamsUsecases>{
  final NewsRepository newsRepository;

  GetTopHeadlinesUsecases(this.newsRepository);
  @override
  Future<Either<Failure, List<NewsEntity>>> call(PageTopHeadlinesParamsUsecases params) async{
    return newsRepository.getAllNews(params.page, params.pageSize);
  }
}
class PageTopHeadlinesParamsUsecases extends Equatable{
  final int page;
  final int pageSize;

  const PageTopHeadlinesParamsUsecases({required this.page, required this.pageSize});
  @override
  List<Object?> get props => [
    page, pageSize,
  ];
}
