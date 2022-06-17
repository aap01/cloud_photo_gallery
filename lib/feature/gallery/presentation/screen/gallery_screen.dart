import 'package:cloud_photo_gallery/core/screen/theme_screen.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/photo_grid.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ThemeScreen(
      child: PhotoGridWidget(),
    );
  }
}
