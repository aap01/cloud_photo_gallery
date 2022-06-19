import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/exception/server_exception.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/repository/photo_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/photo_map.dart';
import 'photo_repository_impl_test.mocks.dart';

@GenerateMocks([
  PhotoRemoteDataSource,
  NetworkConnectionChecker,
])
void main() async {
  final mockPhotoRemoteDataSourece = MockPhotoRemoteDataSource();
  final mockNetworkConnectionChecker = MockNetworkConnectionChecker();
  final photoRepository = PhotoRepositoryImpl(
    photoRemoteDataSource: mockPhotoRemoteDataSourece,
    networkConnectionChecker: mockNetworkConnectionChecker,
  );

  const int perPage = 10;
  const int page = 1;
  final response = [await getPhotoMap()];
  final List<PhotoModel> photos =
      response.map((e) => PhotoModel.fromJson(e)).toList();
  const serverException =
      ServerException(message: MessageConstants.internalError);

  // final errorString = await FixtureReader.read('test/fixture/error.json');
  // final Map<String, dynamic> errorJson = json.decode(errorString);
  // final errorModel = ErrorModel.fromJson(errorJson);
  // final apiErrorResponse = ApiResponse.error(error: errorModel);
  // final getPhotoListFailure =
  //     GetPhotoListFailure.server(message: errorModel.errors.first);
  test(
    'should return Right(photoListModel.photos)',
    () async {
      when(
        mockPhotoRemoteDataSourece.fetchPhotos(
          perPage: perPage,
          page: page,
        ),
      ).thenAnswer((_) async => Future<List<PhotoModel>>.value(photos));

      final result = await photoRepository.getPhotos(
        perPage: perPage,
        page: page,
      );
      verify(
        mockPhotoRemoteDataSourece.fetchPhotos(
          perPage: perPage,
          page: page,
        ),
      );
      verifyNoMoreInteractions(mockPhotoRemoteDataSourece);
      expect(result, equals(Right(photos)));
    },
  );
  test(
    'should return Left(GetPhotLisFailure.server(message: apiResponse.errors.first))',
    () async {
      const getPhotoListFailure = GetPhotoListFailure.server(
        message: MessageConstants.internalError,
      );
      when(mockPhotoRemoteDataSourece.fetchPhotos(
        perPage: perPage,
        page: page,
      )).thenThrow(Exception());

      final result =
          await photoRepository.getPhotos(perPage: perPage, page: page);

      expect(result, equals(const Left(getPhotoListFailure)));
    },
  );
}
