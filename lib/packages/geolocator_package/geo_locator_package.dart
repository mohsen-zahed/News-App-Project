import 'package:geolocator/geolocator.dart';

class MyGeoLocatorPackage {
  static MyGeoLocatorPackage? _instance;
  MyGeoLocatorPackage._();
  static MyGeoLocatorPackage get instance {
    _instance ??= MyGeoLocatorPackage._();
    return _instance!;
  }

  //* Determine the current position of the device.
  // When the location services are not enabled or permissions
  // are denied the `Future` will return an error.
  Future<dynamic> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return 'Location permissions are denied';
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return 'Location is disables forever';
      }
      return await Geolocator.getCurrentPosition();
    } else {
      return 'Locations are disables';
    }
  }
}
