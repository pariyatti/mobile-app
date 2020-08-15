import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PariyattiIcons {
  static IconData share() {
    if (Platform.isIOS) {
      return CupertinoIcons.share;
    } else {
      return Icons.share;
    }
  }
}
