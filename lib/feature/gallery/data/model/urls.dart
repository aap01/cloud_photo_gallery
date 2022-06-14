import 'package:freezed_annotation/freezed_annotation.dart';

part 'urls.freezed.dart';
part 'urls.g.dart';

@freezed
class Urls with _$Urls {
  factory Urls({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    @JsonKey(name: 'small_s3') String? smallS3,
  }) = _Urls;

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
}
