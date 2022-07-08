import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'links_model.g.dart';

@JsonSerializable()
class LinksModel extends Equatable{
  final String self;
  final String html;
  final String download;
  final String downloadLocation;
  const LinksModel({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
  
  @override

  List<Object?> get props => [self, html, download, downloadLocation];
}
