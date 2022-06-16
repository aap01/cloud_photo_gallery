// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/usecase/params/page_listing_params.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photolist_cubit.freezed.dart';
part 'photolist_state.dart';

class PhotolistCubit extends Cubit<PhotolistState> {
  late GetPhotoListUsecase _getPhotoListUsecase;

  PhotolistCubit({
    required getPhotoListUsecase,
  }) : super(const PhotolistState.initial()) {
    _getPhotoListUsecase = getPhotoListUsecase;
  }

  void getPhotos({
    required int perPage,
    required int page,
  }) async {
    emit(const PhotolistState.loading());
    final photoListEither = await _getPhotoListUsecase(
        param: PageListingParams(perPage: perPage, page: page));
    photoListEither.fold(
      (l) => emit(PhotolistState.failed(failure: l)),
      (r) => emit(PhotolistState.loaded(photos: r)),
    );
  }
}
