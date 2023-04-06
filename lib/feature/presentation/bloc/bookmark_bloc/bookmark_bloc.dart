import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/error/failure.dart';
import 'package:news/feature/domain/entities/news_entity.dart';
import 'package:news/feature/domain/usecases/add_bookmark_usecases.dart';
import 'package:news/feature/domain/usecases/get_all_bookmark_usecases.dart';
import 'package:news/feature/domain/usecases/remove_bookmark_usecases.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final AddBookmarkUsecases addBookmark;
  final RemoveBookmarkUsecases removeBookmark;
  final GetAllBookmarkUsecases getAllBookmark;

  BookmarkBloc(this.addBookmark, this.removeBookmark, this.getAllBookmark) : super(BookmarkLoading()) {
    _setupEvents();
  }

  void _setupEvents() {
    on<AddBookmarkEvent>(_addBookmark, transformer: droppable());
    on<RemoveBookmarkEvent>(_removeBookmark, transformer: droppable());
    on<GetAllBookmarkEvent>(_getAllBookmark, transformer: droppable());
  }

  Future<void> _addBookmark(AddBookmarkEvent event, Emitter emit) async {
    final prevState = state;
    if (prevState is! BookmarkLoaded) {
      log('illegal ${state.runtimeType} for ${event.runtimeType}');
      return;
    }
    final listBookmark = prevState.news.toList()..add(event.addBookmark);
    await addBookmark(AddBookmarkParamsUsecases(bookmarks: listBookmark));
    emit(BookmarkLoaded(news: listBookmark));
  }

  Future<void> _removeBookmark(RemoveBookmarkEvent event, Emitter emit) async {
        final prevState = state;
    if (prevState is! BookmarkLoaded) {
      log('illegal ${state.runtimeType} for ${event.runtimeType}');
      return;
    }
    final listBookmark = prevState.news.toList()..remove(event.removeBookmark);
    await removeBookmark(RemoveBookmarkParamsUsecases(bookmarks: listBookmark));
    emit(BookmarkLoaded(news: listBookmark));
  }

  Future<void> _getAllBookmark(GetAllBookmarkEvent event, Emitter emit) async {
    final prevState = state;
    if (prevState is! BookmarkLoaded) {
      emit(BookmarkLoading());
    }
    final response = await getAllBookmark(const GetAllBookmarkParamsUsecases());
    await response.fold((failure) => _onStateFailure(emit, failure),
        (news) => _onGetAllBookmarkSuccessful(emit, news));
  }
    Future<void> _onStateFailure(Emitter emit, Failure failure) async {
    emit(BookmarkFailure(failure: failure));
  }

  Future<void> _onGetAllBookmarkSuccessful(
      Emitter emit, List<NewsEntity> news) async {
    emit(BookmarkLoaded(news: news));
  }
}
