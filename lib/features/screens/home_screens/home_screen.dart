import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/features/bloc/home_screen_bloc/bloc/home_bloc.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';
import 'package:news_app_project/features/screens/home_screens/widgets/horizontal_banner_slider_widget.dart';
import 'package:news_app_project/features/screens/home_screens/widgets/top_widget_with_welcome_and_search.dart';
import 'package:news_app_project/translations/locale_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(bannerRepository)..add(HomeStarted()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
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
                    return Expanded(
                      child: Column(
                        children: [
                          //* Entire horizotal scroll view with indicators...
                          HorizontalBannerSliderWidget(
                            newsModelList: state.newsList,
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
    );
  }
}
