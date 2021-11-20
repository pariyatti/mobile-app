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
  none
}

const _iosMissing = CupertinoIcons.multiply_circle;
const _androidMissing = Icons.broken_image;

const Map<String, IconData> _iconMissing = {
  'default': _androidMissing,
  'ios': _iosMissing,
};

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
  IconName.none: _iconMissing
};

class PariyattiIcons {
  static IconData get(IconName name) {
    final icons = _iconMap[name] ?? _iconMissing;
    if (icons.containsKey(Platform.operatingSystem)) {
      return icons[Platform.operatingSystem] ?? _iosMissing;
    } else {
      return icons['default'] ?? _androidMissing;
    }
  }
}
