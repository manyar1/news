import 'package:news/core/error/exeptions.dart';
import 'package:news/core/platform/network_info.dart';
import 'package:news/feature/data/datasources/news_local_data_source.dart';
import 'package:news/feature/data/datasources/news_remote_data_source.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class NewsRepositoryUmpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryUmpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<NewsEntity>>> getAllNews(
      int page, int pageSize) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await remoteDataSource.getAllNews(page, pageSize);
        await localDataSource.newsToCashe(remoteNews);
        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastNewsFromCashe();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines(
      int page, int pageSize) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews =
            await remoteDataSource.getTopHeadlines(page, pageSize);
        await localDataSource.newsToCashe(remoteNews);
        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastNewsFromCashe();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
