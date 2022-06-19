// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String self;
  final String html;
  final String download;
  final String downloadLocation;
  const Links({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  @override
  List<Object?> get props => [self, html, download, downloadLocation];
}
