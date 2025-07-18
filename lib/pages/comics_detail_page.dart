import 'dart:convert';
import 'package:flutter/material.dart';
import '../database/favorites_database.dart';
import '../database/work_database.dart';
import 'about_page.dart';
import 'tag_management_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final String comicsId = widget.work['comics_id'] as String;
    final db = WorkDatabase();
    
    // 使用 get() 而不是 getSingleOrNull() 來避免 "Too many elements" 錯誤
    final comicsRows = await (db.select(db.comics)
          ..where((t) => t.id.equals(comicsId)))
        .get();
    
    if (comicsRows.isEmpty) {
      throw Exception("找不到對應的漫畫資料 (comicsId=$comicsId)");
    }
    
    final comicsRow = comicsRows.first;
    
    // 獲取詳細資料從 ComicsBooks 表
    final bookRows = await (db.select(db.comicsBooks)
          ..where((t) => t.comicsId.equals(comicsId)))
        .get();
    
    // 合併資料
    Map<String, dynamic> result = comicsRow.toJson();
    
    if (bookRows.isNotEmpty) {
      final bookRow = bookRows.first;
      Map<String, dynamic> bookData = bookRow.toJson();
      result['details'] = {
        'publisher': bookData['publisher'],
        'volumes': bookData['volumes'],
        'release_date_tw': _formatDateTime(bookData['releaseDateTw']),
        'release_date_jp': _formatDateTime(bookData['releaseDateJp']),
        'synopsis': bookData['synopsis'],
        'purchase_physical': bookData['purchasePhysical'] != null && bookData['purchasePhysical'].toString().isNotEmpty
            ? _safeJsonDecode(bookData['purchasePhysical']) 
            : [],
        'purchase_ebook': bookData['purchaseEbook'] != null && bookData['purchaseEbook'].toString().isNotEmpty
            ? _safeJsonDecode(bookData['purchaseEbook']) 
            : [],
        'official_site': bookData['officialSite'],
        'social_link': bookData['socialLink'],
      };
      
      print('漫畫詳細資料: $result');
      print('台版出版日期: ${bookData['releaseDateTw']} -> ${_formatDateTime(bookData['releaseDateTw'])}');
      print('日版出版日期: ${bookData['releaseDateJp']} -> ${_formatDateTime(bookData['releaseDateJp'])}');
    }
    
    // 處理封面圖片
    if (result['coverImageRemote'] != null) {
      result['cover_image'] = {'remote': result['coverImageRemote']};
    }
    
    return result;
  }

  // 安全的 JSON 解析方法
  dynamic _safeJsonDecode(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      print('解析 JSON: $jsonString');
      final decoded = json.decode(jsonString);
      print('解析結果: $decoded');
      return decoded;
    } catch (e) {
      print('JSON 解析錯誤: $e, 原始字符串: $jsonString');
      return [];
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

  Widget _buildLinkList(String title, dynamic list) {
    if (list == null || (list is List && list.isEmpty)) {
      return const SizedBox.shrink();
    }
    
    // 確保是 List 類型
    List items = list is List ? list : [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        const SizedBox(height: 4),
        ...items.map<Widget>((item) {
          final name = item['platform_name'] ?? item['name'] ?? '';
          final link = item['link'] ?? '';
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name.isNotEmpty) Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (link.isNotEmpty) _buildClickableLink(link, link),
              ],
            ),
          );
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
                  _buildUrlContent(details['official_site']),
                  _buildSectionTitle("社群連結"),
                  _buildUrlContent(details['social_link']),
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
