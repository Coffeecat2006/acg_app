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

  final Map<int, List<AnimeEpisode>> _animeDataByYear = {};
  final Map<int, List<BookRelease>> _bookDataByYear = {};

  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  bool showAnimeMark = false;
  int weekOffset = 0;
  int selectedDayIndex = DateTime.now().weekday - 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAnimeForCurrentRange();
    _loadBooksForYears();
  }

  Future<void> _loadAnimeForCurrentRange() async {
    final now = DateTime.now().add(Duration(days: 7 * weekOffset));
    final yearsToLoad = [now.year - 1, now.year, now.year + 1];
    for (var year in yearsToLoad) {
      if (_animeDataByYear.containsKey(year)) continue;
      try {
        final jsonString = await rootBundle.loadString('assets/data/text/animate/${year}animate.json');
        final List rawList = json.decode(jsonString);
        List<AnimeEpisode> result = [];
        for (var item in rawList) {
          final animeId = item['id'] ?? '';
          final title = item['title'] ?? '';
          final details = item['details'] ?? {};
          final seasonalList = item['seasonal_info'] as List? ?? [];
          final seasonalInfo = seasonalList.join('、');
          final seasons = details['seasons'] as List?;
          if (seasons == null) continue;
          for (var season in seasons) {
            if (season['release_date_unknown'] == true) continue;
            final episodes = season['episodes'] as List?;
            if (episodes == null) continue;
            for (var ep in episodes) {
              final epNum = ep['episode_number'] ?? 0;
              final epLabel = ep['episode_label'] ?? epNum.toString();
              final airTimeStr = ep['air_time'] ?? '';
              final airTime = DateTime.tryParse(airTimeStr);
              final isTimeUnknown = ep['isTimeUnknown'] ?? false;
              if (airTime != null || isTimeUnknown) {
                DateTime displayTime;
                if (isTimeUnknown && airTime != null) {
                  displayTime = DateTime(airTime.year, airTime.month, airTime.day);
                } else if (airTime != null) {
                  displayTime = airTime;
                } else {
                  continue;
                }
                result.add(AnimeEpisode(
                  animeId,
                  title,
                  epNum,
                  epLabel,
                  displayTime,
                  isTimeUnknown,
                  seasonalInfo,
                ));
              }
            }
          }
        }
        setState(() {
          _animeDataByYear[year] = result;
        });
      } catch (e) {
        // ignore
      }
    }
  }

  Future<void> _loadBooksForYears() async {
    final years = [currentMonth.year - 1, currentMonth.year, currentMonth.year + 1];
    for (var year in years) {
      if (_bookDataByYear.containsKey(year)) continue;
      try {
        final novelJson = await rootBundle.loadString('assets/data/text/novel/${year}novel.json');
        final comicsJson = await rootBundle.loadString('assets/data/text/comics/${year}comics.json');
        final List novelList = json.decode(novelJson);
        final List comicsList = json.decode(comicsJson);
        List<BookRelease> result = [];

        for (var item in novelList) {
          final novelId = item['id'];
          final title = item['title'] ?? '???';
          final details = item['details'];
          if (details == null) continue;
          final dateTw = DateTime.tryParse(details['publish_date_tw'] ?? '');
          if (dateTw != null) {
            result.add(BookRelease('novel', novelId, title, dateTw, '台版', 'TW'));
          }
          final dateJp = DateTime.tryParse(details['publish_date_jp'] ?? '');
          if (dateJp != null) {
            result.add(BookRelease('novel', novelId, title, dateJp, '日版', 'JP'));
          }
        }

        for (var item in comicsList) {
          final comicsId = item['id'];
          final title = item['title'] ?? '???';
          final details = item['details'];
          if (details == null) continue;
          final dateTw = DateTime.tryParse(details['release_date_tw'] ?? '');
          if (dateTw != null) {
            result.add(BookRelease('comics', comicsId, title, dateTw, '台版', 'TW'));
          }
          final dateJp = DateTime.tryParse(details['release_date_jp'] ?? '');
          if (dateJp != null) {
            result.add(BookRelease('comics', comicsId, title, dateJp, '日版', 'JP'));
          }
        }

        setState(() {
          _bookDataByYear[year] = result;
        });
      } catch (e) {
        // ignore
      }
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            tabs: const [
              Tab(text: '本季動畫'),
              Tab(text: '本月書籍'),
            ],
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
    final selectedDate = targetMonday.add(Duration(days: selectedDayIndex));

    final knownWeekEpisodes = _animeDataByYear.values
        .expand((list) => list)
        .where((ep) =>
    !ep.isTimeUnknown &&
        ep.airTime.isAfter(targetMonday.subtract(const Duration(seconds: 1))) &&
        ep.airTime.isBefore(targetSunday.add(const Duration(days: 1))))
        .toList();

    final knownDayEpisodes = knownWeekEpisodes
        .where((ep) => isSameDay(ep.airTime, selectedDate))
        .toList()
      ..sort((a, b) => a.airTime.compareTo(b.airTime));

    final am = knownDayEpisodes.where((ep) => ep.airTime.hour < 12).toList();
    final pm = knownDayEpisodes.where((ep) => ep.airTime.hour >= 12 && ep.airTime.hour < 18).toList();
    final night = knownDayEpisodes.where((ep) => ep.airTime.hour >= 18).toList();

    final unknownDayEpisodes = _animeDataByYear.values
        .expand((list) => list)
        .where((ep) => ep.isTimeUnknown && isSameDay(ep.airTime, selectedDate))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    weekOffset--;
                    selectedDayIndex = 0;
                    _loadAnimeForCurrentRange();
                  });
                },
              ),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: targetMonday,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      final baseMonday = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
                      final diffDays = picked.difference(baseMonday).inDays;
                      weekOffset = (diffDays ~/ 7);
                      selectedDayIndex = picked.weekday - 1;
                      _loadAnimeForCurrentRange();
                    });
                  }
                },
                child: Text(
                  '${DateFormat('MM/dd').format(targetMonday)} ~ ${DateFormat('MM/dd').format(targetSunday)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    weekOffset++;
                    selectedDayIndex = 0;
                    _loadAnimeForCurrentRange();
                  });
                },
              ),
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
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    ),
                ],
              ),
            );
          }),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              if (am.isNotEmpty) _buildAnimeSection('上午', am),
              if (pm.isNotEmpty) _buildAnimeSection('下午', pm),
              if (night.isNotEmpty) _buildAnimeSection('晚上', night),
              if (unknownDayEpisodes.isNotEmpty) _buildAnimeSectionWithoutTime('尚未公布', unknownDayEpisodes),
              if (am.isEmpty && pm.isEmpty && night.isEmpty && unknownDayEpisodes.isEmpty)
                const Center(child: Text('今天沒有更新')),
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
            final nowMid = DateTime.now();
            final epMid = DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day);
            final daysDiff = epMid.difference(DateTime(nowMid.year, nowMid.month, nowMid.day)).inDays;
            final diffText = daysDiff == 0
                ? '今天'
                : (daysDiff > 0 ? '距今 $daysDiff 天後' : '距今 ${-daysDiff} 天前');
            final timeStr = DateFormat('HH:mm').format(ep.airTime);
            return Card(
              child: ListTile(
                title: Text('${ep.title} 第${ep.label}集'),
                subtitle: Text('$timeStr 播出 | $diffText'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.3, // fix 1: shorter initial height
                        builder: (ctx, scrollController) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(16),
                            child: _buildAnimeDetailContent(ep, timeStr, diffText),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnimeSectionWithoutTime(String label, List<AnimeEpisode> episodes) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...episodes.map((ep) {
            final nowMid = DateTime.now();
            final epMid = DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day);
            final daysDiff = epMid.difference(DateTime(nowMid.year, nowMid.month, nowMid.day)).inDays;
            final diffText = daysDiff == 0
                ? '今天'
                : (daysDiff > 0 ? '距今 $daysDiff 天後' : '距今 ${-daysDiff} 天前');
            final dateStr = DateFormat('MM/dd').format(ep.airTime);
            return Card(
              child: ListTile(
                title: Text('${ep.title} 第${ep.label}集'),
                subtitle: Text('播出日期：$dateStr | $diffText | 時間待定'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.3,
                        builder: (ctx, scrollController) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            padding: const EdgeInsets.all(16),
                            child: _buildAnimeDetailContent(ep, '時間待定', diffText),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAnimeDetailContent(AnimeEpisode ep, String timeText, String diffText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${ep.title} - 第${ep.label}集', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (ep.seasonalInfo.isNotEmpty) Text('季度：${ep.seasonalInfo}'),
        const SizedBox(height: 8),
        Text('播出時間：$timeText'),
        Text(diffText),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => AnimeDetailPage(work: {
                  "title": ep.title,
                  "anime_id": ep.animeId
                }),
              ));
            },
            child: const Text('顯示更多'),
          ),
        ),
      ],
    );
  }

  Widget _buildBookMonthly() {
    final today = DateTime.now();
    final year = currentMonth.year;
    final month = currentMonth.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekday = DateTime(year, month, 1).weekday;
    final totalCells = firstWeekday - 1 + daysInMonth;

    final filteredBooks = _bookDataByYear[year]?.where((b) => b.date.month == month).toList() ?? [];
    final animeDates = showAnimeMark
        ? _animeDataByYear.values
        .expand((list) => list)
        .map((ep) => DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day))
        .toSet()
        : <DateTime>{};

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  currentMonth = DateTime(year, month - 1);
                  _loadBooksForYears();
                });
              },
            ),
            GestureDetector(
              onTap: () async {
                final newDate = await _showYearMonthPicker(context, currentMonth);
                if (newDate != null) {
                  setState(() {
                    currentMonth = newDate;
                    _loadBooksForYears();
                  });
                }
              },
              child: Text(
                '$year年 $month月',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                setState(() {
                  currentMonth = DateTime(year, month + 1);
                  _loadBooksForYears();
                });
              },
            ),
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
              final isToday = isSameDay(date, today);
              final booksToday = filteredBooks.where((b) => isSameDay(b.date, date)).toList();
              final hasAnime = animeDates.contains(date);

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.3,
                        builder: (ctx, scrollController) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            child: _buildDateDetailBottomSheet(date, booksToday, hasAnime),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: (hasAnime && showAnimeMark) ? Colors.pink[50] : null,
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 2, left: 2, child: Text('$dayNum')),
                      if (isToday)
                        const Positioned(
                          top: 2,
                          right: 2,
                          child: Icon(Icons.circle, size: 8, color: Colors.blue),
                        ),
                      ...booksToday.map((b) {
                        Color markColor;
                        if (b.type == 'novel' && b.version == 'TW') {
                          markColor = Colors.blue;
                        } else if (b.type == 'novel') {
                          markColor = Colors.green;
                        } else if (b.version == 'TW') {
                          markColor = Colors.orange;
                        } else {
                          markColor = Colors.purple;
                        }
                        return Positioned(
                          bottom: 1,
                          left: 1,
                          right: 1,
                          child: Container(height: 2, color: markColor),
                        );
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

  Widget _buildDateDetailBottomSheet(DateTime date, List<BookRelease> booksToday, bool hasAnime) {
    final today = DateTime.now();
    final nowMid = DateTime(today.year, today.month, today.day);
    final dateMid = DateTime(date.year, date.month, date.day);
    final diffDays = dateMid.difference(nowMid).inDays;
    final diffText = diffDays == 0 ? '今天' : (diffDays > 0 ? '距今 $diffDays 天後' : '距今 ${-diffDays} 天前');

    List<AnimeEpisode> animeToday = [];
    if (showAnimeMark) {
      animeToday = _animeDataByYear.values
          .expand((list) => list)
          .where((ep) => isSameDay(DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day), date))
          .toList()
        ..sort((a, b) => a.airTime.compareTo(b.airTime));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('yyyy/MM/dd').format(date), style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(diffText),
          const Divider(),
          if (booksToday.isNotEmpty) ...[
            const Text('◆ 書籍'),
            for (var b in booksToday)
              ListTile(
                title: Text(b.title),
                subtitle: Text('${b.detail} (${b.version})'),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Widget page = (b.type == 'novel')
                        ? NovelDetailPage(work: {"title": b.title, "novel_id": b.id})
                        : ComicsDetailPage(work: {"title": b.title, "comics_id": b.id});
                    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
                  },
                  child: const Text('詳細'),
                ),
              ),
          ],
          if (animeToday.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text('◆ 動畫'),
            // fix 2: show a detail button on the right, no second bottomSheet
            for (var ep in animeToday)
              ListTile(
                title: Text('${ep.title} 第${ep.label}集'),
                subtitle: _buildAnimeTodaySubtitle(ep),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => AnimeDetailPage(work: {
                        "title": ep.title,
                        "anime_id": ep.animeId
                      }),
                    ));
                  },
                  child: const Text('詳細'),
                ),
              ),
          ],
          if (booksToday.isEmpty && animeToday.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: Text('當天無出版資訊')),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimeTodaySubtitle(AnimeEpisode ep) {
    final nowMid = DateTime.now();
    final epMid = DateTime(ep.airTime.year, ep.airTime.month, ep.airTime.day);
    final daysDiff = epMid.difference(DateTime(nowMid.year, nowMid.month, nowMid.day)).inDays;
    final diffText = daysDiff == 0
        ? '今天'
        : (daysDiff > 0 ? '距今 $daysDiff 天後' : '距今 ${-daysDiff} 天前');
    if (ep.isTimeUnknown) {
      final dateStr = DateFormat('MM/dd').format(ep.airTime);
      return Text('播出日期：$dateStr | $diffText | 時間待定');
    } else {
      final timeStr = DateFormat('HH:mm').format(ep.airTime);
      return Text('播出時間：$timeStr | $diffText');
    }
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

  Future<DateTime?> _showYearMonthPicker(BuildContext context, DateTime initDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Year/Month',
    );
    if (picked == null) return null;
    return DateTime(picked.year, picked.month);
  }
}

class AnimeEpisode {
  final String animeId;
  final String title;
  final int episode;
  final String label;
  final DateTime airTime;
  final bool isTimeUnknown;
  final String seasonalInfo;
  AnimeEpisode(
      this.animeId,
      this.title,
      this.episode,
      this.label,
      this.airTime,
      this.isTimeUnknown,
      this.seasonalInfo,
      );
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
