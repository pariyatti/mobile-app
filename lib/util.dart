import 'package:patta/extensions/string_ext.dart';

String extractFileExtension(String? filePath) {
  if (filePath!.endsWith("null")) {
    return "jpg";
  }
  return filePath.split('.').last;
}

String toFilename(String s) {
  return s
      .replaceAll(" ", "_")
      .replaceAll(".", "")
      .removeDiacritics();
}
