import 'dart:async';

import 'package:cloud_photo_gallery/core/constant/message_constants.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/cell_error_widget.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/full_page_error_widget.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/grid_pattern_constants.dart';
import 'package:cloud_photo_gallery/feature/gallery/presentation/widget/photo_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entity/photo.dart';
import '../cubit/photolist_cubit.dart';

class PhotoGridWidget extends StatelessWidget {
  const PhotoGridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoListCubit>(
      create: (_) => PhotoListCubit(),
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

  @override
  void dispose() {
    _pagingController.dispose();
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
    _listenToScroll();
    super.didChangeDependencies();
  }

  Widget _photoGridBuilderWidget() {
    return BlocListener<PhotoListCubit, PhotoListState>(
      listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            loaded: _onINewItems,
            otherError: (message) {
              _showSnackbar(message);
              _addErrorToPagingController();
            },
            noInternet: () {
              _showSnackbar(MessageConstants.noInternet);
              _addErrorToPagingController();
            });
      },
      child: RefreshIndicator(
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
                  return BlocBuilder<PhotoListCubit, PhotoListState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () => const SizedBox(),
                        loaded: (_) => const SizedBox(),
                        noInternet: () => FullPageError(
                          message: MessageConstants.noInternet,
                          onTryAgain: _onRefresh,
                        ),
                        otherError: (message) => FullPageError(
                          message: message,
                          onTryAgain: _onRefresh,
                        ),
                      );
                    },
                  );
                },
                newPageErrorIndicatorBuilder: (context) {
                  return BlocBuilder<PhotoListCubit, PhotoListState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox(),
                        loading: () => const SizedBox(),
                        loaded: (_) => const SizedBox(),
                        noInternet: () => const SizedBox(),
                        otherError: (message) => CellErrorWidget(
                          message: message,
                          onTryAgain: _onRefresh,
                        ),
                      );
                    },
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
      ),
    );
  }

  void _listenToScroll() {
    _pagingController.addPageRequestListener(_pageRequestListener);
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

  _addErrorToPagingController() {
    _pagingController.error = true;
  }
}
