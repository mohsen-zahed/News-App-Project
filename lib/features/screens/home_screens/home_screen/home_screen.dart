import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/config/constants/global_colors.dart';
import 'package:news_app_project/features/bloc/home_screen_bloc/bloc/home_bloc.dart';
import 'package:news_app_project/features/data/models/general_news_model.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';
import 'package:news_app_project/features/data/repository/inews_repository.dart';
import 'package:news_app_project/features/screens/home_screens/home_screen/widgets/horizontal_banner_slider_widget.dart';
import 'package:news_app_project/features/screens/home_screens/home_screen/widgets/vertical_recommendations_list_widget.dart';
import 'package:news_app_project/features/screens/home_screens/search_screen/search_screen.dart';
import 'package:news_app_project/helpers/helper_functions.dart';
import 'package:news_app_project/utils/my_media_query.dart';
import 'package:news_app_project/widgets/empty_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  List<GeneralNewsModel> newsList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context2) {
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
                if (newsList.isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(newsList: newsList)));
                } else {
                  helperFunctions.showSnackBar(context, 'Something went wrong!', 1000);
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
            onRefresh: () async {},
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
                  newsList = state.generalNewsList;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Entire horizontal scroll view with indicators... (Column)
                        HorizontalBreakingNewsSliderWidget(
                          onViewAllTap: () {},
                          bannersModelList: state.bannersList,
                        ),
                        SizedBox(height: getMediaQueryHeight(context, 0.03)),
                        //* Entire news categories vertical listView... (Padding)
                        VerticalRecommendationsListWidget(
                          generalNewsModel: state.generalNewsList,
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeFailed) {
                  return EmptyScreenWidget(
                    errorMessage: state.exception,
                    buttonText: 'Try again',
                    onTryAgainPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                    },
                  );
                } else {
                  throw 'state not supported';
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
