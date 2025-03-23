import 'dart:convert';
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
  // For each media type, maintain a list (one bool per version) indicating whether that version is "favorited"
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

  // Initialize the favorite status for each version of each media type
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

  // Toggle favorite for a given media type and version index.
  // Instead of deleting the record on "unfavorite", we update is_favorite to 0 so that tag data is preserved.
  Future<void> _toggleFavorite(String type, int index) async {
    final dynamic mediaList = widget.work[type];
    if (mediaList is! List || index < 0 || index >= mediaList.length) return;
    final version = mediaList[index];
    final String? mediaId = version["id"] is String ? version["id"] : null;
    if (mediaId == null) return;

    bool currentStatus = await FavoritesDatabaseHelper.instance.isFavorite(mediaId, type);
    if (currentStatus) {
      // Update record to set is_favorite to 0
      await FavoritesDatabaseHelper.instance.updateFavoriteStatus(mediaId, type, 0);
      setState(() {
        _favoriteStatus[type]![index] = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("已取消收藏 ${widget.work['title']}"), duration: Duration(milliseconds: 800)),
      );
    } else {
      // Insert (or update) record with is_favorite set to 1.
      Map<String, dynamic> record = {
        "id": mediaId,
        "title": widget.work["title"] ?? "",
        "type": type,
        "release_date": widget.work["release_date"] ?? "",
        "fav_date": DateTime.now().toIso8601String(),
        "tags": widget.work["tags"] ?? "",
      };
      await FavoritesDatabaseHelper.instance.insertFavorite(record);
      setState(() {
        _favoriteStatus[type]![index] = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("已加入收藏 ${widget.work['title']}"), duration: Duration(milliseconds: 800)),
      );
    }
  }

  // Show tag dialog (allows adding and deleting tags) – available regardless of favorite status.
  void _showTagDialog(String type, int index) async {
    final dynamic mediaList = widget.work[type];
    if (mediaList is! List || index < 0 || index >= mediaList.length) return;
    final version = mediaList[index];
    final String? mediaId = version["id"] is String ? version["id"] : null;
    if (mediaId == null) return;

    // 先從資料庫中獲取該作品的最新標籤
    final allFavorites = await FavoritesDatabaseHelper.instance.getAllFavorites();
    final favKey = "${mediaId}_$type";
    final currentFav = allFavorites.firstWhere(
          (fav) => fav['fav_key'] == favKey,
      orElse: () => {},
    );

    // 若有標籤，則用資料庫的標籤，否則空的Set
    Set<String> tempSelectedTags = {};
    if (currentFav.isNotEmpty && currentFav["tags"] != null) {
      tempSelectedTags = currentFav["tags"].split(",").toSet();
    }

    // 從資料庫讀取所有可用標籤
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
                          icon: Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => TagManagementPage()));
                          },
                        ),
                        Spacer(),
                        Text("標籤設定", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16),
                    availableTags.isEmpty
                        ? Text("尚無可用標籤")
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
                    Divider(),
                    TextField(
                      controller: tagController,
                      decoration: InputDecoration(
                        labelText: "新增標籤 (或搜尋已有標籤)",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
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
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
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
                          setState(() {
                            widget.work["tags"] = tagStr;
                          });
                          Navigator.pop(ctx);
                        },
                        child: Text("儲存標籤"),
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


  // Build a section for a specific media type (all versions displayed as individual cards)
  Widget _buildMediaSection(BuildContext context, String mediaType, String typeKey) {
    final dynamic mediaList = widget.work[typeKey];
    if (mediaList is! List || mediaList.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$mediaType 版本", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
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
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(label, style: TextStyle(fontSize: 16)),
                    Spacer(),
                    IconButton(
                      icon: Icon(isFav ? Icons.star : Icons.star_border),
                      color: isFav ? Colors.yellow : Colors.grey,
                      onPressed: () => _toggleFavorite(typeKey, index),
                    ),
                    IconButton(
                      icon: Icon(Icons.label_outline),
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
                      child: Text("查看更多"),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  Widget _buildSectionContent(String content) => Text(content, style: TextStyle(fontSize: 16));
  Widget _buildDivider() => Divider(color: Colors.grey, thickness: 1, height: 32);

  Widget _buildSeasonsInfo(List seasons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: seasons.map<Widget>((season) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("季數：${season['season_number']}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("宣告製作日期：${season['production_announcement_date'] ?? '---'}"),
              Text("發布日期：${season['release_date'] ?? '---'}"),
              Text("總集數：${season['episodes_count'] ?? '---'}"),
              SizedBox(height: 4),
              if (season['episodes'] != null)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: List<Widget>.from((season['episodes'] as List).map((ep) {
                    final epNum = ep['episode_number'];
                    final airTime = ep['air_time'];
                    return Chip(
                      label: Text("Ep $epNum\n$airTime", textAlign: TextAlign.center),
                    );
                  })),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildListSection(String title, List list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SizedBox(height: 4),
        ...list.map<Widget>((item) {
          if (item is Map) {
            final name = item['name'] ?? '';
            final link = item['link'] ?? '';
            return Text("$name ($link)", style: TextStyle(fontSize: 16));
          } else {
            return Text(item.toString(), style: TextStyle(fontSize: 16));
          }
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.work['title'] ?? '未命名作品';
    final String titleJp = widget.work['title_jp'] ?? '';
    final String coverUrl = (widget.work['cover_image'] != null && widget.work['cover_image']['remote'] != null)
        ? widget.work['cover_image']['remote']
        : '';
    final String synopsis = widget.work['synopsis'] ?? '暫無簡介';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            coverUrl.isNotEmpty
                ? Image.network(coverUrl, height: 200, fit: BoxFit.cover)
                : Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text('無封面圖')),
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (titleJp.isNotEmpty)
              Text(titleJp, style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 16),
            Text(synopsis),
            SizedBox(height: 24),
            // Display media sections
            _buildMediaSection(context, "動畫", "anime"),
            _buildMediaSection(context, "輕小說", "novel"),
            _buildMediaSection(context, "漫畫", "comics"),
          ],
        ),
      ),
    );
  }
}
