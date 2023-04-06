part of 'get_top_headlines_bloc.dart';


abstract class TopHeadlinesEvent extends Equatable {
  const TopHeadlinesEvent();
  @override
  List<Object?> get props => [];
}

class GetTopHeadlinesEvent extends TopHeadlinesEvent {
  const GetTopHeadlinesEvent();
}
