import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _subTabController;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 3, vsync: this);
    _subTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _subTabController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: SafeArea(
              child: TabBar(
                controller: _mainTabController,
                indicatorColor: Theme.of(context).colorScheme.primary,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                tabs: const [
                  Tab(text: '動畫'),
                  Tab(text: '小說'),
                  Tab(text: '漫畫'),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: TabBar(
              controller: _subTabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(text: '熱門度'),
                Tab(text: '評分'),
                Tab(text: '收藏數'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _mainTabController,
              children: [
                _buildRankingList(_animeData),
                _buildRankingList(_novelData),
                _buildRankingList(_comicsData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankingList(List<RankingItem> data) {
    return TabBarView(
      controller: _subTabController,
      children: [
        _buildRankingListView(data, '熱門'),
        _buildRankingListView(data, '評分'),
        _buildRankingListView(data, '收藏'),
      ],
    );
  }

  Widget _buildRankingListView(List<RankingItem> data, String type) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildRankingCard(item, index + 1, type);
      },
    );
  }

  Widget _buildRankingCard(RankingItem item, int rank, String type) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // 排名徽章
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getRankColor(rank),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 封面圖片
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: Icon(
                Icons.image,
                size: 30,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            // 內容區域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatNumber(item.favorites),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 數值顯示
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _getDisplayValue(item, type),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getRankColor(rank),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getDisplayLabel(type),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }

  String _formatNumber(int number) {
    if (number >= 10000) {
      return '${(number / 10000).toStringAsFixed(1)}萬';
    }
    return number.toString();
  }

  String _getDisplayValue(RankingItem item, String type) {
    switch (type) {
      case '熱門':
        return _formatNumber(item.popularity);
      case '評分':
        return item.rating.toStringAsFixed(1);
      case '收藏':
        return _formatNumber(item.favorites);
      default:
        return '';
    }
  }

  String _getDisplayLabel(String type) {
    switch (type) {
      case '熱門':
        return '熱門度';
      case '評分':
        return '評分';
      case '收藏':
        return '收藏數';
      default:
        return '';
    }
  }

  // 假資料
  final List<RankingItem> _animeData = [
    RankingItem('<測試用文字>', '<測試用文字>', 9.2, 56780, 123456),
    RankingItem('<測試用文字>', '<測試用文字>', 9.0, 78901, 234567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.8, 45123, 187654),
    RankingItem('<測試用文字>', '<測試用文字>', 8.7, 34567, 156789),
    RankingItem('<測試用文字>', '<測試用文字>', 8.9, 67890, 198765),
    RankingItem('<測試用文字>', '<測試用文字>', 8.5, 23456, 134567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.6, 45678, 145678),
    RankingItem('<測試用文字>', '<測試用文字>', 8.4, 56789, 176543),
    RankingItem('<測試用文字>', '<測試用文字>', 8.3, 67890, 198765),
    RankingItem('<測試用文字>', '<測試用文字>', 8.8, 78901, 245678),
  ];

  final List<RankingItem> _novelData = [
    RankingItem('<測試用文字>', '<測試用文字>', 8.9, 45670, 178943),
    RankingItem('<測試用文字>', '<測試用文字>', 8.7, 38901, 165432),
    RankingItem('<測試用文字>', '<測試用文字>', 8.5, 29876, 134567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.8, 56789, 187654),
    RankingItem('<測試用文字>', '<測試用文字>', 8.6, 34567, 145678),
    RankingItem('<測試用文字>', '<測試用文字>', 8.4, 23456, 123456),
    RankingItem('<測試用文字>', '<測試用文字>', 8.3, 18765, 198765),
    RankingItem('<測試用文字>', '<測試用文字>', 8.7, 45678, 156789),
    RankingItem('<測試用文字>', '<測試用文字>', 8.5, 34567, 145678),
    RankingItem('<測試用文字>', '<測試用文字>', 8.6, 28901, 167890),
  ];

  final List<RankingItem> _comicsData = [
    RankingItem('<測試用文字>', '<測試用文字>', 8.8, 67890, 234567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.9, 78901, 245678),
    RankingItem('<測試用文字>', '<測試用文字>', 8.7, 56789, 198765),
    RankingItem('<測試用文字>', '<測試用文字>', 9.0, 89012, 267890),
    RankingItem('<測試用文字>', '<測試用文字>', 8.6, 45678, 187654),
    RankingItem('<測試用文字>', '<測試用文字>', 8.5, 67890, 234567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.9, 78901, 278901),
    RankingItem('<測試用文字>', '<測試用文字>', 8.4, 34567, 156789),
    RankingItem('<測試用文字>', '<測試用文字>', 8.7, 56789, 234567),
    RankingItem('<測試用文字>', '<測試用文字>', 8.5, 23456, 145678),
  ];
}

class RankingItem {
  final String title;
  final String subtitle;
  final double rating;
  final int favorites;
  final int popularity;

  RankingItem(this.title, this.subtitle, this.rating, this.favorites, this.popularity);
}
