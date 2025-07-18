import 'package:flutter/material.dart';
import 'anime_detail_page.dart';
import 'novel_detail_page.dart';
import 'comics_detail_page.dart';
import '../database/favorites_database.dart';
import 'about_page.dart';
import 'tag_management_page.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> work;
  const DetailPage({Key? key, required this.work}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, List<bool>> _favoriteStatus = {
    "anime": [],
    "novel": [],
    "comics": [],
  };

  @override
  void initState() {
    super.initState();
    _initAllFavoriteStatus();
  }

  Future<void> _initAllFavoriteStatus() async {
    for (String type in ["anime", "novel", "comics"]) {
      final dynamic mediaList = widget.work[type];
      if (mediaList is List && mediaList.isNotEmpty) {
        List<bool> statusList = [];
        for (var version in mediaList) {
          final String? mediaId = version["id"] is String ? version["id"] : null;
          if (mediaId == null) {
            statusList.add(false);
          } else {
            bool fav = await FavoritesDatabaseHelper.instance.isFavorite(mediaId, type);
            statusList.add(fav);
          }
        }
        setState(() {
          _favoriteStatus[type] = statusList;
        });
      } else {
        setState(() {
          _favoriteStatus[type] = [];
        });
      }
    }
  }

  Future<void> _toggleFavorite(String type, int index) async {
    final dynamic mediaList = widget.work[type];
    if (mediaList is! List || index < 0 || index >= mediaList.length) return;
    final version = mediaList[index];
    final String? mediaId = version["id"] is String ? version["id"] : null;
    if (mediaId == null) return;

    bool currentStatus = await FavoritesDatabaseHelper.instance.isFavorite(mediaId, type);
    if (currentStatus) {
      await FavoritesDatabaseHelper.instance.updateFavoriteStatus(mediaId, type, 0);
      setState(() {
        _favoriteStatus[type]![index] = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("已取消收藏 ${widget.work['title']}"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    } else {
      Map<String, dynamic> record = {
        "id": mediaId,
        "title": widget.work["title"] ?? "",
        "type": type,
        //"release_date": widget.work["release_date"] ?? "",
        "fav_date": DateTime.now().toIso8601String(),
        "tags": "", // 收藏標籤初始化為空字符串，不使用作品自帶的標籤
      };
      await FavoritesDatabaseHelper.instance.insertFavorite(record);
      setState(() {
        _favoriteStatus[type]![index] = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("已加入收藏 ${widget.work['title']}"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  void _showTagDialog(String type, int index) async {
    final dynamic mediaList = widget.work[type];
    if (mediaList is! List || index < 0 || index >= mediaList.length) return;
    final version = mediaList[index];
    final String? mediaId = version["id"] is String ? version["id"] : null;
    if (mediaId == null) return;

    final allFavorites = await FavoritesDatabaseHelper.instance.getAllFavorites();
    final favKey = "${mediaId}_$type";
    final currentFav = allFavorites.firstWhere(
          (fav) => fav['fav_key'] == favKey,
      orElse: () => {},
    );

    Set<String> tempSelectedTags = {};
    if (currentFav.isNotEmpty && currentFav["tags"] != null) {
      tempSelectedTags = currentFav["tags"].split(",").toSet();
    }

    List<Map<String, dynamic>> tagRecords = await FavoritesDatabaseHelper.instance.getTags();
    List<String> availableTags = tagRecords.map((e) => e['tag'] as String).toList();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        TextEditingController tagController = TextEditingController();
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Container(
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => TagManagementPage()));
                          },
                        ),
                        const Spacer(),
                        const Text("標籤設定", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    availableTags.isEmpty
                        ? const Text("尚無可用標籤")
                        : Wrap(
                      spacing: 8,
                      children: availableTags.map((tag) {
                        bool selected = tempSelectedTags.contains(tag);
                        return FilterChip(
                          label: Text(tag),
                          selected: selected,
                          onSelected: (bool value) {
                            setModalState(() {
                              if (value) {
                                tempSelectedTags.add(tag);
                              } else {
                                tempSelectedTags.remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const Divider(),
                    TextField(
                      controller: tagController,
                      decoration: InputDecoration(
                        labelText: "新增標籤 (或搜尋已有標籤)",
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
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          String tagStr = tempSelectedTags.join(",");
                          Map<String, dynamic> updatedRecord = {
                            "id": mediaId,
                            "title": widget.work["title"] ?? "",
                            "type": type,
                            "release_date": widget.work["release_date"] ?? "",
                            "fav_date": DateTime.now().toIso8601String(),
                            "tags": tagStr,
                          };
                          await FavoritesDatabaseHelper.instance.insertFavorite(updatedRecord);
                          // 不修改作品自帶的標籤，收藏標籤只存儲在收藏數據庫中
                          Navigator.pop(ctx);
                        },
                        child: const Text("儲存標籤"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMediaSection(BuildContext context, String mediaType, String typeKey) {
    final dynamic mediaList = widget.work[typeKey];
    if (mediaList is! List || mediaList.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$mediaType 版本", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Column(
          children: List.generate(mediaList.length, (index) {
            final version = mediaList[index];
            final String label = version["label"] ?? "";
            bool isFav = false;
            final List<bool> statusList = _favoriteStatus[typeKey] ?? [];
            if (index < statusList.length) {
              isFav = statusList[index];
            }
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(label, style: const TextStyle(fontSize: 16)),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        isFav ? Icons.star : Icons.star_border,
                        color: isFav ? Colors.yellow : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(typeKey, index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.label_outline),
                      onPressed: () => _showTagDialog(typeKey, index),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final String? mediaId = version["id"] is String ? version["id"] : null;
                        if (mediaId == null) return;
                        Map<String, dynamic> selectedWork = Map.from(widget.work);
                        selectedWork["${typeKey}_id"] = mediaId;
                        if (typeKey == "anime") {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AnimeDetailPage(work: selectedWork)));
                        } else if (typeKey == "novel") {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => NovelDetailPage(work: selectedWork)));
                        } else if (typeKey == "comics") {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ComicsDetailPage(work: selectedWork)));
                        }
                      },
                      child: const Text("查看更多"),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  Widget _buildSectionContent(String content) => Text(content, style: const TextStyle(fontSize: 16));
  Widget _buildDivider() => const Divider(color: Colors.grey, thickness: 1, height: 32);

  @override
  Widget build(BuildContext context) {
    final String title = widget.work['title'] ?? '未命名作品';
    final String titleJp = widget.work['title_jp'] ?? '';
    final String coverUrl = (widget.work['cover_image'] != null && widget.work['cover_image']['remote'] != null)
        ? widget.work['cover_image']['remote']
        : '';
    final String synopsis = widget.work['introduction'] ?? '暫無簡介';
    final List<dynamic> categoryTags = widget.work['tags'] ?? [];
    final String news = widget.work['news'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coverUrl.isNotEmpty
                ? Image.network(coverUrl, height: 200, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('無封面圖')),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (titleJp.isNotEmpty)
              Text(titleJp, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 16),
            Text(synopsis),
            const SizedBox(height: 16),
            if (categoryTags.isNotEmpty)
              Wrap(
                spacing: 8,
                children: categoryTags.map((tag) => Chip(label: Text(tag.toString()))).toList(),
              ),
            if (news.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("最新消息: $news", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 24),
            _buildMediaSection(context, "動畫", "anime"),
            _buildMediaSection(context, "輕小說", "novel"),
            _buildMediaSection(context, "漫畫", "comics"),
          ],
        ),
      ),
    );
  }
}
