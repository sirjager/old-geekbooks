import 'dart:io';

class FileResult {
  final String? filePath;
  final String fileName;
  final Directory dirPath;
  final bool isSucess;

  FileResult({
    required this.dirPath,
    required this.filePath,
    required this.fileName,
    required this.isSucess,
  });
}
