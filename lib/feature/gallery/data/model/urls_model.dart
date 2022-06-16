import 'package:cloud_photo_gallery/feature/gallery/data/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/urls.dart';

part 'urls_model.freezed.dart';
part 'urls_model.g.dart';

@freezed
abstract class UrlsModel with _$UrlsModel implements Model<Urls> {
  const UrlsModel._();
  const factory UrlsModel({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    String? smallS3,
  }) = _UrlsModel;

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  @override
  Urls toEntity() => Urls(
        raw: raw ?? '',
        full: full ?? '',
        regular: regular ?? '',
        small: small ?? '',
        thumb: thumb ?? '',
        smallS3: smallS3 ?? '',
      );
}
