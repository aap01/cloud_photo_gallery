// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/exception/server_exception.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/repository/photo_repository.dart';
import 'package:dartz/dartz.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  late PhotoRemoteDataSource _photoRemoteDataSource;
  late NetworkConnectionChecker _networkConnectionChecker;
  PhotoRepositoryImpl({
    required PhotoRemoteDataSource photoRemoteDataSource,
    required NetworkConnectionChecker networkConnectionChecker,
  }) {
    _photoRemoteDataSource = photoRemoteDataSource;
    _networkConnectionChecker = networkConnectionChecker;
  }

  @override
  Future<Either<GetPhotoListFailure, List<Photo>>> getPhotos({
    required int perPage,
    required int page,
  }) async {
    try {
      final response = await _photoRemoteDataSource.fetchPhotos(
        perPage: perPage,
        page: page,
      );
      return Right(response);
    } on ServerException catch (e) {
      final isConnected = await _networkConnectionChecker.isConnected();
      if (!isConnected) {
        return const Left(
          GetPhotoListFailure.internet(),
        );
      }
      return Left(
        GetPhotoListFailure.server(message: e.message),
      );
    } on Exception {
      return const Left(
        GetPhotoListFailure.server(message: MessageConstants.internalError),
      );
    }
  }
}
