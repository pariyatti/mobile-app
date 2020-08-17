import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum IconName {
  share,
  bookmark,
  bookmarkFilled,
  today,
  person,
  error,
}

const Map<IconName, Map<String, IconData>> _iconMap = {
  IconName.share: {
    'default': Icons.share,
    'ios': CupertinoIcons.share,
  },
  IconName.bookmark: {
    'default': Icons.bookmark_border,
    'ios': CupertinoIcons.bookmark,
  },
  IconName.bookmarkFilled: {
    'default': Icons.bookmark,
    'ios': CupertinoIcons.bookmark_solid,
  },
  IconName.today: {
    'default': Icons.today,
  },
  IconName.person: {
    'default': Icons.person,
    'ios': CupertinoIcons.person_solid,
  },
  IconName.error: {
    'default': Icons.error_outline,
    'ios': CupertinoIcons.info,
  },
};

class PariyattiIcons {
  static IconData get(IconName name) {
    final icons = _iconMap[name];
    if (icons.containsKey(Platform.operatingSystem)) {
      return icons[Platform.operatingSystem];
    } else {
      return icons['default'];
    }
  }

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

  static IconData person() {
    if (Platform.isIOS) {
      return CupertinoIcons.person_solid;
    } else {
      return Icons.person;
    }
  }

  static IconData error() {
    if (Platform.isIOS) {
      return CupertinoIcons.info;
    } else {
      return Icons.error_outline;
    }
  }
}
