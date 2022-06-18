part of 'photolist_cubit.dart';

@freezed
class PhotoListState with _$PhotoListState {
  const factory PhotoListState.initial() = _Initial;
  const factory PhotoListState.loading() = _Loading;
  const factory PhotoListState.loaded({required List<Photo> photos}) = _Loaded;
  const factory PhotoListState.noInternet() = _NoInternet;
  const factory PhotoListState.otherError({required String message}) =
      _OtherError;
}
