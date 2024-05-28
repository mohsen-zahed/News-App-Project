import 'package:flutter/material.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/data/models/business_news_model.dart';
import 'package:news_app/features/data/models/technology_news_model.dart';
import 'package:news_app/features/data/models/wall_street_news_model.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/packages/cached_network_image_package/custom_cached_network_image.dart';

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                    primary: false,
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
                                      height: getMediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.allNews[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
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
                                      height: getMediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.wallStreetList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
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
                                      height: getMediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.businessNewsList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
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
                                      height: getMediaQueryHeight(context),
                                      child: CustomCachedNetworkImage(borderRadius: 10, imageUrl: widget.technologyList[index].imageUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.015)),
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
