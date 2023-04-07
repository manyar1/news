part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();
  @override
  List<Object?> get props => [];
}

class AddBookmarkEvent extends BookmarkEvent {
  final NewsEntity addBookmark;
  const AddBookmarkEvent({required this.addBookmark});
}

class RemoveBookmarkEvent extends BookmarkEvent {
  final NewsEntity removeBookmark;
  const RemoveBookmarkEvent({required this.removeBookmark});
}

class GetAllBookmarkEvent extends BookmarkEvent {
  final Completer? completer;
  const GetAllBookmarkEvent({this.completer});
  @override
  List<Object?> get props => [completer];
}
