import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/bloc/news_details_bloc/bloc/bookmark_button_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/reading_list_news_details_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/packages/firebase_firestore_package/firebase_firestore_package.dart';
import 'package:news_app/utils/my_app_bar.dart';
import 'package:news_app/utils/my_media_query.dart';

class ReadingListScreen extends StatefulWidget {
  const ReadingListScreen({super.key});
  static const String id = '/reading_list_screen';

  @override
  State<ReadingListScreen> createState() => _ReadingListScreenState();
}

class _ReadingListScreenState extends State<ReadingListScreen> {
  BookmarkButtonBloc? _bloc;
  StreamSubscription? _streamSubscription;
  @override
  void dispose() {
    super.dispose();
    _bloc?.close();
    _streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarkButtonBloc>(
      create: (context) {
        _bloc = BookmarkButtonBloc(firebaseUserInfoRepository);
        _streamSubscription = _bloc?.stream.listen((state) async {
          if (state is RemoveBookmarkButtonSuccess) {
            await Future.delayed(const Duration(milliseconds: 200)).then(
              (value) => helperFunctions.showSnackBar(context, 'Removed successfully', 2000),
            );
          } else if (state is RemoveBookmarkButtonFailed) {
            await Future.delayed(const Duration(milliseconds: 200)).then(
              (value) => helperFunctions.showSnackBar(context, state.errorMessage, 2000),
            );
          }
        });
        return _bloc!;
      },
      child: Scaffold(
        appBar: myAppBar(context: context, child: const Text('My Reading List')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            helperFunctions.showConfirmationDialogBox(
              context,
              'Are you sure you want to clear the list? This action cannot be undone.',
              titleText: 'Confirm Clearing List',
              onConfirm: () async {
                await MyFirebaseFirestorePackage.instance.clearSavedList(globalUserId).then((value) {
                  helperFunctions.showSnackBar(context, 'Reading list cleared successfully', 3000);
                });
              },
              onCancel: () {},
            );
          },
          foregroundColor: kRedColor,
          backgroundColor: kRedColorOp3,
          splashColor: kRedColorOp3,
          elevation: 0,
          label: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.delete),
              SizedBox(width: 4),
              Text('Clear list'),
            ],
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: FirebaseUserInfoDataSourceImp.savedListNotifier,
          builder: (context, value, child) {
            final readingList = value.reversed.toList();
            return readingList.isNotEmpty
                ? ListView.builder(
                    itemCount: readingList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        confirmDismiss: (direction) async {
                          return await helperFunctions.showConfirmationDialogBox(
                            context,
                            'Tailoring Your Reading Experience?',
                            titleText: 'Removing News',
                            onConfirm: () {
                              BlocProvider.of<BookmarkButtonBloc>(context).add(
                                RemoveBookmarkReadingListButtonIsClicked(userId: globalUserId, newsId: readingList[index]),
                              );
                            },
                            onCancel: () {},
                          );
                        },
                        key: GlobalKey(),
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: getScreenArea(context, 0.0001)),
                          color: kRedColorOp5,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete_forever_outlined,
                              color: kRedColor,
                              size: getScreenArea(context, 0.00013),
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => ReadingListNewsDetailsScreen(readingNewsList: readingList[index]),
                            ));
                          },
                          child: SingleHorizontalNewsWidget(
                            newsModel: readingList[index],
                            comingFromReadingListScreen: true,
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    width: getMediaQueryWidth(context),
                    height: getMediaQueryHeight(context),
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/images/background_images/emty_list.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
