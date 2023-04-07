import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:news/core/error/exeptions.dart';
import 'package:news/feature/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getEverything(int page, int pageSize);
  Future<List<NewsModel>> getTopHeadlines(int page, int pageSize);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<NewsModel>> getEverything(int page, int pageSize) async {
    try {
      final response = await Dio().get(
        'https://newsapi.org/v2/everything?q=apple&apiKey=38823f356abb4c6d9fa19f68dd78b40b&page=$page&pageSize=$pageSize',
      );
      if (response.statusCode == 200) {
        return response.data['articles'].map<NewsModel>((article) => NewsModel.fromJson(article)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('$e');
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getTopHeadlines(int page, int pageSize) async {
    try {
      final response = await Dio().get(
          'https://newsapi.org/v2/top-headlines?q=apple&apiKey=38823f356abb4c6d9fa19f68dd78b40b&page=$page&pageSize=$pageSize');

      if (response.statusCode == 200) {
        return response.data['articles'].map<NewsModel>((article) => NewsModel.fromJson(article)).toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('$e');
      throw ServerException();
    }
  }
}
