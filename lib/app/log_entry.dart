import 'dart:convert';

/// Represents a single log entry with timestamp, message, and level information
class LogEntry {
  final DateTime timestamp;
  final String message;
  final String level;

  LogEntry(this.message, this.level) : timestamp = DateTime.now();

  @override
  String toString() {
    return "${timestamp.toIso8601String()}: $level: $message";
  }
  
  /// Estimates the memory size of this log entry in bytes
  int get estimatedSize {
    // Rough estimate: 
    // - DateTime ~= 8 bytes
    // - Each character in strings ~= 2 bytes (UTF-16)
    // - Object overhead ~= 16 bytes
    return 8 + (message.length * 2) + (level.length * 2) + 16;
  }
} 