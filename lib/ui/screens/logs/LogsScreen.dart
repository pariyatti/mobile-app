import 'package:flutter/material.dart';
import 'package:patta/app/I18n.dart';
import 'package:patta/app/log.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:share_plus/share_plus.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<LogEntry> _logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _logs = logManager.getLogs();
      _isLoading = false;
    });
  }

  Future<void> _clearLogs() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(I18n.get("clear_logs")),
          content: Text(I18n.get("clear_logs_confirm")),
          actions: <Widget>[
            TextButton(
              child: Text(I18n.get("cancel")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(I18n.get("clear")),
              onPressed: () {
                logManager.clearLogs();
                Navigator.of(context).pop();
                _loadLogs();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _shareLogs() async {
    if (_logs.isEmpty) return;
    
    final String logsText = _logs.map((log) => log.toString()).join('\n');
    await Share.share(logsText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.get("logs")),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            icon: Icon(PariyattiIcons.get(IconName.share)),
            onPressed: _logs.isEmpty ? null : _shareLogs,
            tooltip: I18n.get("share_logs"),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadLogs,
            tooltip: I18n.get("refresh_logs"),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: _logs.isEmpty ? null : _clearLogs,
            tooltip: I18n.get("clear_logs"),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_logs.isEmpty) {
      return Center(
        child: Text(
          I18n.get("logs_empty"),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        final log = _logs[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(
              log.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              log.timestamp.toLocal().toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ),
        );
      },
    );
  }
} 