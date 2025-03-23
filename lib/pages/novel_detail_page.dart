import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../database/favorites_database.dart';
import 'about_page.dart';
import 'tag_management_page.dart';

class NovelDetailPage extends StatefulWidget {
  final Map<String, dynamic> work;
  const NovelDetailPage({Key? key, required this.work}) : super(key: key);

  @override
  State<NovelDetailPage> createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage> {
  late Future<Map<String, dynamic>> _detailFuture;
  bool _isFavorite = false;
  Set<String> _favoriteTags = {};
  final String mediaType = "novel";

  @override
  void initState() {
    super.initState();
    _detailFuture = _fetchNovelDetail();
    _initFavoriteStatus();
  }

  Future<Map<String, dynamic>> _fetchNovelDetail() async {
    final String novelId = widget.work['novel_id'];
    final String year = novelId.substring(0, 4);
    final jsonString = await rootBundle.loadString('assets/data/text/novel/${year}novel.json');
    final List data = json.decode(jsonString);
    final detail = data.firstWhere((element) => element['id'] == novelId, orElse: () => {});
    if (detail.isEmpty) {
      throw Exception("找不到對應的小說資料 (novelId=$novelId)");
    }
    return detail as Map<String, dynamic>;
  }

  Future<void> _initFavoriteStatus() async {
    final String novelId = widget.work['novel_id'];
    bool fav = await FavoritesDatabaseHelper.instance.isFavorite(novelId, mediaType);
    if (fav) {
      final List<Map<String, dynamic>> records = await FavoritesDatabaseHelper.instance.getAllFavorites();
      final record = records.firstWhere(
            (element) => element['fav_key'] == '${novelId}_$mediaType',
        orElse: () => {},
      );
      if (record.isNotEmpty && record['tags'] != null && record['tags'].toString().trim().isNotEmpty) {
        setState(() {
          _favoriteTags = record['tags'].toString().split(',').map((e) => e.trim()).toSet();
        });
      }
    } else {
      final String tagString = widget.work["tags"] ?? "";
      if (tagString.trim().isNotEmpty) {
        setState(() {
          _favoriteTags = tagString.split(',').map((t) => t.trim()).toSet();
        });
      }
    }
    setState(() {
      _isFavorite = fav;
    });
  }

  Future<void> _toggleFavorite() async {
    final String novelId = widget.work['novel_id'];
    if (_isFavorite) {
      await FavoritesDatabaseHelper.instance.deleteFavorite(novelId, mediaType);
      setState(() {
        _isFavorite = false;
        _favoriteTags.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("已取消收藏 ${widget.work['title']}"), duration: const Duration(milliseconds: 800)),
      );
    } else {
      Map<String, dynamic> record = {
        "id": novelId,
        "title": widget.work["title"] ?? "",
        "type": mediaType,
        "release_date": widget.work["release_date"] ?? "",
        "fav_date": DateTime.now().toIso8601String(),
        "tags": _favoriteTags.join(","),
      };
      await FavoritesDatabaseHelper.instance.insertFavorite(record);
      setState(() {
        _isFavorite = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("已加入收藏 ${widget.work['title']}"), duration: const Duration(milliseconds: 800)),
      );
    }
    _initFavoriteStatus();
  }
  Future<void> _showTagDialog() async {
    List<Map<String, dynamic>> tagRecords = await FavoritesDatabaseHelper.instance.getTags();
    List<String> availableTags = tagRecords.map((e) => e['tag'] as String).toList();
    Set<String> tempSelectedTags = Set.from(_favoriteTags);
    TextEditingController tagController = TextEditingController();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 16, right: 16, top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TagManagementPage()));
                        },
                      ),
                      const Spacer(),
                      const Text("標籤設定", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: availableTags.map((tag) {
                      bool selected = tempSelectedTags.contains(tag);
                      return FilterChip(
                        label: Text(tag),
                        selected: selected,
                        onSelected: (val) {
                          setModalState(() {
                            val ? tempSelectedTags.add(tag) : tempSelectedTags.remove(tag);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const Divider(),
                  TextField(
                    controller: tagController,
                    decoration: InputDecoration(
                      labelText: "新增標籤",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          String newTag = tagController.text.trim();
                          if (newTag.isNotEmpty && !availableTags.contains(newTag)) {
                            await FavoritesDatabaseHelper.instance.insertTag(newTag);
                            setModalState(() {
                              availableTags.add(newTag);
                              tempSelectedTags.add(newTag);
                            });
                            tagController.clear();
                          }
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      String tagStr = tempSelectedTags.join(",");
                      Map<String, dynamic> updatedRecord = {
                        "id": widget.work['novel_id'],
                        "title": widget.work["title"] ?? "",
                        "type": mediaType,
                        "release_date": widget.work["release_date"] ?? "",
                        "fav_date": DateTime.now().toIso8601String(),
                        "tags": tagStr,
                      };
                      await FavoritesDatabaseHelper.instance.insertFavorite(updatedRecord);
                      setState(() {
                        _favoriteTags = tempSelectedTags;
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("已更新標籤"), duration: Duration(milliseconds: 800)),
                      );
                    },
                    child: const Text("儲存標籤"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) =>
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _buildSectionContent(String content) =>
      Text(content, style: const TextStyle(fontSize: 16));

  Widget _buildDivider() => const Divider(color: Colors.grey, thickness: 1, height: 32);

  Widget _buildPurchaseLinks(String title, List list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 4),
        ...list.map<Widget>((item) {
          final name = item['platform_name'] ?? '';
          final link = item['link'] ?? '';
          return Text("$name ($link)", style: const TextStyle(fontSize: 16));
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _detailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(appBar: AppBar(title: Text(widget.work['title'] ?? '輕小說詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(appBar: AppBar(title: Text(widget.work['title'] ?? '輕小說詳細資訊')),
            body: Center(child: Text('讀取失敗：${snapshot.error}', style: const TextStyle(color: Colors.red))),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(appBar: AppBar(title: Text(widget.work['title'] ?? '輕小說詳細資訊')),
            body: const Center(child: Text('沒有資料可顯示')),
          );
        } else {
          final novel = snapshot.data!;
          final details = novel['details'] ?? {};
          return Scaffold(
            appBar: AppBar(
              title: Text(novel['title'] ?? '輕小說詳細資訊'),
              actions: [
                IconButton(icon: Icon(_isFavorite ? Icons.bookmark : Icons.bookmark_border), onPressed: _toggleFavorite),
                IconButton(icon: const Icon(Icons.label), onPressed: _showTagDialog),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                if (novel['cover_image']?['remote'] != null)
                  Image.network(novel['cover_image']['remote'], height: 200, fit: BoxFit.cover)
                else
                  Container(height: 200, color: Colors.grey[300], child: const Center(child: Text('無封面圖'))),
                const SizedBox(height: 16),
                _buildSectionTitle(novel['title'] ?? '---'),
                if (novel['title_jp'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(novel['title_jp'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                _buildDivider(),
                _buildSectionTitle("出版資訊"),
                _buildSectionContent("作者：${details['author'] ?? '---'} / 插畫：${details['illustrator'] ?? '---'}"),
                _buildSectionContent("台版出版：${details['publish_date_tw'] ?? '---'}"),
                _buildSectionContent("日版出版：${details['publish_date_jp'] ?? '---'}"),
                _buildDivider(),
                _buildSectionTitle("簡介"),
                _buildSectionContent(details['synopsis'] ?? '---'),
                _buildDivider(),
                if (details['purchase_physical'] != null)
                  _buildPurchaseLinks("實體購買", details['purchase_physical']),
                if (details['purchase_ebook'] != null)
                  _buildPurchaseLinks("電子書購買", details['purchase_ebook']),
                _buildDivider(),
                _buildSectionTitle("官方網站"),
                _buildSectionContent(details['official_site'] ?? '---'),
                _buildSectionTitle("社群連結"),
                _buildSectionContent(details['social_link'] ?? '---'),
                _buildDivider(),
                if (_favoriteTags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: _favoriteTags.map((tag) => Chip(
                      label: Text(tag),
                      onDeleted: () async {
                        setState(() {
                          _favoriteTags.remove(tag);
                        });
                        Map<String, dynamic> updatedRecord = {
                          "id": widget.work['novel_id'],
                          "title": widget.work["title"] ?? "",
                          "type": mediaType,
                          "release_date": widget.work["release_date"] ?? "",
                          "fav_date": DateTime.now().toIso8601String(),
                          "tags": _favoriteTags.join(","),
                        };
                        await FavoritesDatabaseHelper.instance.insertFavorite(updatedRecord);
                      },
                    )).toList(),
                  ),
              ]),
            ),
          );
        }
      },
    );
  }
}
