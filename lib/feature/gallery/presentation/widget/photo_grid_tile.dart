import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_photo_gallery/core/route/routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/asset_constants.dart';
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
      onTap: () => Navigator.pushNamed(context, Routes.photoViewScreen),
      child: GridTile(
        child: Hero(
          tag: photo.id,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photo.urls?.regular ?? '',
            errorWidget: (context, url, err) => Image.asset(
              AssetConstants.noImage,
            ),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
