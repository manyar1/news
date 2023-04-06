import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    final response = await Dio().get(
      'https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=f87e49db0a194bd9b4e53b3350939100&page=$page&pageSize=$pageSize',
    );
    debugPrint(response.toString());
    if (response.statusCode == 200) {
      final news = json.decode(response.data);
      return news['articles'].map(NewsModel.fromJson).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<NewsModel>> getTopHeadlines(int page, int pageSize) async {
    final response = await Dio().get(
        'GET https://newsapi.org/v2/top-headlines?q=apple&category=business&apiKey=f87e49db0a194bd9b4e53b3350939100&page=$page&pageSize=$pageSize');
    debugPrint(response.toString());
    if (response.statusCode == 200) {
      final news = json.decode(response.data);
      return news['articles'].map(NewsModel.fromJson).toList();
    } else {
      throw ServerException();
    }
  }
}
