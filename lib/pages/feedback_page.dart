import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACG大全 問題與回報介面',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansTC',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A6BAF),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF4A6BAF)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ),
      home: const FeedbackScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _bugFormKey = GlobalKey<FormState>();
  final _feedbackFormKey = GlobalKey<FormState>();

  // BUG表單變數
  String _bugTitle = '';
  String _bugSeverity = '';
  String _bugType = '';
  String _bugDescription = '';
  String _appVersion = '';
  String _deviceInfo = '';
  List<PickedFile> _bugFiles = [];

  // 回饋表單變數
  String _feedbackTitle = '';
  String _feedbackType = '';
  String _feedbackDescription = '';
  List<PickedFile> _feedbackFiles = [];

  final severityItems = [
    SeverityItem('severe', '嚴重 BUG（導致 App 無法正常使用）', Colors.red),
    SeverityItem('normal', '普通 BUG（功能部分失效）', Colors.amber),
    SeverityItem('minor', '小 BUG（細微的 UI 問題）', Colors.green),
  ];

  final bugTypeItems = [
    DropdownMenuItem<String>(value: 'general', child: const Text('一般功能問題')),
    DropdownMenuItem<String>(value: 'ui', child: const Text('🎨 UI 問題')),
    DropdownMenuItem<String>(value: 'data', child: const Text('📚 資料錯誤')),
    DropdownMenuItem<String>(value: 'crash', child: const Text('應用閃退')),
    DropdownMenuItem<String>(value: 'performance', child: const Text('效能問題')),
    DropdownMenuItem<String>(value: 'other', child: const Text('其他問題')),
  ];

  final feedbackTypeItems = [
    DropdownMenuItem<String>(value: 'improvement', child: const Text('🛠️ 功能改進建議')),
    DropdownMenuItem<String>(value: 'new-feature', child: const Text('✨ 新功能提案')),
    DropdownMenuItem<String>(value: 'ui-design', child: const Text('🎨 UI/UX 設計建議')),
    DropdownMenuItem<String>(value: 'content', child: const Text('📚 內容相關建議')),
    DropdownMenuItem<String>(value: 'other', child: const Text('其他建議')),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles(bool isBugReport) async {
    try {
      // 建立允許的檔案類型群組
      final typeGroup = XTypeGroup(
        label: 'allowed files',
        extensions: ['jpg', 'jpeg', 'png', 'mp4', 'wav'],
      );
      // 使用 file_selector 開啟檔案選擇器
      final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);

      if (file != null) {
        // 讀取檔案內容以取得檔案大小
        final bytes = await file.readAsBytes();
        final fileSize = bytes.length;

        if (fileSize > 10 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('檔案超過 10MB 限制，已被忽略。'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        // 建立自定義的 PickedFile 物件
        final pickedFile = PickedFile(
          name: file.name,
          size: fileSize,
          path: file.path,
        );

        setState(() {
          if (isBugReport) {
            _bugFiles.add(pickedFile);
          } else {
            _feedbackFiles.add(pickedFile);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('檔案選擇失敗: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeFile(int index, bool isBugReport) {
    setState(() {
      if (isBugReport) {
        _bugFiles.removeAt(index);
      } else {
        _feedbackFiles.removeAt(index);
      }
    });
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  void _submitBugReport() {
    if (_bugFormKey.currentState!.validate()) {
      _bugFormKey.currentState!.save();

      // 處理提交...這裡只是示範，實際使用時需連接到API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('BUG 回報已提交！謝謝您的協助。')),
      );

      // 重置表單
      _bugFormKey.currentState!.reset();
      setState(() {
        _bugTitle = '';
        _bugSeverity = '';
        _bugType = '';
        _bugDescription = '';
        _appVersion = '';
        _deviceInfo = '';
        _bugFiles = [];
      });
    }
  }

  void _submitFeedback() {
    if (_feedbackFormKey.currentState!.validate()) {
      _feedbackFormKey.currentState!.save();

      // 處理提交...這裡只是示範，實際使用時需連接到API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('意見回饋已提交！感謝您的寶貴意見。')),
      );

      // 重置表單
      _feedbackFormKey.currentState!.reset();
      setState(() {
        _feedbackTitle = '';
        _feedbackType = '';
        _feedbackDescription = '';
        _feedbackFiles = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACG大全 App - 問題與回報介面'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'BUG 回報'),
            Tab(text: '意見回饋'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // BUG 回報頁籤
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _bugFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BUG 回報',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF345091),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 問題標題
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '問題標題',
                      hintText: '請簡短描述您遇到的問題',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入問題標題';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _bugTitle = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // BUG 嚴重度
                  const Text(
                    'BUG 嚴重度',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: severityItems.map((item) {
                      return RadioListTile<String>(
                        title: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: item.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text(item.label)),
                          ],
                        ),
                        value: item.value,
                        groupValue: _bugSeverity,
                        onChanged: (String? value) {
                          setState(() {
                            _bugSeverity = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // 問題類型
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: '問題類型',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('請選擇問題類型'),
                    items: bugTypeItems,
                    value: _bugType.isEmpty ? null : _bugType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請選擇問題類型';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        _bugType = newValue!;
                      });
                    },
                    onSaved: (value) {
                      _bugType = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // 問題詳細描述
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '問題詳細描述',
                      hintText: '請詳細描述發生情境、具體操作步驟、錯誤訊息等...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請描述您遇到的問題';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _bugDescription = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // App 版本
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'App 版本',
                      hintText: '例如: Pre-Alpha v0.1.0',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入 App 版本';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _appVersion = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // 設備資訊
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '設備資訊（選填）',
                      hintText: '例如: Samsung Galaxy S21, Android 12',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) {
                      _deviceInfo = value ?? '';
                    },
                  ),
                  const SizedBox(height: 24),
                  // 檔案上傳區域
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '附加檔案（可選）',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickFiles(true),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '點擊上傳檔案',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '支援格式: PNG, JPG, MP4, WAV 等圖片影音檔',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '檔案大小限制: 10MB',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 已上傳檔案列表
                      if (_bugFiles.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '已上傳檔案',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _bugFiles.length,
                              itemBuilder: (context, index) {
                                final file = _bugFiles[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    title: Text(file.name),
                                    subtitle: Text(_formatFileSize(file.size)),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _removeFile(index, true),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // 提交按鈕
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitBugReport,
                      child: const Text(
                        '提交 BUG 回報',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 意見回饋頁籤
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _feedbackFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '意見回饋',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF345091),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 回饋標題
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '回饋標題',
                      hintText: '請簡短描述您的回饋',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入回饋標題';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _feedbackTitle = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // 回饋類型
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: '回饋類型',
                      border: OutlineInputBorder(),
                    ),
                    hint: const Text('請選擇回饋類型'),
                    items: feedbackTypeItems,
                    value: _feedbackType.isEmpty ? null : _feedbackType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請選擇回饋類型';
                      }
                      return null;
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        _feedbackType = newValue!;
                      });
                    },
                    onSaved: (value) {
                      _feedbackType = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  // 回饋詳細描述
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '回饋詳細描述',
                      hintText: '請詳細描述您的建議或想法...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請描述您的意見或建議';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _feedbackDescription = value ?? '';
                    },
                  ),
                  const SizedBox(height: 24),
                  // 檔案上傳區域
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '附加檔案（可選）',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _pickFiles(false),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                '點擊上傳檔案',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '支援格式: PNG, JPG, MP4, WAV 等圖片影音檔',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '檔案大小限制: 10MB',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // 已上傳檔案列表
                      if (_feedbackFiles.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '已上傳檔案',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _feedbackFiles.length,
                              itemBuilder: (context, index) {
                                final file = _feedbackFiles[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    title: Text(file.name),
                                    subtitle: Text(_formatFileSize(file.size)),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => _removeFile(index, false),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // 提交按鈕
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitFeedback,
                      child: const Text(
                        '提交意見回饋',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 嚴重度項目類
class SeverityItem {
  final String value;
  final String label;
  final Color color;

  SeverityItem(this.value, this.label, this.color);
}

// 檔案資訊類
class PickedFile {
  final String name;
  final int size;
  final String? path;

  PickedFile({required this.name, required this.size, this.path});
}
