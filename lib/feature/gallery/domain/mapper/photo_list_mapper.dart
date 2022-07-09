// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_photo_gallery/feature/gallery/domain/entity/photo.dart';
import 'package:cloud_photo_gallery/feature/gallery/domain/mapper/domain_mapper.dart';

import '../../data/model/photo_model.dart';



class PhotoListMapper {
  late final DomainMapper<Photo, PhotoModel> _mapper;
  PhotoListMapper({
    required mapper,
  }) {
    _mapper = mapper;
  }
  List<Photo> map(List<PhotoModel> models) =>
      models.map((e) => _mapper.map(e)).toList();
}
