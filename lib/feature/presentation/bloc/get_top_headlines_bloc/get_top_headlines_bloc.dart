import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/usecases/get_top_headlines_usecases.dart';

part 'get_top_headlines_event.dart';
part 'get_top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<GetTopHeadlinesEvent, GetTopHeadlinesState>{
  final GetTopHeadlinesUsecases getTopHeadlines;

  TopHeadlinesBloc(this.getTopHeadlines):super(GetTopHeadlinesEmpty()){
    _setupEvents();
  }
   void _setupEvents() {
    on<GetTopHeadlinesEvent>(_onGetTopHeadlines, transformer: droppable());
  }
   Future<void> _onGetTopHeadlines(TopHeadlinesEvent event, Emitter emit) async {
    final response = await getTopHeadlines(const PageTopHeadlinesParamsUsecases(page: , pageSize: ));
    await response.fold((failure) => _onStateFailure(emit, failure),
        (headlines) => _onGetFoodSuccessful(emit, headlines));
  }
  Future<void> _onStateFailure(Emitter emit, Failure failure) async {
    emit(TopHeadlinesError(failure: failure));
  }

  Future<void> _onGetFoodSuccessful(
      Emitter emit, List<NewsEntity> headlines) async {
    emit(GetTopHeadlinesLoaded(headlines));
  }
}
