import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/bloc/news_details_bloc/bloc/bookmark_button_bloc.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/reading_list_screen/reading_list_news_details_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/utils/my_app_bar.dart';
import 'package:news_app/utils/my_media_query.dart';

class ReadingListScreen extends StatefulWidget {
  const ReadingListScreen({super.key});
  static const String id = '/reading_list_screen';

  @override
  State<ReadingListScreen> createState() => _ReadingListScreenState();
}

class _ReadingListScreenState extends State<ReadingListScreen> {
  BookmarkButtonBloc? bloc;
  StreamSubscription? streamSubscription;
  @override
  void dispose() {
    super.dispose();
    bloc?.close();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookmarkButtonBloc>(
      create: (context) {
        bloc = BookmarkButtonBloc(firebaseUserInfoRepository);
        streamSubscription = bloc?.stream.listen((state) async {
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
        return bloc!;
      },
      child: Scaffold(
        appBar: myAppBar(context: context, child: const Text('My Reading List')),
        body: ValueListenableBuilder(
          valueListenable: FirebaseUserInfoDataSourceImp.savedListNotifier,
          builder: (context, value, child) {
            final readingList = value.reversed.toList();

            return readingList.isNotEmpty
                ? ListView.builder(
                    itemCount: readingList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: GlobalKey(),
                        onDismissed: (direction) {
                          BlocProvider.of<BookmarkButtonBloc>(context).add(
                            RemoveBookmarkReadingListButtonIsClicked(userId: globalUserId, newsId: readingList[index]),
                          );
                        },
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