import 'package:cloud_photo_gallery/core/constant/build_constants.dart';
import 'package:cloud_photo_gallery/core/route/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
}
