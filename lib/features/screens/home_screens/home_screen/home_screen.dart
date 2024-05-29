import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/lists.dart';
import 'package:news_app/features/bloc/home_screen_bloc/bloc/home_bloc.dart';
import 'package:news_app/features/data/repository/ibanner_repository.dart';
import 'package:news_app/features/data/repository/inews_repository.dart';
import 'package:news_app/features/screens/home_screens/all_news_screen/all_news_screen.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/horizontal_banner_slider_widget.dart';
import 'package:news_app/features/screens/home_screens/home_screen/widgets/single_horizontal_news_widget.dart';
import 'package:news_app/features/screens/home_screens/search_screen/search_screen.dart';
import 'package:news_app/helpers/helper_functions.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/custom_divider.dart';
import 'package:news_app/widgets/try_again_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  ValueNotifier<int> listValueNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        homeBloc = HomeBloc(bannerRepository, newsRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            //* Search icon button....
            GestureDetector(
              onTap: () {
                if (allNewsListsHome.isNotEmpty) {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => SearchScreen(searchList: allNewsListsHome)));
                } else {
                  helperFunctions.showSnackBar(context, '${allNewsListsHome.toString()} is Empty!', 1000);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: helperFunctions.isThemeLightMode(context) ? kGreyColorShade200 : kGreyColorShade700,
                ),
                child: const Icon(CupertinoIcons.search),
              ),
            ),
            const SizedBox(width: 10),
            //* Notifications icon button....
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: helperFunctions.isThemeLightMode(context) ? kGreyColorShade200 : kGreyColorShade700,
                ),
                child: const Icon(CupertinoIcons.bell),
              ),
            ),
            SizedBox(width: getMediaQueryWidth(context, 0.035)),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              helperFunctions.showConfirmationDialogBox(
                context,
                'Current data might replace with new one!\nContinue anyway?',
                onConfirm: () {
                  homeBloc.add(HomeStarted());
                },
                onCancel: () {},
              );
            },
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                    height: getMediaQueryHeight(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: double.infinity),
                        const CupertinoActivityIndicator(),
                        const SizedBox(height: 10),
                        Text('Loading News...', style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                  );
                } else if (state is HomeSuccess) {
                  if (allNewsListsHome.isNotEmpty) {
                    allNewsListsHome.clear();
                  }
                  if (allNewsListAllScreen.isNotEmpty) {
                    allNewsListAllScreen.clear();
                  }

                  for (var i = 0; i < state.props.length; i++) {
                    if (i == 0 || i == 1) {
                      continue;
                    }
                    allNewsListsHome.add(state.props[i]);
                  }
                  for (var i = 0; i < state.props.length; i++) {
                    if (i == 0) {
                      continue;
                    }
                    allNewsListAllScreen.add(state.props[i]);
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Entire horizontal scroll view with indicators... (Column)
                        HorizontalBreakingNewsSliderWidget(
                          onViewAllTap: () {},
                          bannersModelList: state.bannersList,
                        ),
                        SizedBox(height: getMediaQueryHeight(context, 0.015)),
                        //* Horizontal categories with vertical recommendations widget...
                        const CustomDivider(),
                        SizedBox(height: getMediaQueryHeight(context, 0.015)),
                        //* Entire news categories vertical listView... (Padding)
                        ...List.generate(
                          allNewsListsHome.length,
                          (index) => Column(
                            children: [
                              HorizontalNewsCardsVerticalWithTitleText(
                                newsList: allNewsListsHome,
                                titleText: newsTitles[index],
                                comingIndex: index,
                                onSingleCardTap: () {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => AllNewsScreen(allNewsList: allNewsListAllScreen)));
                                },
                                onViewAllTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(builder: (context) => AllNewsScreen(allNewsList: allNewsListAllScreen, index: index + 1)),
                                  );
                                },
                              ),
                              const CustomDivider(),
                              SizedBox(height: getMediaQueryHeight(context, 0.02)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeFailed) {
                  return TryAgainWidget(
                    errorMessage: state.exception,
                    buttonText: 'Try again',
                    onTryAgainPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                    },
                  );
                } else {
                  return TryAgainWidget(
                    errorMessage: "Sorry, we're having trouble loading the content. Please try again later.",
                    buttonText: 'Try again',
                    onTryAgainPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalNewsCardsVerticalWithTitleText extends StatelessWidget {
  final List<dynamic> newsList;
  final GestureTapCallback onViewAllTap;
  final int comingIndex;
  final String titleText;
  final GestureTapCallback onSingleCardTap;
  const HorizontalNewsCardsVerticalWithTitleText({
    super.key,
    required this.newsList,
    required this.onViewAllTap,
    required this.titleText,
    required this.comingIndex,
    required this.onSingleCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.04)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(titleText, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: onViewAllTap,
                child: Text('View all', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kBlueColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1 / 1.1,
          child: PageView.builder(
            itemCount: newsList[comingIndex].length ~/ 2,
            itemBuilder: (context, realIndex) {
              final startIndex = realIndex * 2;
              return Column(
                children: [
                  ...List.generate(
                    2,
                    (index) => GestureDetector(
                      onTap: onSingleCardTap,
                      child: SingleHorizontalNewsWidget(
                        newsModel: newsList[comingIndex][startIndex + index],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}


// SingleChildScrollView(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       //* Entire horizontal scroll view with indicators... (Column)
                  //       HorizontalBreakingNewsSliderWidget(
                  //         onViewAllTap: () {},
                  //         bannersModelList: state.bannersList,
                  //       ),
                  //       SizedBox(height: getMediaQueryHeight(context, 0.03)),
                  //       //* Horizontal categories with vertical recommendations widget...
                  //       Column(
                  //         children: [
                  //           //* Categories widget...
                  //           HorizontalCategoriesWidget(listValueNotifier: listValueNotifier),
                  //           SizedBox(height: getMediaQueryHeight(context, 0.015)),
                  //           //* Entire news categories vertical listView... (Padding)
                  //           ValueListenableBuilder(
                  //             valueListenable: listValueNotifier,
                  //             builder: (context, value, child) => VerticalRecommendationsListWidget(
                  //               onViewAllTap: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   CupertinoPageRoute(
                  //                     builder: (context) => AllNewsScreen(allNewsList: allNewsList),
                  //                   ),
                  //                 );
                  //               },
                  //               newsList: value == 0
                  //                   ? state.allNewsList
                  //                   : value == 1
                  //                       ? state.wallStreetList
                  //                       : value == 2
                  //                           ? state.technologyList
                  //                           : state.businessNewsList,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
