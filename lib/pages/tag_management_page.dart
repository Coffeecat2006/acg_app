import 'package:flutter/material.dart';
import '../database/favorites_database.dart';

class TagManagementPage extends StatefulWidget {
  const TagManagementPage({Key? key}) : super(key: key);

  @override
  State<TagManagementPage> createState() => _TagManagementPageState();
}

class _TagManagementPageState extends State<TagManagementPage> {
  List<String> tags = []; // 目前的標籤列表
  final TextEditingController _controller = TextEditingController();
  // 預設可選標籤選項
  final List<String> presetTags = [
    '⭐ 待觀看',
    '✔️ 已觀看',
    '🔥 熱門',
    '💡 推薦'
  ];

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _loadTags() async {
    final data = await FavoritesDatabaseHelper.instance.getTags();
    setState(() {
      tags = data.map((e) => e['tag'] as String).toList();
    });
  }

  Future<void> _addTag(String tag) async {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      await FavoritesDatabaseHelper.instance.insertTag(tag);
      _controller.clear();
      _loadTags();
    }
  }

  Future<void> _removeTag(String tag) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("刪除標籤"),
        content: Text("確定要刪除 '$tag' 嗎？\n這將會移除所有作品中使用此標籤的標記。"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("確定"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await FavoritesDatabaseHelper.instance.deleteTag(tag);
      _loadTags();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("標籤管理"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 預設標籤下拉選單
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "選擇預設標籤",
                border: OutlineInputBorder(),
              ),
              items: presetTags
                  .map((tag) => DropdownMenuItem(
                value: tag,
                child: Text(tag),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _controller.text = value;
                }
              },
            ),
            const SizedBox(height: 16),
            // 輸入新標籤
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "新增標籤",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTag(_controller.text.trim()),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 顯示標籤列表
            Expanded(
              child: ListView.builder(
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return ListTile(
                    title: Text(tag),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTag(tag),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
