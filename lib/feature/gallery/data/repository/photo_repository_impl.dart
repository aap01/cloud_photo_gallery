// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/constant/build_constants.dart';
import 'package:cloud_photo_gallery/core/exception/server_exception.dart';
import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/repository/photo_repository.dart';
import 'package:dartz/dartz.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  late PhotoRemoteDataSource _photoRemoteDataSource;

  PhotoRepositoryImpl({
    required PhotoRemoteDataSource photoRemoteDataSource,
  }) {
    _photoRemoteDataSource = photoRemoteDataSource;
  }

  @override
  Future<Either<Failure, List<Photo>>> getPhotos({
    required int perPage,
    required int page,
  }) async {
    try {
      final response = await _photoRemoteDataSource.fetchPhotos(
        page: page,
        perPage: perPage,
      );
      return response.when(
        error: (value) {
          return Left(
            GetPhotoListFailure.server(
              serverFailure: ServerFailure(
                message: value.errors.first,
              ),
            ),
          );
        },
        success: (value) {
          final photoList = (value as List).map((e) {
            final model = PhotoModel.fromJson(e as Map<String, dynamic>);
            if (BuildConstants.debug) {
              print(model.toJson());
            }
            return model;
          }).toList();
          return Right(photoList);
        },
      );
    } on ServerException catch (e) {
      return Left(
        GetPhotoListFailure.server(
          serverFailure: ServerFailure(
            message: e.message,
          ),
        ),
      );
    }
  }
}
