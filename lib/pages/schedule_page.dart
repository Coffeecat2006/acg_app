import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              children: const [
                _AnimeScheduleTab(),
                _MonthlyBookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimeScheduleTab extends StatefulWidget {
  const _AnimeScheduleTab();

  @override
  State<_AnimeScheduleTab> createState() => __AnimeScheduleTabState();
}

class __AnimeScheduleTabState extends State<_AnimeScheduleTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('本季動畫排程示範'));
  }
}

class _MonthlyBookTab extends StatefulWidget {
  const _MonthlyBookTab();

  @override
  State<_MonthlyBookTab> createState() => _MonthlyBookTabState();
}

class _MonthlyBookTabState extends State<_MonthlyBookTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('本月書籍示範'));
  }
}
