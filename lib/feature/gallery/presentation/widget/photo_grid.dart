import 'dart:async';

import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/core/failure/get_photo_list_failure.dart';
import 'package:cloud_photo_gallery/core/network/netowork_connection_checker.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/cell_error_widget.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/full_page_error_widget.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/grid_pattern_constants.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/photo_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/di/service_locator.dart';
import '../../domain/entity/photo.dart';
import '../../domain/usecase/get_photo_list_usecase.dart';
import '../cubit/photolist_cubit.dart';

class PhotoGridWidget extends StatelessWidget {
  const PhotoGridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoListCubit>(
      create: (_) => PhotoListCubit(
        getPhotoListUsecase: sl<GetPhotoListUsecase>(),
      ),
      child: const _PhotoGridBuilderWidget(),
    );
  }
}

class _PhotoGridBuilderWidget extends StatefulWidget {
  const _PhotoGridBuilderWidget({Key? key}) : super(key: key);

  @override
  State<_PhotoGridBuilderWidget> createState() =>
      _PhotoGridBuilderWidgetState();
}

class _PhotoGridBuilderWidgetState extends State<_PhotoGridBuilderWidget> {
  late PhotoListCubit _photoListCubit;
  final _pagingController = PagingController<int, Photo>(
    firstPageKey: 1,
    invisibleItemsThreshold: 1,
  );
  static const _perPage = 10;
  int _pageKey = 1;
  late Function(int) _pageRequestListener;
  StreamSubscription? _sub;

  @override
  void dispose() {
    _pagingController.dispose();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _photoGridBuilderWidget();
  }

  @override
  void didChangeDependencies() {
    _photoListCubit = context.read<PhotoListCubit>();
    _pageRequestListener = (pageKey) {
      _photoListCubit.getPhotos(
        page: pageKey,
        perPage: _perPage,
      );
    };
    _listentToCubit();
    _listenToScroll();
    super.didChangeDependencies();
  }

  Widget _photoGridBuilderWidget() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        slivers: [
          PagedSliverGrid<int, Photo>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Photo>(
              itemBuilder: (context, item, index) {
                return PhotoGridTileWidget(photo: item);
              },
              firstPageErrorIndicatorBuilder: (context) {
                final message = _messageFromFailure(
                  _pagingController.error,
                );
                return FullPageError(
                  message: message,
                  onTryAgain: _onTryAgain,
                );
              },
              newPageErrorIndicatorBuilder: (context) {
                final message = _messageFromFailure(
                  _pagingController.error,
                );
                return CellErrorWidget(
                  message: message,
                  onTryAgain: _pagingController.retryLastFailedRequest,
                );
              },
              // newPageErrorIndicatorBuilder:
            ),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              repeatPattern: QuiltedGridRepeatPattern.same,
              pattern: GridPatternConstants.galleryPattern,
            ),
          )
        ],
      ),
    );
  }

  void _listenToScroll() {
    _pagingController.addPageRequestListener(_pageRequestListener);
  }

  void _listentToCubit() {
    _photoListCubit.stream.listen(
      (state) => {
        state.when(
          initial: () {},
          loading: () {},
          loaded: _onINewItems,
          failed: _onError,
        )
      },
    );
  }

  void _onError(GetPhotoListFailure failure) {
    final message = _messageFromFailure(failure);
    _showSnackbar(message);
    _pagingController.error = failure;
    if (message == MessageConstants.noInternet) {
      _sub = sl<NetworkConnectionChecker>().connectionStream().listen((event) {
        if (event) {
          _pagingController.retryLastFailedRequest();
          _sub?.cancel();
        }
      });
    }
  }

  void _onINewItems(List<Photo> newItems) {
    _pageKey++;
    if (newItems.length < _perPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      _pagingController.appendPage(newItems, _pageKey);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _pagingController.refresh();
  }

  String _messageFromFailure(GetPhotoListFailure failure) => failure.when(
        server: (serverFailure) => serverFailure.message,
        parsing: (parsingFailure) => MessageConstants.internalError,
        internet: (internetFailure) => MessageConstants.noInternet,
      );

  _onTryAgain() {
    _pagingController.refresh();
  }
}
