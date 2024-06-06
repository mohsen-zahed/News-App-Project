import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';

part 'bookmark_button_event.dart';
part 'bookmark_button_state.dart';

class BookmarkButtonBloc extends Bloc<BookmarkButtonEvent, BookmarkButtonState> {
  final IFirebaseUserInfoRepository iFirebaseUserInfoRepository;
  BookmarkButtonBloc(this.iFirebaseUserInfoRepository) : super(BookmarkButtonInitial()) {
    on<BookmarkButtonEvent>((event, emit) async {
      if (event is BookmarkButtonIsClicked) {
        try {
          await iFirebaseUserInfoRepository.storeToUserSavedList(event.userId, event.newsId);
          firebaseUserInfoRepository.getUserSavedList(globalUserId);
          emit(BookmarkButtonSuccess());
        } on FirebaseException catch (e) {
          emit(BookmarkButtonFailed(errorMessage: e.message.toString()));
        }
      } else if (event is RemoveBookmarkButtonIsClicked) {
        try {
          iFirebaseUserInfoRepository.removeFromUserSavedList(event.userId, event.newsId);
          await firebaseUserInfoRepository.getUserSavedList(globalUserId);
          emit(RemoveBookmarkButtonSuccess());
          emit(BookmarkButtonInitial());
        } on FirebaseException catch (e) {
          emit(RemoveBookmarkButtonFailed(errorMessage: e.message.toString()));
        }
      } else if (event is RemoveBookmarkReadingListButtonIsClicked) {
        try {
          iFirebaseUserInfoRepository.removeFromUserSavedListMap(event.userId, event.newsId);
          await firebaseUserInfoRepository.getUserSavedList(globalUserId);
          emit(RemoveBookmarkButtonSuccess());
          emit(BookmarkButtonInitial());
        } on FirebaseException catch (e) {
          emit(RemoveBookmarkButtonFailed(errorMessage: e.message.toString()));
        }
      }
    });
  }
}
