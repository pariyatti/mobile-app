import 'dart:async';
import 'dart:developer' as developer;
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/// A comprehensive logging system for the Pariyatti app that provides:
/// - In-memory circular buffer for recent logs
/// - File-based persistent logging with rotation
/// - Console logging for debugging
/// - Multiple severity levels (debug, info, warning, error)
class AppLogger {
  // Core logging components
  static final Logger _logger = Logger('PariyattiApp');
  static bool _initialized = false;
  static File? _logFile;
  
  // In-memory circular buffer
  static final List<String> _memoryLogs = [];
  static const int _maxMemoryLogs = 1000;

  /// Initializes the logging system. Must be called before any logging operations.
  static Future<void> init() async {
    if (_initialized) return;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      String logMessage = '${record.time}: ${record.level.name}: ${record.message}';
      if (record.error != null) {
        logMessage += '\nError: ${record.error}';
      }
      if (record.stackTrace != null) {
        logMessage += '\nStack Trace:\n${record.stackTrace}';
      }

      // Store in circular buffer
      _memoryLogs.add(logMessage);
      if (_memoryLogs.length > _maxMemoryLogs) {
        _memoryLogs.removeAt(0);
      }

      // Write to persistent storage
      _writeToFile(logMessage);

      // Output to debug console
      developer.log(
        record.message,
        time: record.time,
        level: record.level.value,
        name: record.loggerName,
        error: record.error,
        stackTrace: record.stackTrace,
      );
    });

    await _initLogFile();
    _initialized = true;
  }

  /// Sets up the log file with rotation support
  static Future<void> _initLogFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/pariyatti.log');
    
    if (!await _logFile!.exists()) {
      await _logFile!.create();
    }
    
    // Implement log rotation
    final fileSize = await _logFile!.length();
    if (fileSize > 5 * 1024 * 1024) {
      final backupFile = File('${directory.path}/pariyatti.log.bak');
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
      await _logFile!.rename('${directory.path}/pariyatti.log.bak');
      _logFile = File('${directory.path}/pariyatti.log');
      await _logFile!.create();
    }
  }

  /// Writes a log message to the persistent log file
  static Future<void> _writeToFile(String message) async {
    if (_logFile != null) {
      await _logFile!.writeAsString('$message\n', mode: FileMode.append);
    }
  }

  // Public logging methods
  static void info(String message) {
    _logger.info(message);
  }

  static void warning(String message) {
    _logger.warning(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  static void debug(String message) {
    _logger.fine(message);
  }

  /// Returns all logs in reverse chronological order
  static List<String> getLogs() {
    return List.from(_memoryLogs.reversed);
  }

  /// Clears both in-memory and file-based logs
  static Future<void> clearLogs() async {
    _memoryLogs.clear();
    if (_logFile != null && await _logFile!.exists()) {
      await _logFile!.delete();
      await _initLogFile();
    }
  }
} 