import 'dart:convert';
import 'dart:developer';

import 'package:news/feature/data/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalDataSource {
  Future<List<NewsModel>> getCachedNews();
  Future<void> setNewsToCache(List<NewsModel> news);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final SharedPreferences sharedPreferences;

  NewsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<NewsModel>> getCachedNews() async {
    final jsonNewsList = sharedPreferences.getStringList('CACHED_NEWS_LIST');
    if (jsonNewsList == null || jsonNewsList.isEmpty) return Future.value([]);

    return Future.value(jsonNewsList.map((jsonNews) => NewsModel.fromJson(json.decode(jsonNews))).toList());
  }

  @override
  Future<void> setNewsToCache(List<NewsModel> news) async {
    final jsonNewsList = news.map((news) => json.encode(news.toJson())).toList();

    await sharedPreferences.setStringList('CACHED_NEWS_LIST', jsonNewsList);
    log('News to write Cache: ${jsonNewsList.length}');
  }
}
