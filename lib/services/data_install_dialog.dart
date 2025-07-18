import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'data_import.dart';
import '../database/work_database.dart';
import 'notification_service.dart';

class DataInstallDialog extends StatefulWidget {
  final WorkDatabase db;
  const DataInstallDialog({Key? key, required this.db}) : super(key: key);

  @override
  State<DataInstallDialog> createState() => _DataInstallDialogState();
}

class _DataInstallDialogState extends State<DataInstallDialog> {
  double _progress = 0.0;
  String _statusText = "Starting download...";
  bool _downloading = false;

  Future<void> _startDownload() async {
    setState(() {
      _downloading = true;
      _progress = 0.0;
      _statusText = "Downloading data...";
    });
    try {
      await importLatestDataDio(widget.db, onProgress: (received, total) {
        if (total != -1) {
          setState(() {
            _progress = received / total;
            _statusText = "Downloading: ${(_progress * 100).toStringAsFixed(0)}%";
          });
        }
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDataInstalled', true);
      
      // 記錄資料更新時間
      await NotificationService().recordDataUpdate();
      
      setState(() {
        _statusText = "Download complete!";
      });
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _statusText = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('初始資料安裝'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("首次下載資料會消耗流量，請確認您目前使用的是否為 Wi-Fi 或注意行動數據費用。"),
          const SizedBox(height: 16),
          _downloading ? LinearProgressIndicator(value: _progress) : const SizedBox.shrink(),
          const SizedBox(height: 8),
          Text(_statusText),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _downloading ? null : () => Navigator.of(context).pop(),
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: _downloading ? null : _startDownload,
          child: const Text("下載"),
        ),
      ],
    );
  }
}
