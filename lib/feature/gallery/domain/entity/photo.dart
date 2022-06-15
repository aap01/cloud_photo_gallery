// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/links.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/urls.dart';

class Photo {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime promotedAt;
  final int width;
  final int height;
  final String color;
  final String blurHash;
  final Urls urls;
  final Links links;
  Photo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.promotedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.urls,
    required this.links,
  });
}
