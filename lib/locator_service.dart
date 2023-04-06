// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news/core/platform/network_info.dart';
import 'package:news/feature/data/datasources/news_local_data_source.dart';
import 'package:news/feature/data/datasources/news_remote_data_source.dart';
import 'package:news/feature/data/repositories/news_repository_impl.dart';
import 'package:news/feature/domain/repositories/news_repository.dart';
import 'package:news/feature/domain/usecases/add_bookmark_usecases.dart';
import 'package:news/feature/domain/usecases/get_all_bookmark_usecases.dart';
import 'package:news/feature/domain/usecases/get_everything_usecases.dart';
import 'package:news/feature/domain/usecases/get_top_headlines_usecases.dart';
import 'package:news/feature/domain/usecases/remove_bookmark_usecases.dart';
import 'package:news/feature/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:news/feature/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(() => NewsBloc(sl(), sl()));
  sl.registerFactory(() => BookmarkBloc(sl(), sl(), sl()));
  //UseCases
  sl.registerLazySingleton(() => GetEverythingUsecases(sl()));
  sl.registerLazySingleton(() => GetTopHeadlinesUsecases(sl()));
  sl.registerLazySingleton(() => GetAllBookmarkUsecases(sl()));
  sl.registerLazySingleton(() => AddBookmarkUsecases(sl()));
  sl.registerLazySingleton(() => RemoveBookmarkUsecases(sl()));
  //Repository
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryUmpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(sl()),
  );
  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    http.Client.new,
  );
  sl.registerLazySingleton(
    InternetConnectionChecker.new,
  );
}
