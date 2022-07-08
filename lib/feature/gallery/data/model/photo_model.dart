import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Equatable {
  final String id;
  final int width;
  final int height;
  @JsonKey(name: 'links')
  final LinksModel linksModel;
  @JsonKey(name: 'urls')
  final UrlsModel urlsModel;

  const PhotoModel({
    required this.id,
    required this.width,
    required this.height,
    required this.linksModel,
    required this.urlsModel,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        width,
        height,
        linksModel,
        urlsModel,
      ];
}
