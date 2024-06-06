part of 'bookmark_button_bloc.dart';

sealed class BookmarkButtonEvent extends Equatable {
  const BookmarkButtonEvent();

  @override
  List<Object> get props => [];
}

final class BookmarkButtonIsClicked extends BookmarkButtonEvent {
  final String userId;
  final dynamic newsId;

  const BookmarkButtonIsClicked({required this.userId, required this.newsId});
  @override
  List<Object> get props => [userId, newsId];
}

final class RemoveBookmarkButtonIsClicked extends BookmarkButtonEvent {
  final String userId;
  final dynamic newsId;

  const RemoveBookmarkButtonIsClicked({required this.userId, required this.newsId});
  @override
  List<Object> get props => [userId, newsId];
}

final class RemoveBookmarkReadingListButtonIsClicked extends BookmarkButtonEvent {
  final String userId;
  final dynamic newsId;

  const RemoveBookmarkReadingListButtonIsClicked({required this.userId, required this.newsId});
  @override
  List<Object> get props => [userId, newsId];
}
