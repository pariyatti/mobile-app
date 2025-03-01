import 'dart:developer';
import 'package:patta/app/log_manager.dart';

/// Logs a message to both the console and the LogManager
/// 
/// This function maintains backward compatibility with existing code
/// while integrating with the new logging system
void log2(String msg) {
  // lazy local debugging:
  print(msg);
  
  // add to log manager
  logManager.addLog(msg, "INFO");
  
  // the actual log message:
  log(msg, level: 1, name: "app");
}
