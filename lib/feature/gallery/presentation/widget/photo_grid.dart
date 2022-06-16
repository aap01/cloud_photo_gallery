import 'package:cached_network_image/cached_network_image.dart';
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
      child: const PhotoGridBuilderWidget(),
    );
  }
}

class PhotoGridBuilderWidget extends StatefulWidget {
  const PhotoGridBuilderWidget({Key? key}) : super(key: key);

  @override
  State<PhotoGridBuilderWidget> createState() => _PhotoGridBuilderWidgetState();
}

class _PhotoGridBuilderWidgetState extends State<PhotoGridBuilderWidget> {
  late PhotoListCubit _photoListCubit;
  final _pagingController = PagingController<int, Photo>(
    firstPageKey: 0,
    invisibleItemsThreshold: 5,
  );
  static const _perPage = 10;
  int _pageKey = 0;
  int _page = 1;

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _photoGridBuilderWidget();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _photoListCubit = context.read<PhotoListCubit>();
    _listentToCubit();
    _listenToScroll();
  }

  Widget _photoGridBuilderWidget() {
    return CustomScrollView(
      slivers: [
        PagedSliverGrid<int, Photo>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Photo>(
            itemBuilder: (context, item, index) {
              return GridTile(
                child: CachedNetworkImage(
                  imageUrl: item.urls?.regular ?? '',
                  errorWidget: (context, url, err) =>
                      Text('${item.id} imageNotFound'),
                ),
              );
            },
          ),
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: [
              const QuiltedGridTile(2, 2),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 1),
              const QuiltedGridTile(1, 2),
            ],
          ),
        )
      ],
    );
  }

  _listenToScroll() {
    _pagingController.addPageRequestListener((pageKey) {
      _photoListCubit.getPhotos(
        page: _page,
        perPage: _perPage,
      );
    });
  }

  _listentToCubit() {
    _photoListCubit.stream.listen(
      (state) => {
        state.when(
          initial: () {},
          loading: () {},
          loaded: (newItems) {
            _pageKey = _pageKey + newItems.length;
            _page++;
            if (newItems.length < _perPage) {
              _pagingController.appendLastPage(newItems);
            } else {
              _pagingController.appendPage(newItems, _pageKey);
            }
          },
          failed: (error) {},
        )
      },
    );
  }
}
