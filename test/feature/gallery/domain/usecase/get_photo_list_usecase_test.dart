import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/usecase/params/page_listing_params.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/repository/photo_repository.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_photo_list_usecase_test.mocks.dart';

@GenerateMocks([PhotoRepository])
void main() {
  final mockPhotoRepository = MockPhotoRepository();
  final usecase = GetPhotoListUsecase(
    photoRepository: mockPhotoRepository,
  );
  int perPage = 10;
  int page = 1;
  final pageListingParams = PageListingParams(
    perPage: perPage,
    page: page,
  );
  final serverFalure = ServerFailure();

  test(
    'returns value of Photorepository.getPhotoList method',
    () async {
      when(mockPhotoRepository.getPhotos(
        perPage: perPage,
        page: page,
      )).thenAnswer((_) async =>
          Left(GetPhotoListFailure.server(serverFailure: serverFalure)));

      final result = await usecase(param: pageListingParams);

      verify(
        mockPhotoRepository.getPhotos(
          perPage: pageListingParams.perPage,
          page: pageListingParams.page,
        ),
      );
      expect(result,
          Left(GetPhotoListFailure.server(serverFailure: serverFalure)));
      verifyNoMoreInteractions(mockPhotoRepository);
    },
  );
}
