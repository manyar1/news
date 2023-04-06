import 'package:dartz/dartz.dart';
import 'package:news/core/error/exeptions.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/core/platform/network_info.dart';
import 'package:news/feature/data/datasources/news_local_data_source.dart';
import 'package:news/feature/data/datasources/news_remote_data_source.dart';
import 'package:news/feature/data/models/news_model.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';

class NewsRepositoryUmpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryUmpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<NewsEntity>>> getEverything(int page, int pageSize) async {
    try {
      final remoteNews = await remoteDataSource.getEverything(page, pageSize);
      return Right(remoteNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getTopHeadlines(int page, int pageSize) async {
    try {
      final remoteNews = await remoteDataSource.getTopHeadlines(page, pageSize);
      return Right(remoteNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<void> addBookmarks(List<NewsEntity> bookmarks) async{

    bookmarks as List<NewsModel>;
    await localDataSource.setNewsToCache(bookmarks);
    
  }
  
  @override
  Future<Either<Failure, List<NewsEntity>>> getAllBookmark() async{
   try {
    final cachedNews= await localDataSource.getCachedNews();
    return Right(cachedNews);
   }on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<void> removeBookmark(List<NewsEntity> bookmarks) async {
     bookmarks as List<NewsModel>;
    await localDataSource.setNewsToCache(bookmarks);
  }
}
