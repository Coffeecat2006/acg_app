import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../database/favorites_database.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'feedback_page.dart';
import 'edit_profile_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  late AnimationController _profileAnimationController;
  late AnimationController _statsAnimationController;
  late Animation<double> _profileAnimation;
  late Animation<double> _statsAnimation;
  
  // 模擬統計數據
  int _totalFavorites = 0;
  int _animeWatched = 0;
  int _booksRead = 0;
  double _averageRating = 0.0;
  int _taggedWorks = 0;
  int _userLevel = 1;
  int _userExp = 0;
  String _userLevelName = 'Beginner';
  
  // 用戶個人資料
  String _userName = 'ACG Lover';
  String _userEmail = 'user@acg.com';
  String _userBio = '';
  String? _userAvatar;

  @override
  void initState() {
    super.initState();
    _profileAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _profileAnimation = CurvedAnimation(
      parent: _profileAnimationController,
      curve: Curves.easeOutCubic,
    );
    _statsAnimation = CurvedAnimation(
      parent: _statsAnimationController,
      curve: Curves.easeOutQuart,
    );
    
    _loadUserData();
    _startAnimations();
  }

  @override
  void dispose() {
    _profileAnimationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

  void _startAnimations() {
    _profileAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _statsAnimationController.forward();
    });
  }

  Future<void> _loadUserData() async {
    try {
      final favorites = await FavoritesDatabaseHelper.instance.getAllFavorites();
      // 計算已標籤作品數量
      int taggedWorksCount = 0;
      for (var fav in favorites) {
        if (fav['tags'] != null && fav['tags'].toString().isNotEmpty) {
          taggedWorksCount++;
        }
      }
      
      // 載入用戶個人資料
      final prefs = await SharedPreferences.getInstance();
      
      setState(() {
        _totalFavorites = favorites.length;
        // 模擬數據
        _animeWatched = (_totalFavorites * 0.6).round();
        _booksRead = (_totalFavorites * 0.4).round();
        _averageRating = 4.2;
        _taggedWorks = taggedWorksCount;
        _userExp = _totalFavorites * 10;
        _userLevel = (_userExp / 100).floor() + 1;
        _userLevelName = _getUserLevelName(_userLevel);
        
        // 用戶個人資料
        _userName = prefs.getString('user_name') ?? 'ACG Lover';
        _userEmail = prefs.getString('user_email') ?? 'user@acg.com';
        _userBio = prefs.getString('user_bio') ?? '';
        _userAvatar = prefs.getString('user_avatar');
      });
    } catch (e) {
      // 使用模擬數據
      setState(() {
        _totalFavorites = 15;
        _animeWatched = 9;
        _booksRead = 6;
        _averageRating = 4.2;
        _taggedWorks = 5;
        _userExp = 150;
        _userLevel = 2;
        _userLevelName = 'Intermediate';
        
        // 默認用戶資料
        _userName = 'ACG Lover';
        _userEmail = 'user@acg.com';
        _userBio = '';
        _userAvatar = null;
      });
    }
  }

  String _getUserLevelName(int level) {
    if (level <= 1) return 'Beginner';
    if (level <= 3) return 'Intermediate';
    if (level <= 5) return 'Advanced';
    if (level <= 8) return 'Expert';
    return 'Master';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 個人資料卡片
          AnimatedBuilder(
            animation: _profileAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _profileAnimation.value.clamp(0.0, 1.0),
                child: Opacity(
                  opacity: _profileAnimation.value.clamp(0.0, 1.0),
                  child: _buildProfileCard(localizations, colorScheme),
                ),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // 統計儀表板
          AnimatedBuilder(
            animation: _statsAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 50 * (1 - _statsAnimation.value.clamp(0.0, 1.0))),
                child: Opacity(
                  opacity: _statsAnimation.value.clamp(0.0, 1.0),
                  child: _buildStatsCard(localizations, colorScheme),
                ),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // 快速操作
          _buildQuickActions(localizations, colorScheme),
          
          const SizedBox(height: 24),
          
          // 功能模組
          _buildFunctionModules(localizations, colorScheme),
          
          const SizedBox(height: 100), // 底部空間
        ],
      ),
    );
  }

  Widget _buildProfileCard(AppLocalizations localizations, ColorScheme colorScheme) {
    return Card(
      elevation: 8,
      shadowColor: colorScheme.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface,
              colorScheme.surfaceVariant.withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          children: [
            // 頭像和基本信息
            Row(
              children: [
                Hero(
                  tag: 'user-avatar',
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primary,
                          colorScheme.secondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _userAvatar != null && File(_userAvatar!).existsSync() ? FileImage(File(_userAvatar!)) : null,
                      child: (_userAvatar == null || !File(_userAvatar!).existsSync()) ? Icon(
                        Icons.person,
                        size: 40,
                        color: colorScheme.onPrimary,
                      ) : null,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _userEmail,
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 用戶等級
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${localizations.level} $_userLevel - ${_getUserLevelDisplayName(localizations, _userLevelName)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 編輯按鈕
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfilePage(),
                    ),
                  );
                  
                  // 如果有更新，重新載入用戶數據
                  if (result == true) {
                    await _loadUserData();
                  }
                },
                icon: const Icon(Icons.edit_outlined),
                label: Text(localizations.editProfile),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(AppLocalizations localizations, ColorScheme colorScheme) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  localizations.userStats,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // 統計數據網格
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildStatItem(
                  localizations.totalFavorites,
                  _totalFavorites.toString(),
                  Icons.favorite,
                  colorScheme.error,
                ),
                _buildStatItem(
                  localizations.animeWatched,
                  _animeWatched.toString(),
                  Icons.play_circle_outline,
                  colorScheme.primary,
                ),
                _buildStatItem(
                  localizations.booksRead,
                  _booksRead.toString(),
                  Icons.book_outlined,
                  colorScheme.secondary,
                ),
                _buildStatItem(
                  localizations.taggedWorks,
                  _taggedWorks.toString(),
                  Icons.label,
                  colorScheme.tertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(AppLocalizations localizations, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.userQuickActions,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildQuickActionCard(
                localizations.recentFavorites,
                Icons.favorite_border,
                colorScheme.error,
                () => HapticFeedback.lightImpact(),
              ),
              _buildQuickActionCard(
                localizations.recentViewed,
                Icons.history,
                colorScheme.primary,
                () => HapticFeedback.lightImpact(),
              ),
              _buildQuickActionCard(
                localizations.watchlist,
                Icons.playlist_add,
                colorScheme.secondary,
                () => HapticFeedback.lightImpact(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionModules(AppLocalizations localizations, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.userSettings,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildFunctionTile(
                localizations.accountSettings,
                Icons.account_circle_outlined,
                () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
                colorScheme,
              ),
              _buildFunctionTile(
                localizations.dataBackup,
                Icons.backup_outlined,
                () => HapticFeedback.lightImpact(),
                colorScheme,
              ),
              _buildFunctionTile(
                localizations.helpCenter,
                Icons.help_outline,
                () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                  );
                },
                colorScheme,
              ),
              _buildFunctionTile(
                localizations.aboutApp,
                Icons.info_outline,
                () {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  );
                },
                colorScheme,
              ),
              _buildFunctionTile(
                localizations.signOut,
                Icons.logout,
                () => HapticFeedback.lightImpact(),
                colorScheme,
                isLast: true,
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFunctionTile(
    String title,
    IconData icon,
    VoidCallback onTap,
    ColorScheme colorScheme, {
    bool isLast = false,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? colorScheme.error : colorScheme.onSurface;
    
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: color),
          title: Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: colorScheme.onSurfaceVariant,
          ),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }

  String _getUserLevelDisplayName(AppLocalizations localizations, String levelName) {
    switch (levelName) {
      case 'Beginner':
        return localizations.beginner;
      case 'Intermediate':
        return localizations.intermediate;
      case 'Advanced':
        return localizations.advanced;
      case 'Expert':
        return localizations.expert;
      case 'Master':
        return localizations.master;
      default:
        return localizations.beginner;
    }
  }
}