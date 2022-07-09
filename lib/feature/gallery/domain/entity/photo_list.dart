import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:equatable/equatable.dart';

class PhotoList extends Equatable {
  final List<Photo> photos;

  const PhotoList(this.photos);

  @override
  List<Object?> get props => [photos];
}

