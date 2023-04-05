import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/usecases/usecase.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class GetAllNewsUsecases extends UseCase<List<NewsEntity>, PageNewsParamsUsecases>{
  final NewsRepository newsRepository;

  GetAllNewsUsecases(this.newsRepository);
  @override
  Future<Either<Failure, List<NewsEntity>>> call(PageNewsParamsUsecases params) async{
    return newsRepository.getAllNews(params.page, params.pageSize);
  }
}

class PageNewsParamsUsecases extends Equatable{
  final int page;
  final int pageSize;

  const PageNewsParamsUsecases({required this.page, required this.pageSize});
  @override
  List<Object?> get props => [
    page, pageSize,
  ];
}
