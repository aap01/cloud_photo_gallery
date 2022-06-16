import 'package:cloud_photo_gallery/app.dart';
import 'package:cloud_photo_gallery/core/di/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  await ServiceLocator.inject();
  runApp(const MyApp());
}
