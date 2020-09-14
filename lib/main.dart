import 'package:flutter/material.dart';
import 'package:flutter_native_demo/screens/launch_screen.dart';
import 'package:flutter_native_demo/widgets/flutter_bluetooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LaunchScreen(),
      routes: {
        FlutterBlueApp.routeName: (context) => FlutterBlueApp(),
      },
    );
  }
}
