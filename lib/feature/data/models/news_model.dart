import 'package:news/feature/data/models/source_model.dart';
import 'package:news/feature/domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel(
      {required source,
      required autor,
      required title,
      required description,
      required url,
      required urlToImage,
      required publishedAt,
      required content})
      : super(
          source: source,
          autor: autor,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: json['source'] != null ? SourceModel.fromJson(json['source']) : null,
      autor: json['autor'] ,
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(json['publishedAt'] ),
      content: json['content'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'autor': autor,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
