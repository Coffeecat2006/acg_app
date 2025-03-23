import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'anime_detail_page.dart';
import 'novel_detail_page.dart';
import 'comics_detail_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<AnimeEpisode> _animeEpisodes = [];
  List<BookRelease> _bookReleases = [];
  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  bool showAnimeMark = false;
  int weekOffset = 0;
  int selectedDayIndex = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    _animeEpisodes = await _loadAnime();
    _bookReleases = await _loadBooks();
    setState(() {});
  }

  Future<List<AnimeEpisode>> _loadAnime() async {
    final jsonString = await rootBundle.loadString('assets/data/text/animate/2025animate.json');
    final List rawList = json.decode(jsonString);
    List<AnimeEpisode> result = [];
    for (var item in rawList) {
      final animeId = item['id'];
      final title = item['title'] ?? '';
      final details = item['details'];
      final seasons = details['seasons'] as List?;
      if (seasons == null) continue;
      for (var s in seasons) {
        final episodes = s['episodes'] as List?;
        if (episodes == null) continue;
        for (var ep in episodes) {
          final epNum = ep['episode_number'] ?? 0;
          final airTimeStr = ep['air_time'] ?? '';
          final airTime = DateTime.tryParse(airTimeStr);
          if (airTime != null) {
            result.add(AnimeEpisode(animeId, title, epNum, airTime));
          }
        }
      }
    }
    return result;
  }

  Future<List<BookRelease>> _loadBooks() async {
    List<BookRelease> result = [];
    final novelJson = await rootBundle.loadString('assets/data/text/novel/2025novel.json');
    final List novelList = json.decode(novelJson);
    for (var item in novelList) {
      final novelId = item['id'];
      final title = item['title'] ?? '???';
      final details = item['details'];
      if (details == null) continue;
      final dateTwStr = details['publish_date_tw'] ?? '';
      final dateTw = DateTime.tryParse(dateTwStr);
      if (dateTw != null) {
        result.add(BookRelease('novel', novelId, title, dateTw, '台版', 'TW'));
      }
      final dateJpStr = details['publish_date_jp'] ?? '';
      final dateJp = DateTime.tryParse(dateJpStr);
      if (dateJp != null) {
        result.add(BookRelease('novel', novelId, title, dateJp, '日版', 'JP'));
      }
    }
    final comicsJson = await rootBundle.loadString('assets/data/text/comics/2025comics.json');
    final List comicsList = json.decode(comicsJson);
    for (var item in comicsList) {
      final comicsId = item['id'];
      final title = item['title'] ?? '???';
      final details = item['details'];
      if (details == null) continue;
      final dateTwStr = details['release_date_tw'] ?? '';
      final dateTw = DateTime.tryParse(dateTwStr);
      if (dateTw != null) {
        result.add(BookRelease('comics', comicsId, title, dateTw, '台版', 'TW'));
      }
      final dateJpStr = details['release_date_jp'] ?? '';
      final dateJp = DateTime.tryParse(dateJpStr);
      if (dateJp != null) {
        result.add(BookRelease('comics', comicsId, title, dateJp, '日版', 'JP'));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            tabs: const [Tab(text: '本季動畫'), Tab(text: '本月書籍')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAnimeScheduleTab(),
                _buildBookMonthly(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimeScheduleTab() {
    final now = DateTime.now();
    final currentMonday = now.subtract(Duration(days: now.weekday - 1));
    final targetMonday = currentMonday.add(Duration(days: 7 * weekOffset));
    final targetSunday = targetMonday.add(const Duration(days: 6));
    final weekEpisodes = _animeEpisodes.where((ep) {
      return ep.airTime.isAfter(targetMonday.subtract(const Duration(seconds: 1))) &&
          ep.airTime.isBefore(targetSunday.add(const Duration(days: 1)));
    }).toList();

    final grouped = <int, List<AnimeEpisode>>{};
    for (var ep in weekEpisodes) {
      final diff = ep.airTime.difference(targetMonday).inDays;
      if (diff >= 0 && diff < 7) {
        grouped.putIfAbsent(diff, () => []).add(ep);
      }
    }

    final dailyList = grouped[selectedDayIndex] ?? [];
    dailyList.sort((a, b) => a.airTime.compareTo(b.airTime));

    // 分段
    final am = dailyList.where((ep) => ep.airTime.hour < 12).toList();
    final pm = dailyList.where((ep) => ep.airTime.hour >= 12 && ep.airTime.hour < 18).toList();
    final night = dailyList.where((ep) => ep.airTime.hour >= 18).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => setState(() => weekOffset--)),
              Text('${DateFormat('MM/dd').format(targetMonday)} ~ ${DateFormat('MM/dd').format(targetSunday)}'),
              IconButton(icon: const Icon(Icons.chevron_right), onPressed: () => setState(() => weekOffset++)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final dayDate = targetMonday.add(Duration(days: index));
            final isSelected = selectedDayIndex == index;
            final label = ['一','二','三','四','五','六','日'][index];
            return GestureDetector(
              onTap: () => setState(() => selectedDayIndex = index),
              child: Column(
                children: [
                  Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
                  Text('${dayDate.month}/${dayDate.day}', style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
                  if (isSelected)
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)),
                ],
              ),
            );
          }),
        ),
        const Divider(),
        Expanded(
          child: dailyList.isEmpty
              ? const Center(child: Text('今天沒有更新'))
              : ListView(
            children: [
              if (am.isNotEmpty) _buildAnimeSection('上午', am),
              if (pm.isNotEmpty) _buildAnimeSection('下午', pm),
              if (night.isNotEmpty) _buildAnimeSection('晚上', night),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimeSection(String label, List<AnimeEpisode> episodes) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...episodes.map((ep) {
            final timeStr = DateFormat('HH:mm').format(ep.airTime);
            final daysDiff = ep.airTime.difference(DateTime.now()).inDays;
            final diffText = daysDiff == 0 ? '今天' : (daysDiff > 0 ? '距今 $daysDiff 天後' : '距今 ${-daysDiff} 天前');
            return Card(
              child: ListTile(
                title: Text('${ep.title} 第${ep.episode}集'),
                subtitle: Text('$timeStr 播出 | $diffText'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => AnimeDetailPage(work: {"title": ep.title, "anime_id": ep.animeId}),
                  ));
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
  Widget _buildBookMonthly() {
    final today = DateTime.now();
    final year = currentMonth.year;
    final month = currentMonth.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday;
    final totalCells = firstWeekday - 1 + daysInMonth;

    final filteredBooks = _bookReleases.where((b) => b.date.year == year && b.date.month == month).toList();
    final animeDates = showAnimeMark
        ? _animeEpisodes.map((ep) => DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day)).toSet()
        : <DateTime>{};

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: const Icon(Icons.chevron_left),
                onPressed: () => setState(() => currentMonth = DateTime(year, month - 1))),
            Text('$year年 $month月'),
            IconButton(icon: const Icon(Icons.chevron_right),
                onPressed: () => setState(() => currentMonth = DateTime(year, month + 1))),
          ],
        ),
        SwitchListTile(
          title: const Text('顯示動畫標記'),
          value: showAnimeMark,
          onChanged: (val) => setState(() => showAnimeMark = val),
        ),
        Expanded(
          child: GridView.builder(
            itemCount: ((totalCells / 7).ceil()) * 7,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
            itemBuilder: (_, index) {
              final dayNum = index - (firstWeekday - 1) + 1;
              if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox.shrink();
              final date = DateTime(year, month, dayNum);
              final isToday = date.day == today.day && date.month == today.month && date.year == today.year;
              final booksToday = filteredBooks.where((b) =>
              b.date.year == date.year && b.date.month == date.month && b.date.day == date.day).toList();
              final hasAnime = animeDates.contains(date);

              return GestureDetector(
                onTap: () {
                  final diff = date.difference(DateTime(today.year, today.month, today.day)).inDays;
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Padding(
                      padding: const EdgeInsets.all(16),
                      child: booksToday.isEmpty
                          ? const Text('當天無出版資訊')
                          : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('yyyy/MM/dd').format(date),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(diff == 0 ? '今天' : (diff > 0 ? '距今 $diff 天後' : '距今 ${-diff} 天前')),
                          const Divider(),
                          for (var b in booksToday)
                            ListTile(
                              title: Text(b.title),
                              subtitle: Text('${b.detail} (${b.version})'),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Widget page = b.type == 'novel'
                                      ? NovelDetailPage(work: {"title": b.title, "novel_id": b.id})
                                      : ComicsDetailPage(work: {"title": b.title, "comics_id": b.id});
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
                                },
                                child: const Text('詳細'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: hasAnime && showAnimeMark ? Colors.pink[50] : null,
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 2, left: 2, child: Text('$dayNum')),
                      if (isToday)
                        const Positioned(top: 2, right: 2,
                            child: Icon(Icons.circle, size: 8, color: Colors.blue)),
                      ...booksToday.map((b) {
                        Color markColor;
                        if (b.type == 'novel' && b.version == 'TW') markColor = Colors.blue;
                        else if (b.type == 'novel') markColor = Colors.green;
                        else if (b.version == 'TW') markColor = Colors.orange;
                        else markColor = Colors.purple;
                        return Positioned(bottom: 1, left: 1, right: 1,
                            child: Container(height: 2, color: markColor));
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _legend(Colors.blue, '台版小說'),
              _legend(Colors.green, '日版小說'),
              _legend(Colors.orange, '台版漫畫'),
              _legend(Colors.purple, '日版漫畫'),
              _legend(Colors.pink, '動畫'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legend(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class AnimeEpisode {
  final String animeId;
  final String title;
  final int episode;
  final DateTime airTime;
  AnimeEpisode(this.animeId, this.title, this.episode, this.airTime);
}

class BookRelease {
  final String type;
  final String id;
  final String title;
  final DateTime date;
  final String detail;
  final String version;
  BookRelease(this.type, this.id, this.title, this.date, this.detail, this.version);
}
