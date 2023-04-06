import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/usecases/get_everything_usecases.dart';
import 'package:news/feature/domain/usecases/get_top_headlines_usecases.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetEverythingUsecases getEverything;
  final GetTopHeadlinesUsecases getTopHeadlines;

  NewsBloc(this.getEverything, this.getTopHeadlines) : super(const NewsLoading(oldNewsList: [])) {
    _setupEvents();
  }
  void _setupEvents() {
    on<GetEverything>(_onGetEverything, transformer: droppable());
    on<GetTopHeadlines>(_onGetTopHeadlines, transformer: droppable());
  }

  Future<void> _onGetEverything(GetEverything event, Emitter emit) async {
    final response = await getEverything(const PageNewsParamsUsecases(page: 0, pageSize: 15));
    await response.fold(
      (failure) => _onStateFailure(emit, failure),
      (news) => _onGetEverythingSuccessful(emit, news),
    );
  }

  Future<void> _onGetEverythingSuccessful(Emitter emit, List<NewsEntity> everything) async {
    final prevState = state;
    if (prevState is! NewsLoaded ){
      emit(NewsLoaded(topHeadlinesNews: const [], everythingNews: everything));
    }
    else{
      emit(prevState.copywith(everythingNews: everything));
    }
    
  }

  Future<void> _onGetTopHeadlines(GetTopHeadlines event, Emitter emit) async {
    final response = await getTopHeadlines(const PageTopHeadlinesParamsUsecases(page: 0, pageSize: 15));
    await response.fold(
      (failure) => _onStateFailure(emit, failure),
      (news) => _onGetTopHeadlinesSuccessful(emit, news),
    );
  }

  Future<void> _onGetTopHeadlinesSuccessful(Emitter emit, List<NewsEntity> headlines) async {
     final prevState = state;
     if (prevState is! NewsLoaded ){
      emit(NewsLoaded(topHeadlinesNews: headlines, everythingNews: const []));
    }
    else{
      emit(prevState.copywith(topHeadlinesNews: headlines));
    }
  }
  

  Future<void> _onStateFailure(Emitter emit, Failure failure) async {
    emit(NewsError(failure: failure));
  }

  
}
