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

  static IconData bookmark() {
    if (Platform.isIOS) {
      return CupertinoIcons.bookmark;
    } else {
      return Icons.bookmark_border;
    }
  }

  static IconData bookmarkFilled() {
    if (Platform.isIOS) {
      return CupertinoIcons.bookmark_solid;
    } else {
      return Icons.bookmark;
    }
  }

  static IconData today() {
    // iOS does not have an icon that looks like this so we are using same icon
    return Icons.today;
  }
}
