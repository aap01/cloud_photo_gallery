// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/links.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/urls.dart';
import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final String id;
  final int width;
  final int height;
  final Urls urls;
  final Links links;
  const Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.urls,
    required this.links,
  });
  @override
  List<Object?> get props => [
        id,
        width,
        height,
        urls,
        links,
      ];
}
