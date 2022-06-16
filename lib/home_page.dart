import 'package:cloud_photo_gallery/core/constant/title_constants.dart';
import 'package:cloud_photo_gallery/core/di/service_locator.dart';
import 'package:cloud_photo_gallery/core/failure/failure.dart';
import 'package:cloud_photo_gallery/core/usecase/params/page_listing_params.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/usecase/get_photo_list_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(TitleConstants.appTitle),
            FutureBuilder(
              future: sl<GetPhotoListUsecase>()
                  .call(param: PageListingParams(perPage: 10, page: 1)),
              builder: (context,
                  AsyncSnapshot<Either<Failure, List<Photo>>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.fold((l) => const Text('Error'),
                      (r) => const Text('Data Loaded'));
                }
                return Text(snapshot.error.toString());
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
