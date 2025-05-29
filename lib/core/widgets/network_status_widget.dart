import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/network_providers.dart';

class NetworkStatusWidget extends ConsumerWidget {
  const NetworkStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityAsync = ref.watch(connectivityStatusProvider);
    
    return connectivityAsync.when(
      data: (isConnected) {
        if (!isConnected) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.red[100],
            child: Row(
              children: [
                Icon(Icons.wifi_off, color: Colors.red[700], size: 16),
                const SizedBox(width: 8),
                Text(
                  'No internet connection',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}