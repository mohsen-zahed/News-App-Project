part of 'bookmark_button_bloc.dart';

sealed class BookmarkButtonEvent extends Equatable {
  const BookmarkButtonEvent();

  @override
  List<Object> get props => [];
}

final class BookmarkButtonIsClicked extends BookmarkButtonEvent {
  final String userId;
  final String itemId;

  const BookmarkButtonIsClicked({required this.userId, required this.itemId});
  @override
  List<Object> get props => [userId, itemId];
}

final class RemoveBookmarkButtonIsClicked extends BookmarkButtonEvent {
  final String userId;
  final String itemId;

  const RemoveBookmarkButtonIsClicked({required this.userId, required this.itemId});
}
