import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:acg_app/pages/about_page.dart';
import 'package:acg_app/pages/tag_management_page.dart';
import '../database/favorites_database.dart';
import '../database/work_database.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:url_launcher/url_launcher.dart';

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
    final String animeId = widget.work['anime_id'] as String;
    final db = WorkDatabase();
    
    // 使用 get() 而不是 getSingleOrNull() 來避免 "Too many elements" 錯誤
    final rows = await (db.select(db.anime)
          ..where((t) => t.id.equals(animeId)))
        .get();
    
    if (rows.isEmpty) {
      throw Exception("找不到對應的動畫資料 (animeId=$animeId)");
    }
    
    // 如果有多筆資料，取第一筆
    final row = rows.first;
    Map<String, dynamic> result = row.toJson();
    
    // 查詢季數資料
    final seasonsRows = await (db.select(db.seasons)
          ..where((t) => t.animeId.equals(animeId))
          ..orderBy([(t) => OrderingTerm(expression: t.seasonNumber)]))
        .get();
    
    if (seasonsRows.isNotEmpty) {
      List<Map<String, dynamic>> seasonsList = [];
      for (final seasonRow in seasonsRows) {
        Map<String, dynamic> seasonData = seasonRow.toJson();
        
        // 查詢該季的集數資料
        final episodesRows = await (db.select(db.episodes)
              ..where((t) => (t.animeId.equals(animeId)) & (t.seasonNumber.equals(seasonRow.seasonNumber)))
              ..orderBy([(t) => OrderingTerm(expression: t.episodeNumber)]))
            .get();
        
        if (episodesRows.isNotEmpty) {
          seasonData['episodes'] = episodesRows.map((e) => {
            'episode_number': e.episodeNumber,
            'air_time': _formatDateTime(e.airTime),
            'episode_label': e.episodeLabel,
          }).toList();
        }
        
        seasonsList.add(seasonData);
      }
      result['seasons'] = seasonsList;
    }
    
    return result;
  }

  // 格式化時間顯示
  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return '---';
    try {
      if (dateTime is DateTime) {
        return DateFormat('yyyy-MM-dd').format(dateTime);
      } else if (dateTime is String) {
        if (dateTime.isEmpty) return '---';
        final parsed = DateTime.tryParse(dateTime);
        if (parsed != null) {
          return DateFormat('yyyy-MM-dd').format(parsed);
        }
        return dateTime; // 如果解析失敗，返回原始字符串
      } else if (dateTime is int) {
        // 處理時間戳
        return DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(dateTime));
      }
      return dateTime.toString();
    } catch (e) {
      return dateTime?.toString() ?? '---';
    }
  }

  // 創建可點擊的超連結
  Widget _buildClickableLink(String url, String displayText) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // 處理純文本內容
  Widget _buildTextContent(String textContent) {
    // 檢查是否包含中文頓號分隔的多個項目
    if (textContent.contains('、')) {
      List<String> items = textContent.split('、');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            item.trim(),
            style: const TextStyle(fontSize: 16),
          ),
        )).toList(),
      );
    }
    
    // 單一項目直接顯示
    return Text(textContent, style: const TextStyle(fontSize: 16));
  }

  // 專門處理 URL 內容
  Widget _buildUrlContent(String? urlContent) {
    if (urlContent == null || urlContent.isEmpty) {
      return const Text('---', style: TextStyle(fontSize: 16));
    }
    
    // 檢查是否是 URL
    if (urlContent.startsWith('http')) {
      return _buildClickableLink(urlContent, urlContent);
    }
    
    // 如果不是 URL，當作普通文本顯示
    return Text(urlContent, style: const TextStyle(fontSize: 16));
  }

  // 格式化和顯示 JSON 字段
  Widget _buildJsonContent(String? jsonField) {
    if (jsonField == null || jsonField.isEmpty) {
      return const Text('---', style: TextStyle(fontSize: 16));
    }
    
    // 檢查是否是純文本格式（不包含花括號）
    if (!jsonField.contains('{') && !jsonField.contains('}')) {
      return _buildTextContent(jsonField);
    }
    
    try {
      dynamic decoded;
      
      // 檢查是否是用中文頓號「、」分隔的 JSON 物件
      if (jsonField.contains('}、{') && !jsonField.startsWith('[')) {
        // 修復格式：將中文頓號替換為逗號，並添加方括號
        String fixedJson = '[${jsonField.replaceAll('、', ', ')}]';
        decoded = json.decode(fixedJson);
      } 
      // 檢查是否是用逗號分隔的 JSON 物件
      else if (jsonField.contains('}, {') && !jsonField.startsWith('[')) {
        // 修復格式：添加方括號使其成為有效的 JSON 陣列
        String fixedJson = '[$jsonField]';
        decoded = json.decode(fixedJson);
      } 
      else {
        decoded = json.decode(jsonField);
      }
      if (decoded is List) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: decoded.map<Widget>((item) {
            if (item is Map) {
              final name = item['name'] ?? item['actor'] ?? item['type'] ?? '';
              final role = item['role'] ?? '';
              final link = item['link'] ?? '';
              
              if (link.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role.isNotEmpty ? '$name ($role)' : name,
                        style: const TextStyle(fontSize: 16),
                      ),
                      _buildClickableLink(link, link),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    role.isNotEmpty ? '$name ($role)' : name,
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(item.toString(), style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        );
      } else if (decoded is Map) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: decoded.entries.map<Widget>((entry) {
            final value = entry.value.toString();
            // 檢查是否是 URL
            if (value.startsWith('http')) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${entry.key}:', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    _buildClickableLink(value, value),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text('${entry.key}: $value', style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
        );
      } else {
        return Text(decoded.toString(), style: const TextStyle(fontSize: 16));
      }
    } catch (e) {
      // 如果 JSON 解析失敗，檢查是否是 URL
      if (jsonField.startsWith('http')) {
        return _buildClickableLink(jsonField, jsonField);
      }
      
      // 如果不是 URL，當作純文本處理
      return _buildTextContent(jsonField);
    }
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
      // 如果未收藏，不初始化用戶收藏標籤（用戶收藏標籤和作品自帶標籤是不同的）
      setState(() {
        _favoriteTags = {};
      });
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
        "release_date": _formatDateTime(widget.work["release_date"] ?? widget.work["announcementDate"]),
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
                            "release_date": _formatDateTime(widget.work["release_date"] ?? widget.work["announcementDate"]),
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
              Text("季數：${season['seasonNumber'] ?? season['season_number'] ?? '---'}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("宣告製作日期：${_formatDateTime(season['productionAnnouncementDate'] ?? season['production_announcement_date'])}"),
              Text("發布日期：${_formatDateTime(season['releaseDate'] ?? season['release_date'])}"),
              Text("總集數：${season['episodesCount'] ?? season['episodes_count'] ?? '---'}"),
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
              child: Text(
                '讀取動畫資料失敗：${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
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
                  tooltip: _isFavorite ? '取消收藏' : '收藏',
                  onPressed: _toggleFavorite,
                ),
                IconButton(
                  icon: const Icon(Icons.label),
                  tooltip: '標籤',
                  onPressed: _showTagDialog,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 封面圖
                  if ((animeDetail['coverImageRemote'] as String?)?.isNotEmpty ?? false)
                    Image.network(
                      animeDetail['coverImageRemote'],
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
                  if ((animeDetail['titleJp'] as String?)?.isNotEmpty ?? false)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        animeDetail['titleJp'],
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  _buildDivider(),
                  _buildSectionTitle('製作資訊'),
                  const SizedBox(height: 4),
                  _buildSectionContent('製作廠商：${animeDetail['studio'] ?? '---'}'),
                  _buildSectionContent('代理商：${animeDetail['publisher'] ?? '---'}'),
                  _buildSectionContent('宣布製作日期：${_formatDateTime(animeDetail['announcementDate'])}'),
                  _buildDivider(),
                  _buildSectionTitle('簡介'),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['synopsis'] ?? '---'),
                  _buildDivider(),
                  _buildSectionTitle('原作與季數資訊'),
                  const SizedBox(height: 4),
                  _buildSectionContent(animeDetail['original'] ?? '---'),
                  if (animeDetail['seasons'] != null)
                    _buildSeasonsInfo(animeDetail['seasons']),
                  _buildDivider(),
                  _buildSectionTitle('主要製作人員'),
                  const SizedBox(height: 4),
                  _buildJsonContent(animeDetail['mainStaff']),
                  _buildDivider(),
                  _buildSectionTitle('配音員'),
                  const SizedBox(height: 4),
                  _buildJsonContent(animeDetail['cast']),
                  _buildDivider(),
                  _buildSectionTitle('OP / ED'),
                  const SizedBox(height: 4),
                  _buildJsonContent(animeDetail['opEd']),
                  _buildDivider(),
                  _buildSectionTitle('可觀看平台'),
                  const SizedBox(height: 4),
                  _buildJsonContent(animeDetail['watchPlatforms']),
                  _buildDivider(),
                  _buildSectionTitle('官方網站'),
                  const SizedBox(height: 4),
                  _buildUrlContent(animeDetail['officialSite']),
                  const SizedBox(height: 16),
                  _buildSectionTitle('社群連結'),
                  const SizedBox(height: 4),
                  _buildUrlContent(animeDetail['socialLink']),
                  _buildDivider(),
                  if (_favoriteTags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: _favoriteTags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          onDeleted: () async {
                            setState(() {
                              _favoriteTags.remove(tag);
                            });
                            final updatedRecord = <String, dynamic>{
                              'id': animeDetail['id'] ?? '',
                              'title': animeDetail['title'] ?? '',
                              'type': mediaType,
                              'release_date': _formatDateTime(animeDetail['announcementDate']),
                              'fav_date': DateTime.now().toIso8601String(),
                              'tags': _favoriteTags.join(','),
                            };
                            await FavoritesDatabaseHelper.instance.insertFavorite(updatedRecord);
                            setState(() {});
                          },
                        );
                      }).toList(),
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
