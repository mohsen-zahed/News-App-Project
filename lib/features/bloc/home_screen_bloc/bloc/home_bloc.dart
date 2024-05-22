import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_project/features/data/models/banners_news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_project/features/data/models/business_news_model.dart';
import 'package:news_app_project/features/data/models/technology_news_model.dart';
import 'package:news_app_project/features/data/models/wall_street_news_model.dart';
import 'package:news_app_project/features/data/repository/ibanner_repository.dart';
import 'package:news_app_project/features/data/repository/inews_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannerRepository;
  final INewsRepository iNewsRepository;
  HomeBloc(this.iBannerRepository, this.iNewsRepository) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        emit(HomeLoading());
        try {
          final bannersResult = await iBannerRepository.getAllBanners();
          final technologyResult = await iNewsRepository.getTechnologyNews();
          final wallStreetResult = await iNewsRepository.getWallStreetNews();
          final businessResult = await iNewsRepository.getBusinessNews();
          final allNewsResult = iNewsRepository.getAllNews();
          emit(HomeSuccess(
            bannersList: bannersResult,
            technologyList: technologyResult,
            wallStreetList: wallStreetResult,
            businessNewsList: businessResult,
            allNewsList: allNewsResult,
          ));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(HomeFailed(exception: 'bad response'));
          } else if (e.type == DioExceptionType.connectionError) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(HomeFailed(exception: ''));
          } else if (e.type == DioExceptionType.unknown) {
            emit(HomeFailed(exception: ''));
          } else {
            emit(HomeFailed(exception: ''));
          }
        }
      }
    });
  }
}
