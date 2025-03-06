import 'package:flutter/material.dart';
import 'anime_detail_page.dart';
import 'novel_detail_page.dart';
import 'comics_detail_page.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> work;
  const DetailPage({Key? key, required this.work}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 基本資料，假設這些來自 works.json
    final title = work['title'] ?? '未命名作品';
    final titleJp = work['title_jp'] ?? '';
    final coverUrl = (work['cover_image'] != null && work['cover_image']['remote'] != null)
        ? work['cover_image']['remote']
        : '';
    final synopsis = work['synopsis'] ?? '暫無簡介';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面
            coverUrl.isNotEmpty
                ? Image.network(coverUrl, height: 200, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('無封面圖')),
            ),
            const SizedBox(height: 16),
            Text(title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (titleJp.isNotEmpty)
              Text(titleJp,
                  style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 16),
            Text(synopsis),
            const SizedBox(height: 24),

            // 媒體區塊
            if (work['has_anime'] == true)
              _buildMediaCard(
                context,
                mediaType: '動畫',
                onTapMore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnimeDetailPage(work: work),
                    ),
                  );
                },
              ),
            if (work['has_novel'] == true)
              _buildMediaCard(
                context,
                mediaType: '輕小說',
                onTapMore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NovelDetailPage(work: work),
                    ),
                  );
                },
              ),
            if (work['has_comics'] == true)
              _buildMediaCard(
                context,
                mediaType: '漫畫',
                onTapMore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ComicsDetailPage(work: work),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCard(BuildContext context, {required String mediaType, required VoidCallback onTapMore}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('該作品有 $mediaType 版本'),
        trailing: ElevatedButton(
          onPressed: onTapMore,
          child: const Text('查看更多'),
        ),
      ),
    );
  }
}
