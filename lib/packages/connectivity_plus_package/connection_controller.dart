import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusListener {
  static final _singleton = ConnectionStatusListener._internal();
  ConnectionStatusListener._internal();

  bool hasShownNoInternet = false;

  final Connectivity _connectivity = Connectivity();

  static ConnectionStatusListener getInstance() => _singleton;

  bool hasConnection = false;
  bool isInternetConnected = false;

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(List<ConnectivityResult> results) async {
    for (var i = 0; i < results.length; i++) {
      await checkConnection();
    }
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }
}

updateConnectivity(dynamic hasConnection, ConnectionStatusListener connectionStatus) {
  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    connectionStatus.isInternetConnected = false;
    print('no internet');
  }
  if (hasConnection) {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
      connectionStatus.isInternetConnected = true;
      print('internet connection yes');
    }
  }
}

initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  print(connectionStatus.toString());
  await connectionStatus.initialize();
  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  }
  if (connectionStatus.hasConnection) {
    connectionStatus.connectionChange.listen((event) {
      updateConnectivity(event, connectionStatus);
    });
  }
}
