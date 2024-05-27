import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusListener {
  static final _singleton = ConnectionStatusListener._internal();
  ConnectionStatusListener._internal();

  final Connectivity _connectivity = Connectivity();

  static ConnectionStatusListener getInstance() => _singleton;

  bool hasConnection = false;
  bool isInternetConnected = false;

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(List<ConnectivityResult> results) async {
    for (var i = 0; i <= results[0].index; i++) {
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
    isInternetConnected = await checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }
}

void updateConnectivity(bool hasConnection, ConnectionStatusListener connectionStatus) {
  if (hasConnection == false) {
    connectionStatus.isInternetConnected = false;
    print('no internet');
  } else if (hasConnection == true) {
    connectionStatus.isInternetConnected = true;
    print('internet connection yes');
  }
}

Future initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();
  if (connectionStatus.isInternetConnected == false) {
    updateConnectivity(connectionStatus.isInternetConnected, connectionStatus);
  } else if (connectionStatus.isInternetConnected == true) {
    connectionStatus.connectionChange.listen((event) {
      updateConnectivity(connectionStatus.isInternetConnected, connectionStatus);
    });
  }
}
