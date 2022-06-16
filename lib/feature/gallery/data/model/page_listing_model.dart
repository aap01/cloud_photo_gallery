import 'package:cloud_photo_gallery/core/usecase/params/page_listing_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_listing_model.g.dart';

@JsonSerializable()
class PageListingModel extends PageListingParams {
  PageListingModel({
    @JsonKey(name: 'per_page') required super.perPage,
    required super.page,
  });
  Map<String, dynamic> toJson() => _$PageListingModelToJson(this);
}
