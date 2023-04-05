import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/core/error/exeptions.dart';
import 'package:news/feature/data/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getAllNews(int page, int pageSize);
  Future<List<NewsModel>> getTopHeadlines(int page, int pageSize);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;

  NewsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<NewsModel>> getAllNews(int page, int pageSize) async {
    final response = await Dio().get(
      'https://newsapi.org/v2/everything?q=apple&from=2023-04-04&to=2023-04-04&sortBy=popularity&apiKey=f87e49db0a194bd9b4e53b3350939100/?page=$page/?pageSize=$pageSize',
    );
    debugPrint(response.toString());
    if (response.statusCode == 200) {
      final news = json.decode(response.data);
      return (news['articles'] as List)
          .map((news) => NewsModel.fromJson(news))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getTopHeadlines(int page, int pageSize) async {
    final response = await Dio().get(
        'GET https://newsapi.org/v2/top-headlines?category=business&apiKey=f87e49db0a194bd9b4e53b3350939100/?page=$page/?pageSize=$pageSize');
    debugPrint(response.toString());
    if (response.statusCode == 200) {
      final news = json.decode(response.data);
      return (news['articles'] as List)
          .map((news) => NewsModel.fromJson(news))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
