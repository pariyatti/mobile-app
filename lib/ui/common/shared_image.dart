
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patta/util.dart';
import 'package:share_plus/share_plus.dart';

class SharedImage {
  late Uint8List bytes;
  late String filename;
  late String extension;

  SharedImage(imageBytes, title, oldUrl) {
    bytes = imageBytes;
    filename = toFilename(title);
    extension = extractFileExtension(oldUrl);
  }

  Future<XFile> toXFile() async {
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/$filename.$extension';
    File(path).writeAsBytesSync(bytes);

    return XFile.fromData(bytes,
      mimeType: 'image/$extension',
      name: '$filename.$extension',
      length: bytes.length,
      lastModified: DateTime.now(),
      path: path,
    );
  }

  static Future<Uint8List> getBytesFromRenderKey(GlobalKey renderKey) async {
    try {
      RenderRepaintBoundary boundary =
          renderKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      var pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
      throw e;
    }
  }

}