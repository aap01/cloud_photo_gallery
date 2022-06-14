import 'package:freezed_annotation/freezed_annotation.dart';

import 'links.dart';
import 'urls.dart';

part 'image_model.freezed.dart';
part 'image_model.g.dart';

@freezed
class ImageModel with _$ImageModel {
  factory ImageModel({
    String? id,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'promoted_at') String? promotedAt,
    int? width,
    int? height,
    String? color,
    @JsonKey(name: 'blur_hash') String? blurHash,
    Urls? urls,
    Links? links,
  }) = _ImageModel;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
