import 'package:cloud_photo_gallery/feature/gallery/data/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/links.dart';

part 'links_model.freezed.dart';
part 'links_model.g.dart';

@freezed
abstract class LinksModel extends Model<Links> with _$LinksModel {
  const factory LinksModel({
    required String self,
    required String html,
    required String download,
    required String downloadLocation,
  }) = _LinksModel;

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  @override
  Links toEntity() => Links(
        self: self,
        download: download,
        html: html,
        downloadLocation: downloadLocation,
      );
}
