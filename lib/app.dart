import 'package:cloud_photo_gallery/core/constant/build_constants.dart';
import 'package:cloud_photo_gallery/core/di/service_locator.dart';
import 'package:cloud_photo_gallery/core/route/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Photo Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: BuildConstants.debug,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }

  @override
  void dispose() async {
    await ServiceLocator.closeServices();
    super.dispose();
  }
}
