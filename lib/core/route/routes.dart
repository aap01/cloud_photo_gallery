import 'package:cloud_photo_gallery/core/constant/title_constants.dart';
import 'package:cloud_photo_gallery/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const home = '/';
  Routes._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _getRoute(
          child: const HomePage(),
          settings: settings,
        );
      default:
        return _getRoute(
          child: const Text(TitleConstants.appTitle),
          settings: settings,
        );
    }
  }

  static MaterialPageRoute _getRoute({
    required Widget child,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (context) => child,
    );
  }
}
