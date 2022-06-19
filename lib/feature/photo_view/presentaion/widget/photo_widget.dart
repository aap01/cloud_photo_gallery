// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/asset_constants.dart';
import '../../../gallery/domain/entity/photo.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  const PhotoWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: photo.id,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: photo.urls.regular,
        errorWidget: (context, url, err) => Image.asset(
          AssetConstants.noImage,
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
