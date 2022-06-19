// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/cache/cache_manager.dart';
import 'package:cloud_photo_gallery/core/cache/file_saver.dart';
import 'package:cloud_photo_gallery/core/constant/platform.dart';
import 'package:cloud_photo_gallery/core/constant/title_constants.dart';
import 'package:cloud_photo_gallery/core/widget/photo_hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/di/service_locator.dart';
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
      onPressed: () async => await _share(context, photo),
      icon: const Icon(Icons.share_outlined),
    );
  }

  Future<void> _share(BuildContext context, Photo photo) async {
    final photoPath =
        await sl<AppCacheManager>().getCachedFilePath(photo.urls.regular);
    Share.shareFilesWithResult([photoPath]).then(
      (value) {
        if (value.raw.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                TitleConstants.sharedImage,
              ),
            ),
          );
        }
      },
    );
  }
}

class ImageDownloaderWidget extends StatefulWidget {
  final Photo photo;

  const ImageDownloaderWidget({
    super.key,
    required this.photo,
  });

  @override
  State<ImageDownloaderWidget> createState() => _ImageDownloaderWidgetState();
}

class _ImageDownloaderWidgetState extends State<ImageDownloaderWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => await _onPressed(widget.photo),
      icon: const Icon(Icons.download_outlined),
    );
  }

  Future<void> _onPressed(Photo photo) async {
    final cachedPath =
        await sl<AppCacheManager>().getCachedFilePath(photo.urls.regular);
    FileHelper.download('${photo.id}.jpg', cachedPath).then(
      (file) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(TitleConstants.imageDownloaded),
          action: Platform.isMobile(context)
              ? SnackBarAction(
                  label: TitleConstants.open,
                  onPressed: () async => await _previewImage(file.path),
                )
              : null,
        ),
      ),
    );
  }

  Future<void> _previewImage(String path) async {
    FileHelper.open(path);
  }
}
