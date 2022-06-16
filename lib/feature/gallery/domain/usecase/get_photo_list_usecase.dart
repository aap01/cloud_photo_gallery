// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:cloud_photo_gallery/core/usecase/usecase.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/repository/photo_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/params/page_listing_params.dart';

class GetPhotoListUsecase implements Usecase<PageListingParams, List<Photo>> {
  late final PhotoRepository _photoRepository;
  GetPhotoListUsecase({
    required PhotoRepository photoRepository,
  }) {
    _photoRepository = photoRepository;
  }
  @override
  Future<Either<Failure, List<Photo>>> call({
    required PageListingParams param,
  }) =>
      _photoRepository.getPhotos(
        page: param.page,
        perPage: param.perPage,
      );
}
