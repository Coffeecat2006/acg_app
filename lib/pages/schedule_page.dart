import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<AnimeEpisode> _animeEpisodes = [];
  List<BookRelease> _bookReleases = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 初始化前先呼叫 async 方法
    _initData();
  }

  Future<void> _initData() async {
    // 請根據您實際的 JSON 檔路徑與解析方式來改寫
    _animeEpisodes = await _loadAnimeData();
    _bookReleases = await _loadBookData();

    // 更新畫面
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 假裝讀取 2025animate.json，解析「每集播出時間」後，整理成 AnimeEpisode
  Future<List<AnimeEpisode>> _loadAnimeData() async {
    // 假裝讀取本地 JSON
    final jsonString = await rootBundle.loadString('assets/data/text/animate/2025animate.json');
    final List rawList = json.decode(jsonString);

    final List<AnimeEpisode> result = [];
    for (var item in rawList) {
      final details = item['details'] as Map?;
      if (details == null) continue;
      final seasons = details['seasons'] as List?;
      if (seasons == null) continue;

      // 取出動畫標題
      final animeTitle = item['title'] ?? '???';

      for (var s in seasons) {
        final episodes = s['episodes'] as List?;
        if (episodes == null) continue;
        for (var ep in episodes) {
          final epNumber = ep['episode_number'] ?? 0;
          final airTimeStr = ep['air_time'] ?? '';
          final airTime = DateTime.tryParse(airTimeStr);
          if (airTime != null) {
            result.add(AnimeEpisode(
              animeTitle: animeTitle,
              episodeNumber: epNumber,
              airTime: airTime,
            ));
          }
        }
      }
    }

    // 按時間排序
    result.sort((a, b) => a.airTime.compareTo(b.airTime));
    return result;
  }

  // 假裝讀取 2025novel.json + 2025comics.json，合併後回傳
  Future<List<BookRelease>> _loadBookData() async {
    final List<BookRelease> result = [];

    // 讀取小說
    final novelJson = await rootBundle.loadString('assets/data/text/novel/2025novel.json');
    final List novelList = json.decode(novelJson);
    for (var item in novelList) {
      final title = item['title'] ?? '???';
      final details = item['details'] as Map?;
      if (details == null) continue;
      final schedules = details['release_schedule'] as List?;
      if (schedules == null) continue;
      for (var sc in schedules) {
        final dateStr = sc['release_date'] ?? '';
        final date = DateTime.tryParse(dateStr);
        final detail = sc['chapter'] != null ? '第${sc['chapter']}章' : '';
        if (date != null) {
          result.add(BookRelease(
            title: title,
            releaseDate: date,
            detail: detail,
          ));
        }
      }
    }

    // 讀取漫畫
    final comicsJson = await rootBundle.loadString('assets/data/text/comics/2025comics.json');
    final List comicsList = json.decode(comicsJson);
    for (var item in comicsList) {
      final title = item['title'] ?? '???';
      final details = item['details'] as Map?;
      if (details == null) continue;
      final schedules = details['release_schedule'] as List?;
      if (schedules == null) continue;
      for (var sc in schedules) {
        final dateStr = sc['release_date'] ?? '';
        final date = DateTime.tryParse(dateStr);
        final detail = sc['volume'] != null ? '第${sc['volume']}卷' : '';
        if (date != null) {
          result.add(BookRelease(
            title: title,
            releaseDate: date,
            detail: detail,
          ));
        }
      }
    }

    // 按時間排序
    result.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // 資料可能尚未載入
    final animeTab = AnimeScheduleTab(episodes: _animeEpisodes);
    final bookTab = MonthlyBookTab(releases: _bookReleases);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: '本季動畫'),
                Tab(text: '本月書籍'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                animeTab,
                bookTab,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// 本季動畫：週數切換 + 每日排程
// =======================
class AnimeScheduleTab extends StatefulWidget {
  final List<AnimeEpisode> episodes;
  const AnimeScheduleTab({Key? key, required this.episodes}) : super(key: key);

  @override
  State<AnimeScheduleTab> createState() => _AnimeScheduleTabState();
}

class _AnimeScheduleTabState extends State<AnimeScheduleTab> {
  int weekOffset = 0;
  int selectedDayIndex = DateTime.now().weekday - 1; // 0-based (Mon=0, ... Sun=6)

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentMonday = now.subtract(Duration(days: now.weekday - 1));
    final targetMonday = currentMonday.add(Duration(days: 7 * weekOffset));
    final targetSunday = targetMonday.add(const Duration(days: 6));

    // 過濾：只顯示該週 (targetMonday ~ targetSunday) 的 episodes
    final weekEpisodes = widget.episodes.where((ep) {
      return ep.airTime.isAfter(_startOfDay(targetMonday).subtract(const Duration(seconds: 1))) &&
          ep.airTime.isBefore(_endOfDay(targetSunday).add(const Duration(seconds: 1)));
    }).toList();

    // 按天分組
    final grouped = _groupByDay(weekEpisodes, targetMonday);

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => setState(() => weekOffset--),
                icon: const Icon(Icons.chevron_left),
              ),
              Text('${_formatDate(targetMonday)} ~ ${_formatDate(targetSunday)}'),
              IconButton(
                onPressed: () => setState(() => weekOffset++),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final dayDate = targetMonday.add(Duration(days: index));
              final isSelected = selectedDayIndex == index;
              final label = ['一','二','三','四','五','六','日'][index];
              return GestureDetector(
                onTap: () => setState(() => selectedDayIndex = index),
                child: Column(
                  children: [
                    Text(label,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey[700],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${dayDate.month}/${dayDate.day}',
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.grey[700],
                      ),
                    ),
                    if (isSelected)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: _buildDaySchedule(grouped, selectedDayIndex, targetMonday),
        ),
      ],
    );
  }

  Widget _buildDaySchedule(Map<int, List<AnimeEpisode>> grouped, int dayIndex, DateTime baseMonday) {
    final list = grouped[dayIndex] ?? [];
    if (list.isEmpty) {
      return const Center(child: Text('今天沒有更新的作品'));
    }

    // 依照時間排序
    list.sort((a, b) => a.airTime.compareTo(b.airTime));

    // 依「上午 / 下午 / 晚上」分段
    final am = list.where((ep) => ep.airTime.hour < 12).toList();
    final pm = list.where((ep) => ep.airTime.hour >= 12 && ep.airTime.hour < 18).toList();
    final night = list.where((ep) => ep.airTime.hour >= 18).toList();

    return ListView(
      children: [
        if (am.isNotEmpty) _buildPart('上午', am),
        if (pm.isNotEmpty) _buildPart('下午', pm),
        if (night.isNotEmpty) _buildPart('晚上', night),
      ],
    );
  }

  Widget _buildPart(String label, List<AnimeEpisode> episodes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...episodes.map((ep) {
            final timeStr = DateFormat('HH:mm').format(ep.airTime);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                title: Text('${ep.animeTitle} 第${ep.episodeNumber}集'),
                subtitle: Text('$timeStr 播出'),
                onTap: () {
                  _showBottomSheet(ep);
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showBottomSheet(AnimeEpisode ep) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${ep.animeTitle} - 第${ep.episodeNumber}集',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('播出時間：${DateFormat('yyyy/MM/dd HH:mm').format(ep.airTime)}'),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx); // 關閉 Bottom Sheet
                    // 跳轉至詳細頁
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailPage(title: ep.animeTitle))
                    );
                  },
                  child: const Text('顯示更多'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  // 幫助計算當天 00:00:00
  DateTime _startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0, 0, 0);
  }

  // 幫助計算當天 23:59:59
  DateTime _endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  // 依「星期幾」分組
  Map<int, List<AnimeEpisode>> _groupByDay(List<AnimeEpisode> list, DateTime baseMonday) {
    final map = <int, List<AnimeEpisode>>{};
    for (var ep in list) {
      final diff = ep.airTime.difference(baseMonday).inDays;
      if (diff >= 0 && diff < 7) {
        map.putIfAbsent(diff, () => []);
        map[diff]!.add(ep);
      }
    }
    return map;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd').format(date);
  }
}

// =======================
// 本月書籍：月曆顯示
// =======================
class MonthlyBookTab extends StatefulWidget {
  final List<BookRelease> releases;
  const MonthlyBookTab({Key? key, required this.releases}) : super(key: key);

  @override
  State<MonthlyBookTab> createState() => _MonthlyBookTabState();
}

class _MonthlyBookTabState extends State<MonthlyBookTab> {
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1(Mon) ~ 7(Sun)
    final leadingEmptySlots = firstWeekday - 1;
    final totalCells = leadingEmptySlots + daysInMonth;
    final rowCount = (totalCells / 7).ceil();

    // 過濾該月的書籍
    final monthlyReleases = widget.releases.where((book) {
      return book.releaseDate.year == currentMonth.year &&
          book.releaseDate.month == currentMonth.month;
    }).toList();

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _prevMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('${currentMonth.year}年 ${currentMonth.month}月', style: const TextStyle(fontSize: 16)),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Container(
          color: Colors.grey[200],
          child: Row(
            children: const [
              _WeekdayHeader('一'),
              _WeekdayHeader('二'),
              _WeekdayHeader('三'),
              _WeekdayHeader('四'),
              _WeekdayHeader('五'),
              _WeekdayHeader('六'),
              _WeekdayHeader('日'),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: rowCount * 7,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              if (index < leadingEmptySlots || index >= totalCells) {
                return const SizedBox.shrink();
              }
              final day = index - leadingEmptySlots + 1;
              final date = DateTime(currentMonth.year, currentMonth.month, day);

              // 找出當天有出版的書
              final booksToday = monthlyReleases.where((b) =>
              b.releaseDate.year == date.year &&
                  b.releaseDate.month == date.month &&
                  b.releaseDate.day == date.day
              ).toList();

              return GestureDetector(
                onTap: booksToday.isNotEmpty ? () {
                  _showBottomSheet(context, date, booksToday);
                } : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: booksToday.isNotEmpty ? Colors.blue[50] : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4, left: 4,
                        child: Text('$day', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      if (booksToday.isNotEmpty)
                        Positioned(
                          bottom: 4, left: 4, right: 4,
                          child: Text(
                            '${booksToday.length}本',
                            style: const TextStyle(fontSize: 12, color: Colors.blue),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    });
  }

  void _showBottomSheet(BuildContext context, DateTime date, List<BookRelease> books) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: [
              Text(
                DateFormat('yyyy/MM/dd (E)', 'zh').format(date),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              for (var book in books)
                ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.detail),
                  onTap: () {
                    Navigator.pop(ctx);
                    // 跳詳細頁
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailPage(title: book.title))
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  final String text;
  const _WeekdayHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// =======================
// DetailPage (簡易示範)
// =======================
class DetailPage extends StatelessWidget {
  final String title;
  const DetailPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細資訊'),
      ),
      body: Center(
        child: Text(
          '這裡顯示更完整的作品資訊：\n$title',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// =======================
// 資料模型 (示範)
// =======================
class AnimeEpisode {
  final String animeTitle;
  final int episodeNumber;
  final DateTime airTime;

  AnimeEpisode({
    required this.animeTitle,
    required this.episodeNumber,
    required this.airTime,
  });
}

class BookRelease {
  final String title;
  final DateTime releaseDate;
  final String detail;

  BookRelease({
    required this.title,
    required this.releaseDate,
    required this.detail,
  });
}
