import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<String> get documentsDirectoryPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> download(String filename, String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final newFile = File('${await documentsDirectoryPath}/$filename');
    return await newFile.writeAsBytes(bytes);
  }

  static Future<OpenResult> open(String path) {
    return OpenFile.open(path);
  }
}
