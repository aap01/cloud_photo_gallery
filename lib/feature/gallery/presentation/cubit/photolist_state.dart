part of 'photolist_cubit.dart';

@freezed
class PhotolistState with _$PhotolistState {
  const factory PhotolistState.initial() = _Initial;
  const factory PhotolistState.loading() = _Loading;
  const factory PhotolistState.loaded({required List<Photo> photos}) = _Loaded;
  const factory PhotolistState.failed({required GetPhotoListFailure failure}) = _Failure;
}
