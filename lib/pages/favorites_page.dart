import 'dart:convert';
import 'package:flutter/material.dart';
import '../database/favorites_database.dart';
import 'detail_page.dart';  // DetailPage 已經在 detail_page.dart 中定義

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await FavoritesDatabaseHelper.instance.getAllFavorites();
    setState(() {
      _favorites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的收藏"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFavorites,
          )
        ],
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text("沒有收藏資料"))
          : ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final fav = _favorites[index];
          // 根據收藏記錄建立 work 物件
          final work = {
            "id": fav["id"],
            "title": fav["title"],
            "has_anime": fav["type"] == "anime",
            "has_novel": fav["type"] == "novel",
            "has_comics": fav["type"] == "comics",
            // 使用收藏記錄的 id 當作各類型的唯一識別
            "anime_id": fav["type"] == "anime" ? fav["id"] : null,
            "novel_id": fav["type"] == "novel" ? fav["id"] : null,
            "comics_id": fav["type"] == "comics" ? fav["id"] : null,
          };
          return ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(fav["title"]),
            subtitle: Text(fav["type"]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(work: work),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
