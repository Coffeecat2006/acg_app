import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ComicsDetailPage extends StatelessWidget {
  final Map<String, dynamic> work;
  const ComicsDetailPage({Key? key, required this.work}) : super(key: key);

  Future<Map<String, dynamic>> _fetchComicsDetail() async {
    final jsonString =
    await rootBundle.loadString('assets/data/text/comics/2025comics.json');
    final List data = json.decode(jsonString);
    final String comicsId = work['comics_id'];
    final detail = data.firstWhere((element) => element['id'] == comicsId,
        orElse: () {
          return {};
        });
    if (detail is Map && detail.isEmpty) {
      throw Exception("找不到對應的漫畫資料 (comicsId=$comicsId)");
    }
    return detail as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchComicsDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '漫畫詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '漫畫詳細資訊')),
            body: Center(
              child: Text('讀取漫畫資料失敗：${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '漫畫詳細資訊')),
            body: const Center(child: Text('沒有漫畫資料可顯示')),
          );
        } else {
          final comicsDetail = snapshot.data!;
          return Scaffold(
            appBar:
            AppBar(title: Text(comicsDetail['title'] ?? '漫畫詳細資訊')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 顯示封面圖
                  comicsDetail['cover_image'] != null &&
                      comicsDetail['cover_image']['remote'] != null
                      ? Image.network(comicsDetail['cover_image']['remote'],
                      height: 200, fit: BoxFit.cover)
                      : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('無封面圖')),
                  ),
                  const SizedBox(height: 16),
                  Text('標題: ${comicsDetail['title'] ?? '---'}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('出版社: ${comicsDetail['details']?['publisher'] ?? '---'}'),
                  Text('卷數: ${comicsDetail['details']?['volumes'] ?? '---'}'),
                  const SizedBox(height: 8),
                  Text('台版出版日期: ${comicsDetail['details']?['release_date_tw'] ?? '---'}'),
                  Text('日版出版日期: ${comicsDetail['details']?['release_date_jp'] ?? '---'}'),
                  const SizedBox(height: 8),
                  Text('簡介: ${comicsDetail['details']?['synopsis'] ?? '---'}'),
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
