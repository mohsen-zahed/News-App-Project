import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_app/features/data/models/banners_news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/data/models/business_news_model.dart';
import 'package:news_app/features/data/models/general_news_model.dart';
import 'package:news_app/features/data/models/technology_news_model.dart';
import 'package:news_app/features/data/models/wall_street_news_model.dart';
import 'package:news_app/features/data/repository/ibanner_repository.dart';
import 'package:news_app/features/data/repository/ifirebase_user_info_repository.dart';
import 'package:news_app/features/data/repository/inews_repository.dart';
import 'package:news_app/packages/connectivity_plus_package/connection_controller.dart';
import 'package:news_app/packages/geo_locator_package/geo_locator_package.dart';

part 'home_event.dart';
part 'home_state.dart';

bool isConnected = false;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository iBannerRepository;
  final INewsRepository iNewsRepository;
  final IFirebaseUserInfoRepository iFirebaseUserInfoRepository;
  final MyGeoLocatorPackage myGeolocatorPackage;
  HomeBloc(this.iBannerRepository, this.iNewsRepository, this.iFirebaseUserInfoRepository, this.myGeolocatorPackage) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh || event is GetLocationButtonIsClicked) {
        if (event is GetLocationButtonIsClicked) {
          try {
            emit(GetLocationLoading());
            await initNoInternetListener();
            final currentPosition = await myGeolocatorPackage.getCurrentPosition();
            if (currentPosition != null) {
              emit(GetLocationSuccess(position: currentPosition));
              return;
            }
          } catch (e) {
            emit(GetLocationFailed(
              errorMessage: e.toString(),
            ));
          }
        }
        emit(HomeLoading());
        await initNoInternetListener();
        await Future.delayed(const Duration(seconds: 1));
        String userId = '';
        if (event is HomeStarted) {
          userId = event.userId;
        } else if (event is HomeRefresh) {
          userId = event.userId;
        }
        try {
          final bannersResult = await iBannerRepository.getBannersNews();
          final technologyResult = await iNewsRepository.getTechnologyNews();
          final wallStreetResult = await iNewsRepository.getWallStreetNews();
          final businessResult = await iNewsRepository.getBusinessNews();
          final allNewsResult = await iNewsRepository.getAllNews();
          final savedListFF = await iFirebaseUserInfoRepository.getUserSavedList(userId);
          await iFirebaseUserInfoRepository.getUserImageFF(userId);
          emit(HomeSuccess(
            bannersList: bannersResult,
            technologyList: technologyResult,
            wallStreetList: wallStreetResult,
            businessNewsList: businessResult,
            allNewsList: allNewsResult,
            savedItemsList: savedListFF,
          ));
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(const HomeFailed(exception: 'Something went wrong, please try again in the next 24 hours!'));
            debugPrint('BadResponse message: ${e.message.toString()}');
          } else if (e.type == DioExceptionType.connectionError) {
            emit(const HomeFailed(exception: 'Please check your network and try again!'));
            debugPrint('ConnectionError message: ${e.message.toString()}');
          } else if (e.type == DioExceptionType.connectionTimeout) {
            emit(const HomeFailed(exception: 'Request timed out, try again later!'));
            debugPrint('ConnectionTimeout message: ${e.message.toString()}');
          } else if (e.type == DioExceptionType.sendTimeout) {
            emit(const HomeFailed(exception: 'Request timed out, try again later!'));
            debugPrint('SendTimeout message: ${e.message.toString()}');
          } else if (e.type == DioExceptionType.unknown) {
            emit(const HomeFailed(exception: 'There is an unknown problem keeping you from sending requests!'));
            debugPrint('Unknown message: ${e.message.toString()}');
          } else {
            emit(const HomeFailed(exception: 'Something went wrong!'));
          }
        }
      }
    });
  }
}
