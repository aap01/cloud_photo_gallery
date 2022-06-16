import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/links.dart';

part 'links_model.g.dart';

@JsonSerializable()
class LinksModel extends Links {
  LinksModel({
    required super.self,
    required super.html,
    required super.download,
    required super.downloadLocation,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
}
