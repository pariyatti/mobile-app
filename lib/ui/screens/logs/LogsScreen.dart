import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/log_manager.dart';
import 'package:patta/app/log_entry.dart';
import 'package:share_plus/share_plus.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';

/// A screen that displays application logs with color-coded entries based on severity
/// and provides options to refresh and clear logs.
class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<LogEntry> _logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  void _loadLogs() {
    try {
      setState(() {
        _isLoading = true;
      });
      
      setState(() {
        _logs = logManager.getLogs();
        _isLoading = false;
      });
      logManager.addLog('Logs loaded successfully', 'DEBUG');
    } catch (e, st) {
      setState(() {
        _isLoading = false;
      });
      logManager.addLog('Failed to load logs: $e\n$st', 'ERROR');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(I18n.get('try_again_later')))
      );
    }
  }

  void _clearLogs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(I18n.get('clear_logs')),
          content: Text(I18n.get('clear_logs_confirm')),
          actions: <Widget>[
            TextButton(
              child: Text(I18n.get('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(I18n.get('clear')),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  logManager.clearLogs();
                  _loadLogs();
                  logManager.addLog('Logs cleared successfully', 'DEBUG');
                } catch (e, st) {
                  logManager.addLog('Failed to clear logs: $e\n$st', 'ERROR');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(I18n.get('try_again_later')))
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _shareLogs() {
    if (_logs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(I18n.get('logs_empty')))
      );
      return;
    }
    
    try {
      final String logsText = _logs.map((log) => log.toString()).join('\n\n');
      Share.share(logsText, subject: 'Pariyatti App Logs');
      logManager.addLog('Logs shared successfully', 'DEBUG');
    } catch (e, st) {
      logManager.addLog('Failed to share logs: $e\n$st', 'ERROR');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(I18n.get('try_again_later')))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.get('logs')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadLogs,
            tooltip: I18n.get('refresh_logs'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearLogs,
            tooltip: I18n.get('clear_logs'),
          ),
          IconButton(
            icon: Icon(PariyattiIcons.get(IconName.share)),
            onPressed: _shareLogs,
            tooltip: I18n.get('share_logs'),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _logs.isEmpty
              ? Center(
                  child: Text(
                    I18n.get('logs_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    _loadLogs();
                  },
                  child: ListView.builder(
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[index];
                      final logText = log.toString();
                      final isError = log.level == 'ERROR' || logText.contains('ERROR') || logText.contains('SEVERE');
                      final isWarning = log.level == 'WARNING' || logText.contains('WARNING');
                      
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isError
                              ? Theme.of(context).colorScheme.errorContainer
                              : isWarning
                                  ? Theme.of(context).colorScheme.secondaryContainer
                                  : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: isError
                                ? Theme.of(context).colorScheme.error
                                : isWarning
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.outline,
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          logText,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isError
                                    ? Theme.of(context).colorScheme.onErrorContainer
                                    : isWarning
                                        ? Theme.of(context).colorScheme.onSecondaryContainer
                                        : Theme.of(context).colorScheme.onSurface,
                                fontFamily: 'monospace',
                              ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
} 