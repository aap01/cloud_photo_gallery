import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:dartz/dartz.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<Photo>>> getPhotos({
    required int perPage,
    required int page,
  });
}
