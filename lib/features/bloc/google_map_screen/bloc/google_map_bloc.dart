import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_app/packages/connectivity_plus_package/connection_controller.dart';
import 'package:news_app/packages/geo_locator_package/geo_locator_package.dart';

part 'google_map_event.dart';
part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  final MyGeoLocatorPackage myGeoLocatorPackage;
  GoogleMapBloc(this.myGeoLocatorPackage) : super(GoogleMapLoading()) {
    on<GoogleMapEvent>((event, emit) async {
      if (event is GoogleMapStarted || event is GoogleMapReload) {
        try {
          emit(GoogleMapLoading());
          await initNoInternetListener();
          final currentPosition = await myGeoLocatorPackage.getCurrentPosition();
          if (currentPosition != null) {
            emit(GoogleMapSuccess(position: currentPosition));
            return;
          }
        } catch (e) {
          emit(GoogleMapFailed(
            errorMessage: e.toString(),
          ));
        }
      }
    });
  }
}
