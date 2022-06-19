import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> read(String path) async =>
    jsonDecode(await File(path).readAsString());
