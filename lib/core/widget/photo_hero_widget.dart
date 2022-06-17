import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_photo_gallery/core/constant/asset_constants.dart';
import 'package:flutter/material.dart';

import '../../feature/gallery/domain/entity/photo.dart';

class PhotoHeroWidget extends StatelessWidget {
  final Photo photo;
  final BoxFit boxFit;
  const PhotoHeroWidget({
    Key? key,
    required this.photo,
    required this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: photo.id,
      child: CachedNetworkImage(
        fit: boxFit,
        imageUrl: photo.urls?.regular ?? '',
        errorWidget: (context, url, err) => Image.asset(
          AssetConstants.noImage,
        ),
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
