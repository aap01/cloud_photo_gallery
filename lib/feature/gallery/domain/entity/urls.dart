// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Urls extends Equatable{
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;
  const Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });
  
  @override
  List<Object?> get props => [raw, full, regular, small, thumb, smallS3];
}
