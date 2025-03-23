import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../database/favorites_database.dart';
import 'about_page.dart';
import 'tag_management_page.dart';

class ComicsDetailPage extends StatefulWidget {
  final Map<String, dynamic> work;
  const ComicsDetailPage({Key? key, required this.work}) : super(key: key);

  @override
  State<ComicsDetailPage> createState() => _ComicsDetailPageState();
}

class _ComicsDetailPageState extends State<ComicsDetailPage> {
  late Future<Map<String, dynamic>> _detailFuture;
  bool _isFavorite = false;
  Set<String> _favoriteTags = {};
  final String mediaType = "comics";

  @override
  void initState() {
    super.initState();
    _detailFuture = _fetchComicsDetail();
    _initFavoriteStatus();
  }

  Future<Map<String, dynamic>> _fetchComicsDetail() async {
    final String comicsId = widget.work['comics_id'];
    final String year = comicsId.substring(0, 4);
    final jsonString = await rootBundle.loadString('assets/data/text/comics/${year}comics.json');
    final List data = json.decode(jsonString);
    final detail = data.firstWhere((element) => element['id'] == comicsId, orElse: () => {});
    if (detail is Map && detail.isEmpty) {
      throw Exception("找不到漫畫資料 (comicsId=$comicsId)");
    }
    return detail as Map<String, dynamic>;
  }

  Future<void> _initFavoriteStatus() async {
    final String comicsId = widget.work['comics_id'];
    bool fav = await FavoritesDatabaseHelper.instance.isFavorite(comicsId, mediaType);
    if (fav) {
      final List<Map<String, dynamic>> records = await FavoritesDatabaseHelper.instance.getAllFavorites();
      final record = records.firstWhere(
            (element) => element['fav_key'] == '${comicsId}_$mediaType',
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
    final String comicsId = widget.work['comics_id'];
    if (_isFavorite) {
      await FavoritesDatabaseHelper.instance.deleteFavorite(comicsId, mediaType);
      setState(() {
        _isFavorite = false;
        _favoriteTags.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("已取消收藏 ${widget.work['title']}"), duration: const Duration(milliseconds: 800)),
      );
    } else {
      Map<String, dynamic> record = {
        "id": comicsId,
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
                left: 16,
                right: 16,
                top: 16,
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
                        "id": widget.work['comics_id'],
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

  Widget _buildDivider() =>
      const Divider(color: Colors.grey, thickness: 1, height: 32);

  Widget _buildLinkList(String title, List list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 4),
        ...list.map<Widget>((item) {
          final name = item['platform_name'] ?? item['name'] ?? '';
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
          return Scaffold(
            appBar: AppBar(title: Text(widget.work['title'] ?? '漫畫詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.work['title'] ?? '漫畫詳細資訊')),
            body: Center(child: Text('讀取失敗：${snapshot.error}', style: const TextStyle(color: Colors.red))),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.work['title'] ?? '漫畫詳細資訊')),
            body: const Center(child: Text('沒有資料可顯示')),
          );
        } else {
          final comics = snapshot.data!;
          final details = comics['details'] ?? {};
          return Scaffold(
            appBar: AppBar(
              title: Text(comics['title'] ?? '漫畫詳細資訊'),
              actions: [
                IconButton(
                  icon: Icon(_isFavorite ? Icons.bookmark : Icons.bookmark_border),
                  onPressed: _toggleFavorite,
                ),
                IconButton(
                  icon: const Icon(Icons.label),
                  onPressed: _showTagDialog,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (comics['cover_image']?['remote'] != null)
                    Image.network(comics['cover_image']['remote'], height: 200, fit: BoxFit.cover)
                  else
                    Container(height: 200, color: Colors.grey[300], child: const Center(child: Text('無封面圖'))),
                  const SizedBox(height: 16),
                  _buildSectionTitle(comics['title'] ?? '---'),
                  if (comics['title_jp'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(comics['title_jp'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  _buildDivider(),
                  _buildSectionTitle("出版資訊"),
                  _buildSectionContent("出版社：${details['publisher'] ?? '---'}"),
                  _buildSectionContent("卷數：${details['volumes'] ?? '---'}"),
                  _buildSectionContent("台版出版：${details['release_date_tw'] ?? '---'}"),
                  _buildSectionContent("日版出版：${details['release_date_jp'] ?? '---'}"),
                  _buildDivider(),
                  _buildSectionTitle("簡介"),
                  _buildSectionContent(details['synopsis'] ?? '---'),
                  _buildDivider(),
                  if (details['purchase_physical'] != null)
                    _buildLinkList("實體購買", details['purchase_physical']),
                  if (details['purchase_ebook'] != null)
                    _buildLinkList("電子書購買", details['purchase_ebook']),
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
                            "id": widget.work['comics_id'],
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
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
