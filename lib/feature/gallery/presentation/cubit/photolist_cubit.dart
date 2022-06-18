// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/core/usecase/params/page_listing_params.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/service_locator.dart';

part 'photolist_cubit.freezed.dart';
part 'photolist_state.dart';

class PhotoListCubit extends Cubit<PhotoListState> {
  final _getPhotoListUsecase = sl<GetPhotoListUsecase>();
  final _networkConnectionChecker = sl<NetworkConnectionChecker>();

  StreamSubscription? _streamSubscription;

  PhotoListCubit({
    PhotoListState initialState = const PhotoListState.initial(),
  }) : super(initialState);

  Future<void> getPhotos({
    int perPage = 10,
    required int page,
  }) async {
    emit(const PhotoListState.loading());
    final photoListEither = await _getPhotoListUsecase(
      param: PageListingParams(perPage: perPage, page: page),
    );
    photoListEither.fold(
      (l) {
        l.map(
          server: (server) => emit(PhotoListState.failed(failure: l)),
          parsing: (parsing) => emit(PhotoListState.failed(failure: l)),
          internet: (internet) {
            _streamSubscription = _networkConnectionChecker
                .connectionStream()
                .listen((event) async {
              if (event) {
                await getPhotos(page: page, perPage: perPage);
                _streamSubscription?.cancel();
              } else {
                emit(PhotoListState.failed(failure: l));
              }
            });
          },
        );
        emit(PhotoListState.failed(failure: l));
      },
      (r) => emit(PhotoListState.loaded(photos: r)),
    );
  }
}
