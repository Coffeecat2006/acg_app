import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:acg_app/pages/about_page.dart';
import 'package:acg_app/pages/tag_management_page.dart';
import '../database/favorites_database.dart';

class AnimeDetailPage extends StatefulWidget {
  final Map<String, dynamic> work;
  const AnimeDetailPage({Key? key, required this.work}) : super(key: key);

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<Map<String, dynamic>> _detailFuture;
  bool _isFavorite = false;
  // Favorite tags stored as a Set to avoid duplicates.
  // Now tags can be added even if the work is not favorited.
  Set<String> _favoriteTags = {};
  final String mediaType = "anime";

  @override
  void initState() {
    super.initState();
    _detailFuture = _fetchAnimeDetail();
    _initFavoriteStatus();
  }

  Future<Map<String, dynamic>> _fetchAnimeDetail() async {
    final String animeId = widget.work['anime_id'];
    final String year = animeId.substring(0, 4);
    final String jsonString =
    await rootBundle.loadString('assets/data/text/animate/${year}animate.json');
    final List data = json.decode(jsonString);
    final detail = data.firstWhere((element) => element['id'] == animeId, orElse: () => {});
    if (detail is Map && detail.isEmpty) {
      throw Exception("找不到對應的動畫資料 (animeId=$animeId)");
    }
    return detail as Map<String, dynamic>;
  }

  Future<void> _initFavoriteStatus() async {
    final String animeId = widget.work['anime_id'];
    // Try to check favorite status; if no record exists, we also attempt to read tags from widget.work.
    bool fav = await FavoritesDatabaseHelper.instance.isFavorite(animeId, mediaType);
    if (fav) {
      final List<Map<String, dynamic>> records =
      await FavoritesDatabaseHelper.instance.getAllFavorites();
      final record = records.firstWhere(
              (element) => element['fav_key'] == '${animeId}_$mediaType',
          orElse: () => {});
      if (record.isNotEmpty && record['tags'] != null && record['tags'].toString().trim().isNotEmpty) {
        setState(() {
          _favoriteTags = record['tags'].toString().split(',').map((e) => e.trim()).toSet();
        });
      }
    } else {
      // If not favorited, try to load tags from the work data (if any)
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
    final String animeId = widget.work['anime_id'];
    if (_isFavorite) {
      await FavoritesDatabaseHelper.instance.deleteFavorite(animeId, mediaType);
      setState(() {
        _isFavorite = false;
        _favoriteTags.clear();
      });
      // Use a less intrusive notification method (e.g., a brief SnackBar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("已取消收藏 ${widget.work['title']}"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    } else {
      // Insert favorite record; if no tags yet, store an empty string.
      Map<String, dynamic> record = {
        "id": animeId,
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
        SnackBar(
          content: Text("已加入收藏 ${widget.work['title']}"),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
    // Refresh favorite status and tags
    _initFavoriteStatus();
  }

  Future<void> _showTagDialog() async {
    // Allow tag editing regardless of favorite status.
    // Get current tags from the work data or from the current _favoriteTags.
    List<String> currentTags = _favoriteTags.toList();

    // Retrieve available tags from the database.
    List<Map<String, dynamic>> tagRecords =
    await FavoritesDatabaseHelper.instance.getTags();
    List<String> availableTags = tagRecords.map((e) => e['tag'] as String).toList();

    // Use a temporary set to store selection.
    Set<String> tempSelectedTags = Set.from(_favoriteTags);

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
                    // Top row: buttons for tag help and management
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AboutPage()),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const TagManagementPage()),
                            );
                          },
                        ),
                        const Spacer(),
                        const Text("標籤設定", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Display available tags as FilterChips
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
                    // TextField for adding or searching tags
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
                          // Update the favorite record if it exists; otherwise, update work["tags"].
                          Map<String, dynamic> updatedRecord = {
                            "id": widget.work['anime_id'],
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
                          // Show a brief confirmation message (or you can choose to use a less intrusive method)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("已更新標籤"),
                              duration: const Duration(milliseconds: 800),
                            ),
                          );
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

  Widget _buildSectionTitle(String title) =>
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _buildSectionContent(String content) =>
      Text(content, style: const TextStyle(fontSize: 16));

  Widget _buildDivider() =>
      const Divider(color: Colors.grey, thickness: 1, height: 32);

  Widget _buildSeasonsInfo(List seasons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: seasons.map<Widget>((season) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("季數：${season['season_number']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("宣告製作日期：${season['production_announcement_date'] ?? '---'}"),
              Text("發布日期：${season['release_date'] ?? '---'}"),
              Text("總集數：${season['episodes_count'] ?? '---'}"),
              const SizedBox(height: 4),
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
        const SizedBox(height: 4),
        ...list.map<Widget>((item) {
          if (item is Map) {
            final name = item['name'] ?? '';
            final link = item['link'] ?? '';
            return Text("$name ($link)", style: const TextStyle(fontSize: 16));
          } else {
            return Text(item.toString(), style: const TextStyle(fontSize: 16));
          }
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
            appBar: AppBar(title: Text(widget.work['title'] ?? '動畫詳細資訊')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.work['title'] ?? '動畫詳細資訊')),
            body: Center(
              child: Text('讀取動畫資料失敗：${snapshot.error}', style: const TextStyle(color: Colors.red)),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.work['title'] ?? '動畫詳細資訊')),
            body: const Center(child: Text('沒有動畫資料可顯示')),
          );
        } else {
          final animeDetail = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(animeDetail['title'] ?? '動畫詳細資訊'),
              actions: [
                IconButton(
                  icon: Icon(_isFavorite ? Icons.bookmark : Icons.bookmark_border),
                  tooltip: _isFavorite ? "取消收藏" : "收藏",
                  onPressed: _toggleFavorite,
                ),
                IconButton(
                  icon: const Icon(Icons.label),
                  tooltip: "標籤",
                  onPressed: _showTagDialog,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display cover image
                  if (animeDetail['cover_image'] != null &&
                      animeDetail['cover_image']['remote'] != null)
                    Image.network(
                      animeDetail['cover_image']['remote'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(child: Text('無封面圖')),
                    ),
                  const SizedBox(height: 16),
                  _buildSectionTitle(animeDetail['title'] ?? '---'),
                  if (animeDetail['title_jp'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(animeDetail['title_jp'], style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  _buildDivider(),
                  _buildSectionTitle("製作資訊"),
                  const SizedBox(height: 4),
                  _buildSectionContent("製作廠商：${animeDetail['details']?['studio'] ?? '---'}"),
                  _buildSectionContent("代理商：${animeDetail['details']?['publisher'] ?? '---'}"),
                  _buildSectionContent("宣告製作日期：${animeDetail['details']?['announcement_date'] ?? '---'}"),
                  _buildDivider(),
                  _buildSectionTitle("簡介"),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['details']?['synopsis'] ?? '---'),
                  _buildDivider(),
                  _buildSectionTitle("原作與季數資訊"),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['details']?['original'] ?? '---'),
                  if (animeDetail['details']?['seasons'] != null)
                    _buildSeasonsInfo(animeDetail['details']['seasons']),
                  _buildDivider(),
                  if (animeDetail['details']?['main_staff'] != null)
                    _buildListSection("主要製作人員", animeDetail['details']['main_staff']),
                  _buildDivider(),
                  if (animeDetail['details']?['cast'] != null)
                    _buildListSection("配音員", animeDetail['details']['cast']),
                  _buildDivider(),
                  if (animeDetail['details']?['op_ed'] != null)
                    _buildListSection("OP / ED", animeDetail['details']['op_ed']),
                  _buildDivider(),
                  if (animeDetail['details']?['watch_platforms'] != null)
                    _buildListSection("可觀看平台", animeDetail['details']['watch_platforms']),
                  _buildDivider(),
                  _buildSectionTitle("官方網站"),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['details']?['official_site'] ?? '---'),
                  const SizedBox(height: 16),
                  _buildSectionTitle("社群連結"),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['details']?['social_link'] ?? '---'),
                  _buildDivider(),
                  // Display current favorite tags if any
                  if (_favoriteTags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: _favoriteTags
                          .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () async {
                          setState(() {
                            _favoriteTags.remove(tag);
                          });
                          Map<String, dynamic> updatedRecord = {
                            "id": widget.work['anime_id'],
                            "title": widget.work["title"] ?? "",
                            "type": mediaType,
                            "release_date": widget.work["release_date"] ?? "",
                            "fav_date": DateTime.now().toIso8601String(),
                            "tags": _favoriteTags.join(","),
                          };
                          await FavoritesDatabaseHelper.instance.insertFavorite(updatedRecord);
                          setState(() {});
                        },
                      ))
                          .toList(),
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
