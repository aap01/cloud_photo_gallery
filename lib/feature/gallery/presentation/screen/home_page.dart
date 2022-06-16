import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/photo_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: PhotoGridWidget(),
      ),
    );
  }
}
