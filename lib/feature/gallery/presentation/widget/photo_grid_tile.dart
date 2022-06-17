import 'package:cloud_photo_gallery/core/route/routes.dart';
import 'package:cloud_photo_gallery/core/widget/photo_hero_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/photo.dart';

class PhotoGridTileWidget extends StatelessWidget {
  final Photo photo;
  const PhotoGridTileWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.photoViewScreen,
        arguments: photo,
      ),
      child: GridTile(
        child: PhotoHeroWidget(
          boxFit: BoxFit.cover,
          photo: photo,
        ),
      ),
    );
  }
}
