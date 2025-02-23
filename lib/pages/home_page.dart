import 'package:flutter/material.dart';
import 'detail_page.dart';

enum Category { all, anime, comics, novel }

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> works;
  const HomePage({Key? key, required this.works}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category _selectedCategory = Category.all;

  @override
  Widget build(BuildContext context) {
    final filteredWorks = widget.works.where((item) {
      if (_selectedCategory == Category.all) return true;
      if (_selectedCategory == Category.anime && item['has_anime'] == true) return true;
      if (_selectedCategory == Category.comics && item['has_comics'] == true) return true;
      if (_selectedCategory == Category.novel && item['has_novel'] == true) return true;
      return false;
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                _buildCategoryButton('所有作品', Category.all),
                _buildCategoryButton('動畫', Category.anime),
                _buildCategoryButton('漫畫', Category.comics),
                _buildCategoryButton('小說', Category.novel),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildWorksGrid(filteredWorks),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, Category category) {
    final isSelected = _selectedCategory == category;
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: TextButton(
        onPressed: () {
          setState(() => _selectedCategory = category);
        },
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.grey[800],
          backgroundColor: isSelected ? Colors.blue : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildWorksGrid(List<Map<String, dynamic>> works) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.6,
      ),
      itemCount: works.length,
      itemBuilder: (context, index) {
        final item = works[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailPage(work: item)),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Center(child: Text('封面圖', style: TextStyle(color: Colors.black54))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(item['title_jp'] ?? ''),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
