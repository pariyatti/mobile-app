import 'dart:collection';
import 'dart:developer' as developer;
import 'package:patta/app/log_entry.dart';

/// A manager for application logs that maintains a queue of log entries
/// with constraints on both count and memory usage
class LogManager {
  // Singleton pattern
  static final LogManager _instance = LogManager._internal();
  
  factory LogManager() {
    return _instance;
  }
  
  LogManager._internal();

  // Queue with size and memory constraints
  final Queue<LogEntry> _logs = Queue<LogEntry>();
  
  // Constraints
  static const int _maxLogCount = 1000;
  static const int _maxMemoryBytes = 10 * 1024 * 1024; // 10 MB
  
  // Track current memory usage
  int _currentMemoryUsage = 0;

  /// Adds a new log entry to the queue, respecting size and memory constraints
  void addLog(String message, String level) {
    final entry = LogEntry(message, level);
    final entrySize = entry.estimatedSize;
    
    // Remove oldest entries if constraints would be exceeded
    while ((_logs.length >= _maxLogCount) || 
           (_currentMemoryUsage + entrySize > _maxMemoryBytes && _logs.isNotEmpty)) {
      if (_logs.isNotEmpty) {
        final oldestEntry = _logs.removeFirst();
        _currentMemoryUsage -= oldestEntry.estimatedSize;
      } else {
        break;
      }
    }
    
    // Add new log entry
    _logs.add(entry);
    _currentMemoryUsage += entrySize;
    
    // Also log to developer console
    developer.log(message, name: "app");
  }

  /// Returns all logs in reverse chronological order (newest first)
  List<LogEntry> getLogs() {
    return _logs.toList().reversed.toList();
  }

  /// Clears all logs
  void clearLogs() {
    _logs.clear();
    _currentMemoryUsage = 0;
  }
  
  /// Returns the current memory usage of the log queue in bytes
  int get memoryUsage => _currentMemoryUsage;
  
  /// Returns the current number of log entries
  int get logCount => _logs.length;
}

// Global instance
final logManager = LogManager(); 