import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class NovelDetailPage extends StatelessWidget {
  final Map<String, dynamic> work;
  const NovelDetailPage({Key? key, required this.work}) : super(key: key);

  Future<Map<String, dynamic>> _fetchNovelDetail() async {
    final String novelId = work['novel_id'];
    final String year = novelId.substring(0, 4); // 取前四個字作為年份
    final jsonString =
    await rootBundle.loadString('assets/data/text/novel/${year}novel.json');
    final List data = json.decode(jsonString);
    final detail = data.firstWhere((element) => element['id'] == novelId,
        orElse: () => {});
    if (detail is Map && detail.isEmpty) {
      throw Exception("找不到對應的輕小說資料 (novelId=$novelId)");
    }
    return detail as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchNovelDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '輕小說詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '輕小說詳細資訊')),
            body: Center(
              child: Text('讀取輕小說資料失敗：${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '輕小說詳細資訊')),
            body: const Center(child: Text('沒有輕小說資料可顯示')),
          );
        } else {
          final novelDetail = snapshot.data!;
          return Scaffold(
            appBar:
            AppBar(title: Text(novelDetail['title'] ?? '輕小說詳細資訊')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 顯示封面圖
                  novelDetail['cover_image'] != null &&
                      novelDetail['cover_image']['remote'] != null
                      ? Image.network(novelDetail['cover_image']['remote'],
                      height: 200, fit: BoxFit.cover)
                      : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('無封面圖')),
                  ),
                  const SizedBox(height: 16),
                  Text('標題: ${novelDetail['title'] ?? '---'}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                      '作者: ${novelDetail['details']?['author'] ?? '---'} / 插畫: ${novelDetail['details']?['illustrator'] ?? '---'}'),
                  const SizedBox(height: 8),
                  Text(
                      '台版出版日期: ${novelDetail['details']?['publish_date_tw'] ?? '---'}'),
                  Text(
                      '日版出版日期: ${novelDetail['details']?['publish_date_jp'] ?? '---'}'),
                  const SizedBox(height: 8),
                  Text('簡介: ${novelDetail['details']?['synopsis'] ?? '---'}'),
                  // 更多欄位依需求補充
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
