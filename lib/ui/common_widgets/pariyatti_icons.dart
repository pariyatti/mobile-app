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
  play,
  pause,
  stop,
  none
}

const _iosMissing = CupertinoIcons.multiply_circle;
const _androidMissing = Icons.broken_image;

const Map<String, IconData> _iconMissing = {
  'default': _androidMissing,
  'ios': _iosMissing,
};

// NOTE: For some bizarre reason, the Cupertino Icons gallery is a 404 on the
//       current webpage. To look up Cupertino Icons, use archive.org:
//       https://web.archive.org/web/20210728212734/https://flutter.github.io/cupertino_icons/
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
  IconName.play: {
    'default': Icons.play_circle_fill,
    'ios': CupertinoIcons.play_circle_fill
  },
  IconName.pause: {
    'default': Icons.pause_circle_filled,
    'ios': CupertinoIcons.pause_circle_fill
  },
  IconName.stop: {
    'default': Icons.stop_circle, // despite the name, this is also '_fill'
    'ios': CupertinoIcons.stop_circle_fill
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
