import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/features/bloc/google_map_screen/bloc/google_map_bloc.dart';
import 'package:news_app/packages/geo_locator_package/geo_locator_package.dart';
import 'package:news_app/packages/geo_locator_package/geo_locator_package_const.dart';
import 'package:news_app/utils/my_media_query.dart';
import 'package:news_app/widgets/try_again_widget.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  static const String id = '/google_map_screen';

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoogleMapBloc>(
      create: (context) => GoogleMapBloc(MyGeoLocatorPackage.instance)..add(GoogleMapStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Location Preview'),
        ),
        body: BlocBuilder<GoogleMapBloc, GoogleMapState>(
          builder: (context, state) {
            if (state is GoogleMapLoading) {
              return Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    initialCameraPosition: const CameraPosition(
                      target: defaultLocation,
                      zoom: 16,
                    ),
                  ),
                  Container(
                    width: getMediaQueryWidth(context),
                    height: getMediaQueryHeight(context),
                    color: kWhiteColorOp6,
                    child: const CupertinoActivityIndicator(),
                  ),
                ],
              );
            } else if (state is GoogleMapSuccess) {
              final userPosition = LatLng(state.position.latitude, state.position.longitude);
              return GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: userPosition,
                  zoom: 16,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId(currentLocationMarkerId),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    position: userPosition,
                  ),
                },
              );
            } else if (state is GoogleMapFailed) {
              return TryAgainWidget(
                errorMessage: state.errorMessage,
                buttonText: 'Retry',
                onTryAgainPressed: () {
                  BlocProvider.of<GoogleMapBloc>(context).add(GoogleMapReload());
                },
              );
            } else {
              return TryAgainWidget(
                errorMessage: 'Service is not available right now',
                buttonText: 'Retry',
                onTryAgainPressed: () {
                  BlocProvider.of<GoogleMapBloc>(context).add(GoogleMapReload());
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.map,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
