import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
  Future<List<ConnectivityResult>> get connectionStatus;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  
  NetworkInfoImpl({Connectivity? connectivity}) 
      : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isConnected async {
    try {
      final List<ConnectivityResult> connectivityResults = 
          await _connectivity.checkConnectivity();
      
      // Check if any connection type is available (excluding none)
      return connectivityResults.any((result) => 
          result != ConnectivityResult.none);
    } catch (e) {
      // If there's an error checking connectivity, assume no connection
      return false;
    }
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map((connectivityResults) {
      // Convert List<ConnectivityResult> to bool
      return connectivityResults.any((result) => 
          result != ConnectivityResult.none);
    });
  }

  @override
  Future<List<ConnectivityResult>> get connectionStatus async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return [ConnectivityResult.none];
    }
  }

  /// Check if connected to WiFi
  Future<bool> get isConnectedToWiFi async {
    final results = await connectionStatus;
    return results.contains(ConnectivityResult.wifi);
  }

  /// Check if connected to mobile data
  Future<bool> get isConnectedToMobile async {
    final results = await connectionStatus;
    return results.contains(ConnectivityResult.mobile);
  }

  /// Check if connected to ethernet
  Future<bool> get isConnectedToEthernet async {
    final results = await connectionStatus;
    return results.contains(ConnectivityResult.ethernet);
  }

  /// Get connection type as string for display purposes
  Future<String> get connectionType async {
    final results = await connectionStatus;
    
    if (results.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (results.contains(ConnectivityResult.mobile)) {
      return 'Mobile Data';
    } else if (results.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else if (results.contains(ConnectivityResult.bluetooth)) {
      return 'Bluetooth';
    } else if (results.contains(ConnectivityResult.vpn)) {
      return 'VPN';
    } else {
      return 'No Connection';
    }
  }
}