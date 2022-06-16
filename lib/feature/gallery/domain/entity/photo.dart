// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/links.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/urls.dart';

class Photo {
  final String id;
  final int width;
  final int height;
  final Urls? urls;
  final Links? links;
  Photo({
    required this.id,
    required this.width,
    required this.height,
    this.urls,
    this.links,
  });
}
