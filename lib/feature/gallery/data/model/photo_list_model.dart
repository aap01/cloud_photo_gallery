import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:equatable/equatable.dart';

class PhotoListModel extends Equatable {
  final List<PhotoModel> photoModels;

  const PhotoListModel({
    required this.photoModels,
  });

  @override
  List<Object?> get props => [photoModels];
}
