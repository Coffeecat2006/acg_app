import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// 引用其他頁面
import 'pages/home_page.dart';
import 'pages/schedule_page.dart';
import 'pages/ranking_page.dart';
import 'pages/favorites_page.dart';
import 'pages/user_page.dart';
import 'pages/settings_page.dart';
import 'pages/detail_page.dart'; // 若搜尋要跳至 DetailPage，可在 SearchDelegate 用到

void main() {
  runApp(const MyApp());
}

/// 最上層 App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACG大全',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainScreen(),
    );
  }
}

/// 將原本 main_screen.dart 的功能搬進來
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List<Map<String, dynamic>> _works = [];
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _loadWorks();
  }

  /// 載入 works.json
  Future<void> _loadWorks() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/text/works/works.json');
      final data = json.decode(jsonString);
      final worksList = (data['works'] as List).map((e) => e as Map<String, dynamic>).toList();

      setState(() {
        _works = worksList;

        // 依序初始化 5 個頁面 (首頁、時間表、排行榜、收藏、使用者)
        // 首頁需要傳入 _works
        _pages
          ..clear()
          ..addAll([
            HomePage(works: _works),
            const SchedulePage(),
            const RankingPage(),
            const FavoritesPage(),
            const UserPage(),
          ]);
      });
    } catch (e) {
      debugPrint("Error loading works.json: $e");
    }
  }

  /// 點擊底部導覽列
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Text('ACG大全', style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('首頁'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('用戶'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 4);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: Row(
                children: [
                  const Text('問題與回報'),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                    child: const Text('新', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享應用'),
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('資料更新'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('設定'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('幫助'),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('切換暗色'),
            ),
            const Spacer(),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('使用者名稱', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('user@example.com'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 如果尚未載入完成 _works，就顯示一個 Loading
    if (_pages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('ACG大全')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('ACG大全'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch<String>(
                context: context,
                delegate: WorksSearchDelegate(_works),
              );
              // 如果需要對搜尋結果做進一步動作，可在這裡處理
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '時間表'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '排行榜'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '收藏'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '使用者'),
        ],
      ),
    );
  }
}

/// 搜尋委派
class WorksSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> allWorks;
  WorksSearchDelegate(this.allWorks);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filtered = allWorks.where((w) {
      final title = (w['title'] ?? '').toString();
      final titleJp = (w['title_jp'] ?? '').toString();
      return title.contains(query) || titleJp.contains(query);
    }).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('找不到相關作品'));
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return ListTile(
          title: Text(item['title'] ?? ''),
          subtitle: Text(item['title_jp'] ?? ''),
          onTap: () {
            // 點擊搜尋結果 → 跳到詳細頁
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(work: item)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allWorks.where((w) {
      final title = (w['title'] ?? '').toString();
      final titleJp = (w['title_jp'] ?? '').toString();
      return title.contains(query) || titleJp.contains(query);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item['title'] ?? ''),
          onTap: () {
            query = item['title'] ?? '';
            showResults(context);
          },
        );
      },
    );
  }
}
