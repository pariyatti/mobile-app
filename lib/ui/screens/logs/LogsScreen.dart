import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/logger.dart';
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
  List<String> _logs = [];
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
        _logs = AppLogger.getLogs();
        _isLoading = false;
      });
      AppLogger.debug('Logs loaded successfully');
    } catch (e, st) {
      setState(() {
        _isLoading = false;
      });
      AppLogger.error('Failed to load logs', e, st);
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
                  await AppLogger.clearLogs();
                  _loadLogs();
                  AppLogger.debug('Logs cleared successfully');
                } catch (e, st) {
                  AppLogger.error('Failed to clear logs', e, st);
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
      final String logsText = _logs.join('\n\n');
      Share.share(logsText, subject: 'Pariyatti App Logs');
      AppLogger.debug('Logs shared successfully');
    } catch (e, st) {
      AppLogger.error('Failed to share logs', e, st);
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
                      final isError = log.contains('ERROR') || log.contains('SEVERE');
                      final isWarning = log.contains('WARNING');
                      
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
                          log,
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