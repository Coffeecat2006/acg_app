import 'package:flutter/material.dart';
import '../database/favorites_database.dart';
import 'anime_detail_page.dart';
import 'novel_detail_page.dart';
import 'comics_detail_page.dart';
import 'tag_management_page.dart';

enum FavoriteSortOption { titleAsc, titleDesc, releaseDateAsc, releaseDateDesc, favDateAsc, favDateDesc }

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favoritesCache = [];
  List<Map<String, dynamic>> _favorites = [];
  List<String> _availableTags = [];
  Set<String> _selectedFavKeys = {};
  bool _selectionMode = false;

  String _selectedType = 'all';
  String _searchQuery = '';
  String _selectedTagFilter = '全部';
  FavoriteSortOption _sortOption = FavoriteSortOption.titleAsc;
  int _currentPage = 1;
  static const int pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadTags();
  }

  Future<void> _loadFavorites() async {
    final data = await FavoritesDatabaseHelper.instance.getAllFavorites();
    final filtered = data.where((fav) => fav['is_favorite'] == 1).toList();
    setState(() {
      _favoritesCache = filtered;
      _currentPage = 1;
      _selectedFavKeys.clear();
      _selectionMode = false;
      _applyFilters();
    });
  }

  Future<void> _loadTags() async {
    final tagRecords = await FavoritesDatabaseHelper.instance.getTags();
    setState(() {
      _availableTags = tagRecords.map((e) => e['tag'].toString()).toList();
    });
  }

  void _applyFilters() {
    List<Map<String, dynamic>> list = List.from(_favoritesCache);

    if (_selectedType != 'all') {
      list = list.where((fav) => fav['type'] == _selectedType).toList();
    }

    if (_selectedTagFilter != '全部') {
      list = list.where((fav) {
        final tags = fav['tags']?.toString() ?? '';
        return tags.contains(_selectedTagFilter);
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list.where((fav) {
        final title = fav['title'].toString();
        final tags = fav['tags']?.toString() ?? '';
        return title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            tags.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    list.sort((a, b) {
      switch (_sortOption) {
        case FavoriteSortOption.titleAsc:
          return a['title'].toString().compareTo(b['title'].toString());
        case FavoriteSortOption.titleDesc:
          return b['title'].toString().compareTo(a['title'].toString());
        case FavoriteSortOption.releaseDateAsc:
          return (a['release_date'] ?? "").toString().compareTo((b['release_date'] ?? "").toString());
        case FavoriteSortOption.releaseDateDesc:
          return (b['release_date'] ?? "").toString().compareTo((a['release_date'] ?? "").toString());
        case FavoriteSortOption.favDateAsc:
          return (a['fav_date'] ?? "").toString().compareTo((b['fav_date'] ?? "").toString());
        case FavoriteSortOption.favDateDesc:
          return (b['fav_date'] ?? "").toString().compareTo((a['fav_date'] ?? "").toString());
      }
    });

    final pagedList = list.take(_currentPage * pageSize).toList();
    setState(() {
      _favorites = pagedList;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _currentPage = 1;
    });
    _applyFilters();
  }

  void _onTypeChanged(String type) {
    setState(() {
      _selectedType = type;
      _currentPage = 1;
    });
    _applyFilters();
  }

  void _onTagChanged(String tag) {
    setState(() {
      _selectedTagFilter = tag;
      _currentPage = 1;
    });
    _applyFilters();
  }

  void _onSortOptionChanged(FavoriteSortOption option) {
    setState(() {
      _sortOption = option;
      _currentPage = 1;
    });
    _applyFilters();
  }

  void _loadMore() {
    setState(() {
      _currentPage++;
    });
    _applyFilters();
  }

  void _toggleSelection(String favKey) {
    setState(() {
      if (_selectedFavKeys.contains(favKey)) {
        _selectedFavKeys.remove(favKey);
      } else {
        _selectedFavKeys.add(favKey);
      }
      _selectionMode = _selectedFavKeys.isNotEmpty;
    });
  }

  Future<void> _deleteSelected() async {
    for (String favKey in _selectedFavKeys) {
      final parts = favKey.split('_');
      if (parts.length == 2) {
        await FavoritesDatabaseHelper.instance.updateFavoriteStatus(parts[0], parts[1], 0);
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("已刪除 ${_selectedFavKeys.length} 筆收藏")),
    );
    _loadFavorites();
  }

  Future<void> _showBatchTagDialog() async {
    Set<String> tempSelectedTags = {};

    final tagRecords = await FavoritesDatabaseHelper.instance.getTags();
    List<String> availableTags = tagRecords.map((e) => e['tag'].toString()).toList();

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("批量設定標籤", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String tagStr = tempSelectedTags.join(",");
                        for (String favKey in _selectedFavKeys) {
                          final parts = favKey.split('_');
                          if (parts.length == 2) {
                            Map<String, dynamic> updateRecord = {
                              "id": parts[0],
                              "type": parts[1],
                              "title": "",
                              "release_date": "",
                              "fav_date": DateTime.now().toIso8601String(),
                              "tags": tagStr,
                            };
                            await FavoritesDatabaseHelper.instance.insertFavorite(updateRecord);
                          }
                        }
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("已套用標籤至 ${_selectedFavKeys.length} 筆收藏")),
                        );
                        _loadFavorites();
                      },
                      child: const Text("儲存標籤"),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectionMode
            ? Text("已選 ${_selectedFavKeys.length} 筆")
            : const Text("我的收藏"),
        actions: [
          if (_selectionMode) ...[
            IconButton(
              icon: const Icon(Icons.label),
              tooltip: "設定標籤",
              onPressed: _showBatchTagDialog,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: "刪除選中收藏",
              onPressed: _deleteSelected,
            ),
          ],
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: "標籤管理",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TagManagementPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '搜尋收藏 (中文或日文)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTypeButton('all', '全部'),
                _buildTypeButton('anime', '動畫'),
                _buildTypeButton('novel', '輕小說'),
                _buildTypeButton('comics', '漫畫'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                const Text("排序："),
                DropdownButton<FavoriteSortOption>(
                  value: _sortOption,
                  items: [
                    DropdownMenuItem(value: FavoriteSortOption.titleAsc, child: const Text("標題升序")),
                    DropdownMenuItem(value: FavoriteSortOption.titleDesc, child: const Text("標題降序")),
                    DropdownMenuItem(value: FavoriteSortOption.releaseDateAsc, child: const Text("推出時間升序")),
                    DropdownMenuItem(value: FavoriteSortOption.releaseDateDesc, child: const Text("推出時間降序")),
                    DropdownMenuItem(value: FavoriteSortOption.favDateAsc, child: const Text("收藏日期升序")),
                    DropdownMenuItem(value: FavoriteSortOption.favDateDesc, child: const Text("收藏日期降序")),
                  ],
                  onChanged: (value) {
                    if (value != null) _onSortOptionChanged(value);
                  },
                ),
                const SizedBox(width: 16),
                const Text("標籤："),
                DropdownButton<String>(
                  value: _selectedTagFilter,
                  items: [
                    const DropdownMenuItem(value: '全部', child: Text('全部')),
                    ..._availableTags.map((tag) => DropdownMenuItem(value: tag, child: Text(tag)))
                  ],
                  onChanged: (value) {
                    if (value != null) _onTagChanged(value);
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _favorites.isEmpty
                ? const Center(child: Text("沒有收藏資料"))
                : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final fav = _favorites[index];
                final favKey = fav['fav_key'];
                final type = fav["type"];
                final id = fav["id"];
                final work = {
                  "title": fav["title"],
                  "tags": fav["tags"],
                  "release_date": fav["release_date"],
                  if (type == "anime") "anime_id": id,
                  if (type == "novel") "novel_id": id,
                  if (type == "comics") "comics_id": id,
                };

                Widget detailPage;
                if (type == "anime") {
                  detailPage = AnimeDetailPage(work: work);
                } else if (type == "novel") {
                  detailPage = NovelDetailPage(work: work);
                } else if (type == "comics") {
                  detailPage = ComicsDetailPage(work: work);
                } else {
                  detailPage = const Scaffold(body: Center(child: Text("無法辨識的類型")));
                }

                final selected = _selectedFavKeys.contains(favKey);
                return ListTile(
                  leading: Icon(
                    selected ? Icons.check_circle : Icons.bookmark,
                    color: selected ? Colors.green : null,
                  ),
                  title: Text(fav["title"]),
                  subtitle: Text("類型：$type\n收藏日期：${fav["fav_date"]}"),
                  onLongPress: () => _toggleSelection(favKey),
                  onTap: () {
                    if (_selectionMode) {
                      _toggleSelection(favKey);
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => detailPage));
                    }
                  },
                );
              },
            ),
          ),
          if (_favoritesCache.length > _favorites.length)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _loadMore,
                child: const Text("載入更多"),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String type, String label) {
    final isSelected = _selectedType == type;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey,
        ),
        onPressed: () => _onTypeChanged(type),
        child: Text(label),
      ),
    );
  }
}
