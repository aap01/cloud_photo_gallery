import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class Usecase<Param, R> {
  Future<Either<Failure, R>> call({required Param param});
}
