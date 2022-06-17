import 'package:cloud_photo_gallery/core/constant/title_constants.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/screen/gallery_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const home = '/';
  static const photoViewScreen = '/photo_view_screen';

  Routes._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _getRoute(
          child: const GalleryScreen(),
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
