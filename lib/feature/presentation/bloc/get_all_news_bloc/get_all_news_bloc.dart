import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/usecases/get_all_news_usecases.dart';

part 'get_all_news_event.dart';
part 'get_all_news_state.dart';

class AllNewsBloc extends Bloc<GetNewsEvent, GetAllNewsState>{
  final GetAllNewsUsecases getAllNews;

  AllNewsBloc(this.getAllNews):super(GetNewsEmpty()){
    _setupEvents();
  }
   void _setupEvents() {
    on<GetNewsEvent>(_onGetTopHeadlines, transformer: droppable());
  }
   Future<void> _onGetTopHeadlines(NewsEvent event, Emitter emit) async {
    final response = await getAllNews(const PageNewsParamsUsecases (page: , pageSize: ));
    await response.fold((failure) => _onStateFailure(emit, failure),
        (news) => _onGetFoodSuccessful(emit, news));
  }
  Future<void> _onStateFailure(Emitter emit, Failure failure) async {
    emit(NewsError(failure: failure));
  }

  Future<void> _onGetFoodSuccessful(
      Emitter emit, List<NewsEntity> headlines) async {
    emit(GetAllNewsLoaded(headlines));
  }
}
