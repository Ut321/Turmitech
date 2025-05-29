import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection_container.dart';
import '../network/network_info.dart';

// Network info provider
final networkInfoProvider = Provider<NetworkInfo>((ref) => sl());

// Current connectivity status provider
final connectivityStatusProvider = StreamProvider<bool>((ref) {
  final networkInfo = ref.read(networkInfoProvider);
  return networkInfo.onConnectivityChanged;
});

// One-time connectivity check provider
final isConnectedProvider = FutureProvider<bool>((ref) async {
  final networkInfo = ref.read(networkInfoProvider);
  return await networkInfo.isConnected;
});

// Connection type provider
final connectionTypeProvider = FutureProvider<String>((ref) async {
  final networkInfo = ref.read(networkInfoProvider) as NetworkInfoImpl;
  return await networkInfo.connectionType;
});