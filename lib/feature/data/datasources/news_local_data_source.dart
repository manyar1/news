import 'dart:convert';
import 'dart:developer';

import 'package:news/core/error/exeptions.dart';
import 'package:news/feature/data/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsModel>> getLastNewsFromCashe();
  Future<void> newsToCashe(List<NewsModel> news);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences sharedPreferences;

  NewsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<NewsModel>> getLastNewsFromCashe() {
    final jsonNewsList = sharedPreferences.getStringList('CACHED_NEWS_LIST');
    if (jsonNewsList!.isNotEmpty) {
      return Future.value(jsonNewsList
          .map((item) => NewsModel.fromJson(json.decode(item)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> newsToCashe(List<NewsModel> news) {
    final List<String> jsonNewsList =
        news.map((item) => jsonEncode(item.toJson())).toList();
    sharedPreferences.setStringList('CACHED_NEWS_LIST', jsonNewsList);
    log('News to write Cache: ${jsonNewsList.length}');
    return Future.value(jsonNewsList);
  }
}
