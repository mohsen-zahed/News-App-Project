import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/bloc/news_details_bloc/bloc/bookmark_button_bloc.dart';
import 'package:news_app/features/data/source/ifirebase_user_info_data_source.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/widget/news_image_widget.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/widget/profile_image_with_name_and_follow_button_widget.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/packages/share_plus_package/share_plus_package.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/custom_divider.dart';

class AllNewsVerticalListView extends StatelessWidget {
  const AllNewsVerticalListView({
    super.key,
    required this.allNewsList,
    required this.tabNotifier,
    required this.searchNotifier,
  });

  final ValueNotifier<int> tabNotifier;
  final List<dynamic> allNewsList;
  final ValueNotifier<String> searchNotifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: searchNotifier,
        builder: (context, value, child) => ValueListenableBuilder(
          //* Search algorithm similar to the one in the search_screen...
          valueListenable: tabNotifier,
          builder: (context, value, child) {
            List<dynamic> items = [];
            var searchNewsList = allNewsList[tabNotifier.value];
            if (searchNotifier.value.isNotEmpty) {
              items = searchNewsList.where((element) {
                return (element.title.contains(searchNotifier.value.toLowerCase()) || element.title.contains(searchNotifier.value.toUpperCase())) ||
                    (element.description.contains(searchNotifier.value.toLowerCase()) ||
                        element.description.contains(searchNotifier.value.toUpperCase())) ||
                    (element.source.contains(searchNotifier.value.toLowerCase()) || element.source.contains(searchNotifier.value.toUpperCase())) ||
                    (element.content.contains(searchNotifier.value.toLowerCase()) || element.content.contains(searchNotifier.value.toUpperCase())) ||
                    (element.author.contains(searchNotifier.value.toLowerCase()) || element.author.contains(searchNotifier.value.toUpperCase()));
              }).toList();
            } else {
              items = searchNewsList;
            }
            if (items.isEmpty) {
              return Center(
                  child: Text(
                tabNotifier.value == 0
                    ? 'No record found - AllNews'
                    : tabNotifier.value == 1
                        ? 'No record found - WJS'
                        : tabNotifier.value == 2
                            ? 'No record found - Technology'
                            : 'No record found - Business',
                style: Theme.of(context).textTheme.titleMedium,
              ));
            } else {
              return ListView.builder(
                itemCount: allNewsList[tabNotifier.value].length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Column(
                        children: [
                          //* News post profile image, name, published date, follow button...
                          ProfileImageWithNameAndFollowButtonWidget(
                            profileName: allNewsList[tabNotifier.value][index].author,
                            profileImageUrl: cnnIconTvPath,
                            publishedDate: allNewsList[tabNotifier.value][index].publishedAt,
                            onFollowTap: () {},
                          ),
                          SizedBox(height: getMediaQueryHeight(context, 0.02)),
                          //* News post descritpion and content...
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.05)),
                            child: Text(
                              '${allNewsList[tabNotifier.value][index].description}\n${allNewsList[tabNotifier.value][index].content}',
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: getMediaQueryHeight(context, 0.015)),
                          //* News post Image...
                          NewsImageWidget(allNewsList: allNewsList, tabNotifier: tabNotifier, index: index),
                          SizedBox(height: getMediaQueryHeight(context, 0.012)),
                          //* News post like, comments, share, bookmark...
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.05)),
                            child: ValueListenableBuilder(
                                valueListenable: FirebaseUserInfoDataSourceImp.savedListNotifier,
                                builder: (context, value, child) {
                                  bool isSaved = value.any((element) => element['title'] == allNewsList[tabNotifier.value][index].title);
                                  return Row(
                                    children: [
                                      BlocBuilder<BookmarkButtonBloc, BookmarkButtonState>(
                                        builder: (context, state) {
                                          return GestureDetector(
                                            onTap: () {
                                              !isSaved
                                                  ? BlocProvider.of<BookmarkButtonBloc>(context).add(
                                                      BookmarkButtonIsClicked(
                                                        newsId: allNewsList[tabNotifier.value][index],
                                                        userId: globalUserId,
                                                      ),
                                                    )
                                                  : BlocProvider.of<BookmarkButtonBloc>(context).add(
                                                      RemoveBookmarkButtonIsClicked(
                                                        userId: globalUserId,
                                                        newsId: allNewsList[tabNotifier.value][index],
                                                      ),
                                                    );
                                            },
                                            child: Icon(isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark),
                                          );
                                        },
                                      ),
                                      SizedBox(width: getMediaQueryWidth(context, 0.02)),
                                      GestureDetector(
                                          child: const Icon(CupertinoIcons.share),
                                          onTap: () {
                                            MySharePlusPackage.instance.shareApp(
                                                '${allNewsList[tabNotifier.value][index].title}\n${allNewsList[tabNotifier.value][index].content}',
                                                '${allNewsList[tabNotifier.value][index].title}');
                                          }),
                                      const Spacer(),
                                      const Icon(Icons.chat_bubble_outline),
                                      SizedBox(width: getMediaQueryWidth(context, 0.03)),
                                      const Icon(CupertinoIcons.hand_thumbsup),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                      SizedBox(height: getMediaQueryHeight(context, 0.02)),
                      const CustomDivider(),
                      SizedBox(height: getMediaQueryHeight(context, 0.02)),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
