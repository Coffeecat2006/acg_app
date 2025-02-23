import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> work;
  const DetailPage({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAnime = work['has_anime'] == true;
    final isComics = work['has_comics'] == true;
    final isNovel = work['has_novel'] == true;

    return Scaffold(
      appBar: AppBar(title: Text(work['title'] ?? '詳細')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('封面圖')),
            ),
            const SizedBox(height: 16),
            Text(work['title'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (work['title_jp'] != null) Text(work['title_jp']),
            const SizedBox(height: 16),
            if (isAnime) _buildAnimeSection(),
            if (isComics || isNovel) _buildBookSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimeSection() {
    // 在這裡可以讀取 work['studio']、work['publisher']、op/ed、配音員等欄位
    // 本示範僅列出幾個假欄位
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('【動畫資訊】', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('製作廠商: ${work['studio'] ?? '---'}'),
        Text('代理商: ${work['publisher'] ?? '---'}'),
        // ...可再擴充
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBookSection() {
    // 在這裡可以讀取 work['author']、work['illustrator']、work['publish_date_jp'] 等欄位
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('【書籍資訊】', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('作者: ${work['author'] ?? '---'} / 插畫: ${work['illustrator'] ?? '---'}'),
        Text('出版社: ${work['publisher'] ?? '---'}'),
        // ...可再擴充
        const SizedBox(height: 16),
      ],
    );
  }
}
