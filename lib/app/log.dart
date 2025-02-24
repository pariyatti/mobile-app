import 'dart:developer';
import 'dart:collection';

class LogEntry {
  final DateTime timestamp;
  final String message;
  final int level;

  LogEntry(this.timestamp, this.message, this.level);

  @override
  String toString() {
    return '${timestamp.toIso8601String()} [Level $level]: $message';
  }
}

class LogManager {
  static final LogManager _instance = LogManager._internal();
  static const int maxLogs = 1000;

  factory LogManager() {
    return _instance;
  }

  LogManager._internal();

  final Queue<LogEntry> _logs = Queue<LogEntry>();

  void addLog(String msg, {int level = 1}) {
    if (_logs.length >= maxLogs) {
      _logs.removeFirst();
    }
    _logs.add(LogEntry(DateTime.now(), msg, level));
    
    // Also send to developer console
    log(msg, level: level, name: "app");
  }

  List<LogEntry> getLogs() {
    return List.from(_logs.toList().reversed);
  }

  void clearLogs() {
    _logs.clear();
  }
}

final logManager = LogManager();

void log2(String msg) {
  // Add to our log manager
  logManager.addLog(msg);
  
  // Also print for local debugging
  print(msg);
}
