// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/widget/photo_hero_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/screen/theme_screen.dart';
import '../../../gallery/domain/entity/photo.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final photo = ModalRoute.of(context)!.settings.arguments as Photo;
    return ThemeScreen(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageDownloaderWidget(photo: photo),
                  const SizedBox(
                    width: 16,
                  ),
                  ImageShareWidget(photo: photo),
                ],
              ),
            ],
          ),
          Expanded(
            child: PhotoHeroWidget(
              photo: photo,
              boxFit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageShareWidget extends StatelessWidget {
  final Photo photo;
  const ImageShareWidget({
    Key? key,
    required this.photo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _share(photo),
      icon: const Icon(Icons.share_outlined),
    );
  }

  _share(Photo photo) {}
}

class ImageDownloaderWidget extends StatelessWidget {
  final Photo photo;

  const ImageDownloaderWidget({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _onPressed(photo),
      icon: const Icon(Icons.download_outlined),
    );
  }

  void _onPressed(Photo photo) {}
}
