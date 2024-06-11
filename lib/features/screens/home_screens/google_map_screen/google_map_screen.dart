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
  void dispose() {
    super.dispose();
    mapController?.dispose();
  }

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
                  const GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: defaultLocation,
                      zoom: 10,
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
              return Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
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
                  ),
                  Positioned(
                    bottom: getScreenArea(context, 0.00006),
                    right: getScreenArea(context, 0.00003),
                    child: Column(
                      children: [
                        GoogleMapButtonWidget(
                          icon: Icons.map,
                          onTap: () {
                            showSelectMapTypeDialog(context);
                          },
                        ),
                        SizedBox(height: getScreenArea(context, 0.00002)),
                        GoogleMapButtonWidget(
                          icon: Icons.zoom_in,
                          onTap: () {
                            mapController?.animateCamera(CameraUpdate.zoomIn());
                          },
                        ),
                        SizedBox(height: getScreenArea(context, 0.00002)),
                        GoogleMapButtonWidget(
                          icon: Icons.zoom_out,
                          onTap: () {
                            mapController?.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
      ),
    );
  }

  Future<dynamic> showSelectMapTypeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Map Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Normal'),
                onTap: () {
                  mapController?.setMapStyle(MapType.normal.name);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Satellite'),
                onTap: () {
                  mapController?.setMapStyle(MapType.satellite.name);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Terrain'),
                onTap: () async {
                  await mapController?.setMapStyle(MapType.terrain.name);
                  // Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class GoogleMapButtonWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  const GoogleMapButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: getScreenArea(context, 0.000115),
        height: getScreenArea(context, 0.000115),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(1),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 3,
              color: kBlackColorOp3,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
    );
  }
}
