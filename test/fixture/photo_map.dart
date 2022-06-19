import 'fixture_reader.dart';

Future<Map<String, dynamic>> getPhotoMap() async =>
    read('test/fixture/photo.json');
