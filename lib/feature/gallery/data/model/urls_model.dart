import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/urls.dart';

part 'urls_model.g.dart';

@JsonSerializable()
class UrlsModel extends Urls {
  const UrlsModel({
    required super.raw,
    required super.full,
    required super.regular,
    required super.small,
    required super.thumb,
    required super.smallS3,
  });

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsModelToJson(this);
}
