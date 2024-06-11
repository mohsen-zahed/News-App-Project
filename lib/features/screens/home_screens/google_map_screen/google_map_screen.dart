import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/packages/geo_locator_package/geo_locator_package_const.dart';

class GoogleMapScreen extends StatefulWidget {
  final Position userPosition;
  const GoogleMapScreen({super.key, required this.userPosition});

  static const String id = '/google_map_screen';

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    userLocation = LatLng(widget.userPosition.latitude, widget.userPosition.longitude);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Location Preview'),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: userLocation!,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId(currentLocationMarkerId),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: userLocation!,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.map,
          color: Colors.blue,
        ),
      ),
    );
  }
}
