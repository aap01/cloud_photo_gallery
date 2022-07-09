import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/data_source/remote/photo_remote_data_source.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/links_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/photo_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/model/urls_model.dart';
import 'package:cloud_photo_gallery/feature/gallery/data/repository/photo_repository_impl.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/links.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/urls.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/photo_list_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'photo_repository_impl_test.mocks.dart';

@GenerateMocks([
  PhotoRemoteDataSource,
  NetworkConnectionChecker,
  PhotoListMapper,
])
void main() async {
  final mockPhotoRemoteDataSourece = MockPhotoRemoteDataSource();
  final mockNetworkConnectionChecker = MockNetworkConnectionChecker();
  final mockMapper = MockPhotoListMapper();
  final photoRepository = PhotoRepositoryImpl(
    photoRemoteDataSource: mockPhotoRemoteDataSourece,
    networkConnectionChecker: mockNetworkConnectionChecker,
    mapper: mockMapper,
  );
  const linksModel = LinksModel(
    self: 's',
    html: 'h',
    download: 'd',
    downloadLocation: 'd',
  );
  const links = Links(
    self: 's',
    html: 'h',
    download: 'd',
    downloadLocation: 'd',
  );
  const urlsModel = UrlsModel(
    raw: 'r',
    full: 'f',
    regular: 'r',
    small: 's',
    thumb: 't',
    smallS3: 's',
  );
  const urls = Urls(
    raw: 'r',
    full: 'f',
    regular: 'r',
    small: 's',
    thumb: 't',
    smallS3: 's',
  );
  const photoModel = PhotoModel(
    id: '1',
    width: 1,
    height: 1,
    linksModel: linksModel,
    urlsModel: urlsModel,
  );
  const photo = Photo(
    id: '1',
    width: 1,
    height: 1,
    links: links,
    urls: urls,
  );
  const photoModelList = [photoModel];
  const photoList = [photo];

  const int perPage = 10;
  const int page = 1;
  test(
    'should return Right(photoListModel.photos)',
    () async {
      when(
        mockPhotoRemoteDataSourece.fetchPhotos(
          perPage: perPage,
          page: page,
        ),
      ).thenAnswer(
        (_) async => Future<List<PhotoModel>>.value(photoModelList),
      );
      when(
        mockMapper.map(
          photoModelList,
        ),
      ).thenReturn(photoList);

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
      expect(result, equals(const Right(photoList)));
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
