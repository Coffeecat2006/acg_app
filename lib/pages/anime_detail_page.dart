import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AnimeDetailPage extends StatelessWidget {
  final Map<String, dynamic> work;
  const AnimeDetailPage({Key? key, required this.work}) : super(key: key);

  Future<Map<String, dynamic>> _fetchAnimeDetail() async {
    final String animeId = work['anime_id'];
    final String year = animeId.substring(0, 4); // 如果動畫ID也包含年份
    final jsonString =
    await rootBundle.loadString('assets/data/text/animate/${year}animate.json');
    final List data = json.decode(jsonString);
    final detail = data.firstWhere((element) => element['id'] == animeId,
        orElse: () => {});
    if (detail is Map && detail.isEmpty) {
      throw Exception("找不到對應的動畫資料 (animeId=$animeId)");
    }
    return detail as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchAnimeDetail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '動畫詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '動畫詳細資訊')),
            body: Center(
              child: Text('讀取動畫資料失敗：${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(work['title'] ?? '動畫詳細資訊')),
            body: const Center(child: Text('沒有動畫資料可顯示')),
          );
        } else {
          final animeDetail = snapshot.data!;
          return Scaffold(
            appBar:
            AppBar(title: Text(animeDetail['title'] ?? '動畫詳細資訊')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 可顯示封面
                  animeDetail['cover_image'] != null &&
                      animeDetail['cover_image']['remote'] != null
                      ? Image.network(animeDetail['cover_image']['remote'],
                      height: 200, fit: BoxFit.cover)
                      : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('無封面圖')),
                  ),
                  const SizedBox(height: 16),
                  Text('標題: ${animeDetail['title'] ?? '---'}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('製作廠商: ${animeDetail['details']?['studio'] ?? '---'}'),
                  Text('代理商: ${animeDetail['details']?['publisher'] ?? '---'}'),
                  const SizedBox(height: 8),
                  Text('簡介: ${animeDetail['details']?['synopsis'] ?? '---'}'),
                  const SizedBox(height: 16),
                  // 更多欄位可以依需求繼續擴充
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
