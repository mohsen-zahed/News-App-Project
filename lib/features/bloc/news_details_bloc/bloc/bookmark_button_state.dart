part of 'bookmark_button_bloc.dart';

sealed class BookmarkButtonState extends Equatable {
  const BookmarkButtonState();

  @override
  List<Object> get props => [];
}

final class BookmarkButtonInitial extends BookmarkButtonState {}

final class BookmarkButtonLoading extends BookmarkButtonState {}

final class BookmarkButtonSuccess extends BookmarkButtonState {}

final class BookmarkButtonFailed extends BookmarkButtonState {
  final String errorMessage;

  const BookmarkButtonFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class RemoveBookmarkButtonLoading extends BookmarkButtonState {}

final class RemoveBookmarkButtonSuccess extends BookmarkButtonState {}

final class RemoveBookmarkButtonFailed extends BookmarkButtonState {
  final String errorMessage;

  const RemoveBookmarkButtonFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
