part of 'get_all_news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {
  const GetNewsEvent();
}