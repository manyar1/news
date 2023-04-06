import 'package:news/feature/domain/entities/news_entity.dart';

class SourceModel extends SourceEntity {
  SourceModel({id, name}) : super(id: id, name: name);
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
