import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/bloc/home_screen_bloc/bloc/home_bloc.dart';
import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';
import 'package:news_app_project/features/data/repository/inews_repository.dart';
import 'package:news_app_project/features/screens/home_screens/widgets/horizontal_banner_slider_widget.dart';
import 'package:news_app_project/features/screens/home_screens/widgets/top_widget_with_welcome_and_search.dart';
import 'package:news_app_project/translations/locale_keys.g.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:news_app_project/widgets/custom_cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController childScrollViewController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(bannerRepository, newsRepository)..add(HomeStarted()),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: childScrollViewController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopWidgetWithWelcomeAndSearch(
                  welcomeText: LocaleKeys.welcome_text.tr(),
                  onSearchTap: () {},
                  onNotificationTap: () {},
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const AspectRatio(
                        aspectRatio: 3 / 1.75,
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    } else if (state is HomeSuccess) {
                      return SizedBox(
                        height: getmediaQueryHeight(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* Entire horizontal scroll view with indicators... (Column)
                            HorizontalBannerSliderWidget(
                              bannersModelList: state.bannersList,
                            ),
                            SizedBox(height: getmediaQueryHeight(context, 0.01)),
                            //*
                            VerticalNewsListView(
                              technologyList: state.technologyList,
                              wallStreetList: state.wallStreetList,
                              businessNewsList: state.businessNewsList,
                              allNews: state.allNewsList,
                            ),
                          ],
                        ),
                      );
                    } else if (state is HomeFailed) {
                      return Center(
                        child: Text(state.exception),
                      );
                    } else {
                      throw 'state not supported';
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerticalNewsListView extends StatefulWidget {
  const VerticalNewsListView({
    super.key,
    required this.technologyList,
    required this.wallStreetList,
    required this.businessNewsList,
    required this.allNews,
  });

  final List<TechnologyNewsModel> technologyList;
  final List<WallStreetNewsModel> wallStreetList;
  final List<BusinessNewsModel> businessNewsList;
  final List<dynamic> allNews;

  @override
  State<VerticalNewsListView> createState() => _VerticalNewsListViewState();
}

class _VerticalNewsListViewState extends State<VerticalNewsListView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              padding: EdgeInsets.zero,
              // isScrollable: true,
              controller: _tabController,
              indicatorColor: kTransparentColor,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'W.S.J'),
                Tab(text: 'Business'),
                Tab(text: 'Technology'),
              ],
            ),
            Expanded(
              child: TabBarView(
                clipBehavior: Clip.none,
                controller: _tabController,
                children: [
                  //* All news... Tab1
                  ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getMediaQueryWidth(context, 0.05),
                          // vertical: getmediaQueryHeight(context, 0.02),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            AspectRatio(
                              aspectRatio: 2 / 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: getmediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.allNews[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getmediaQueryHeight(context, 0.015)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'By ${widget.allNews[index].author}',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.allNews[index].description,
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade800),
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            widget.allNews[index].publishedAt,
                                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: kGreyColorShade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Container(),
                  //* W.S.J news... Tab2
                  ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getMediaQueryWidth(context, 0.05),
                          // vertical: getmediaQueryHeight(context, 0.02),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            AspectRatio(
                              aspectRatio: 2 / 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: getmediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.wallStreetList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getmediaQueryHeight(context, 0.015)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'By ${widget.wallStreetList[index].author}',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.wallStreetList[index].description,
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade800),
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            widget.wallStreetList[index].publishedAt,
                                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: kGreyColorShade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //* Business news... Tab3
                  ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getMediaQueryWidth(context, 0.05),
                          // vertical: getmediaQueryHeight(context, 0.02),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            AspectRatio(
                              aspectRatio: 2 / 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: getmediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.businessNewsList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getmediaQueryHeight(context, 0.015)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'By ${widget.businessNewsList[index].author}',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.businessNewsList[index].description,
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade800),
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            widget.businessNewsList[index].publishedAt,
                                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: kGreyColorShade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //* Technology news... Tab4
                  ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getMediaQueryWidth(context, 0.05),
                          // vertical: getmediaQueryHeight(context, 0.02),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            AspectRatio(
                              aspectRatio: 2 / 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: getmediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.technologyList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getmediaQueryHeight(context, 0.015)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'By ${widget.technologyList[index].author}',
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kGreyColorShade500),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.technologyList[index].description,
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kGreyColorShade800),
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            widget.technologyList[index].publishedAt,
                                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: kGreyColorShade400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 1.5,
                              decoration: BoxDecoration(
                                color: kGreyColorShade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
