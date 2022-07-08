import 'package:json_annotation/json_annotation.dart';

part 'urls_model.g.dart';

@JsonSerializable()
class UrlsModel {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;
  const UrlsModel({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsModelToJson(this);
}
