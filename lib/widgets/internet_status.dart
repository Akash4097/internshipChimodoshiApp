import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class InternetStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Xyz {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectionSubscription;

}