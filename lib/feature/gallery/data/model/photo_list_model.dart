// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_list_model.g.dart';

@JsonSerializable()
class PhotoListModel {
  final List<PhotoModel> photos;
  const PhotoListModel({
    this.photos = const [],
  });
  factory PhotoListModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoListModelToJson(this);
}
