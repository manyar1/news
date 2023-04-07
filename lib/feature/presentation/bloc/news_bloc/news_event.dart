part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
  @override
  List<Object?> get props => [];
}

class GetEverything extends NewsEvent {
  final Completer? completer;
  const GetEverything({this.completer});
  @override
  List<Object?> get props => [completer];
}

class GetTopHeadlines extends NewsEvent {
  const GetTopHeadlines();
}
