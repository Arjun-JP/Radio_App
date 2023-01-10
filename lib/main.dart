import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_app/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const RadioApp());
}

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 79, 8, 92)),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
