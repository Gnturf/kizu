import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectionStatus {
  connected,
  disconnected,
}

class ConnectionStatusNotifier extends StateNotifier<ConnectionStatus> {
  ConnectionStatusNotifier() : super(ConnectionStatus.connected) {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.ethernet) ||
          result.contains(ConnectivityResult.wifi)) {
        state = ConnectionStatus.connected;
      } else {
        state = ConnectionStatus.disconnected;
      }
    });
  }

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final connectionStatusProvider =
    StateNotifierProvider<ConnectionStatusNotifier, ConnectionStatus>(
        (ref) => ConnectionStatusNotifier());
