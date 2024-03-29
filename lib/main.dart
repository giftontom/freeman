import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freeman/src/freeman.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization here
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(ProviderScope(child:FreemanApp()));
  });
}
