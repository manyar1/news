import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final SourceEntity source;
  final String autor;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  const NewsEntity({
    required this.source,
    required this.autor,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [source, autor, title, description, url, urlToImage, publishedAt, content];
}

class SourceEntity {
  final String id;
  final String name;
  const SourceEntity({required this.id, required this.name});
}
