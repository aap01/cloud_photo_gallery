import 'package:dartz/dartz.dart';

import '../failure/failure.dart';

abstract class Usecase<Param, R, T extends Failure> {
  Future<Either<T, R>> call({required Param param});
}
