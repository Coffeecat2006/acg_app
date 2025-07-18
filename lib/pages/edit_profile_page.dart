import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  
  const EditProfilePage({super.key, this.initialData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  
  String? _avatarPath;
  Uint8List? _avatarBytes;
  bool _isLoading = false;
  bool _hasChanges = false;
  
  // 偏好設定
  String _favoriteAnimeGenre = '';
  String _favoriteNovelGenre = '';
  String _favoriteComicsGenre = '';
  
  final List<String> _animeGenres = [
    '動作', '冒險', '喜劇', '戲劇', '奇幻', '恐怖', '神秘', '浪漫', '科幻', '運動', '驚悚'
  ];
  
  final List<String> _novelGenres = [
    '奇幻', '科幻', '浪漫', '懸疑', '驚悚', '歷史', '都市', '武俠', '玄幻', '校園', '職場'
  ];
  
  final List<String> _comicsGenres = [
    '少年', '少女', '青年', '搞笑', '戀愛', '動作', '冒險', '奇幻', '科幻', '懸疑', '恐怖'
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      setState(() {
        _nameController.text = prefs.getString('user_name') ?? 'ACG Lover';
        _emailController.text = prefs.getString('user_email') ?? 'user@acg.com';
        _bioController.text = prefs.getString('user_bio') ?? '';
        _avatarPath = prefs.getString('user_avatar');
        _favoriteAnimeGenre = prefs.getString('favorite_anime_genre') ?? '';
        _favoriteNovelGenre = prefs.getString('favorite_novel_genre') ?? '';
        _favoriteComicsGenre = prefs.getString('favorite_comics_genre') ?? '';
      });
    } catch (e) {
      print('載入用戶資料失敗: $e');
    }
  }

  Future<void> _saveUserData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('user_name', _nameController.text.trim());
      await prefs.setString('user_email', _emailController.text.trim());
      await prefs.setString('user_bio', _bioController.text.trim());
      await prefs.setString('favorite_anime_genre', _favoriteAnimeGenre);
      await prefs.setString('favorite_novel_genre', _favoriteNovelGenre);
      await prefs.setString('favorite_comics_genre', _favoriteComicsGenre);
      
      if (_avatarPath != null) {
        await prefs.setString('user_avatar', _avatarPath!);
      }
      
      setState(() {
        _hasChanges = false;
      });
      
      if (mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.profileUpdated),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // 返回 true 表示有更新
      }
    } catch (e) {
      if (mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.saveFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final localizations = AppLocalizations.of(context)!;
    
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(localizations.selectFromGallery),
                onTap: () => _getImage(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(localizations.selectFromCamera),
                onTap: () => _getImage(ImageSource.camera),
              ),
              if (_avatarPath != null || _avatarBytes != null)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: Text(localizations.removePhoto),
                  onTap: () {
                    setState(() {
                      _avatarPath = null;
                      _avatarBytes = null;
                      _hasChanges = true;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    Navigator.pop(context);
    
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _avatarPath = pickedFile.path;
          _avatarBytes = null;
          _hasChanges = true;
        });
      }
    } catch (e) {
      if (mounted) {
        final localizations = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.imagePickerError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;
    
    final localizations = AppLocalizations.of(context)!;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.discardChanges),
        content: Text(localizations.discardMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(localizations.confirm),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return PopScope(
      canPop: !_hasChanges,
      onPopInvoked: (didPop) async {
        if (!didPop && _hasChanges) {
          final shouldPop = await _onWillPop();
          if (shouldPop && mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.editProfileTitle),
          actions: [
            if (_hasChanges)
              IconButton(
                icon: _isLoading 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
                onPressed: _isLoading ? null : _saveUserData,
              ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 頭像部分
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        localizations.profilePicture,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: colorScheme.surfaceVariant,
                              backgroundImage: _getAvatarImage(),
                              child: _getAvatarImage() == null
                                  ? Icon(
                                      Icons.person,
                                      size: 60,
                                      color: colorScheme.onSurfaceVariant,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: colorScheme.onPrimary,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: _pickImage,
                        child: Text(localizations.changePicture),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 個人資訊部分
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.personalInfo,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      // 顯示名稱
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: localizations.displayName,
                          prefixIcon: const Icon(Icons.person_outline),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.nameRequired;
                          }
                          if (value.trim().length > 20) {
                            return localizations.nameTooLong;
                          }
                          return null;
                        },
                        onChanged: (_) => _onFieldChanged(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 電子郵件
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: localizations.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return localizations.emailRequired;
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return localizations.emailInvalid;
                          }
                          return null;
                        },
                        onChanged: (_) => _onFieldChanged(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 個人簡介
                      TextFormField(
                        controller: _bioController,
                        decoration: InputDecoration(
                          labelText: localizations.bio,
                          hintText: localizations.bioHint,
                          prefixIcon: const Icon(Icons.info_outline),
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        maxLength: 200,
                        validator: (value) {
                          if (value != null && value.length > 200) {
                            return localizations.bioTooLong;
                          }
                          return null;
                        },
                        onChanged: (_) => _onFieldChanged(),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // 偏好設定部分
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.preferences,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      // 動畫類型偏好
                      DropdownButtonFormField<String>(
                        value: _favoriteAnimeGenre.isEmpty ? null : _favoriteAnimeGenre,
                        decoration: InputDecoration(
                          labelText: localizations.animeGenre,
                          prefixIcon: const Icon(Icons.movie_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        items: _animeGenres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _favoriteAnimeGenre = value ?? '';
                          });
                          _onFieldChanged();
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 小說類型偏好
                      DropdownButtonFormField<String>(
                        value: _favoriteNovelGenre.isEmpty ? null : _favoriteNovelGenre,
                        decoration: InputDecoration(
                          labelText: localizations.novelGenre,
                          prefixIcon: const Icon(Icons.book_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        items: _novelGenres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _favoriteNovelGenre = value ?? '';
                          });
                          _onFieldChanged();
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 漫畫類型偏好
                      DropdownButtonFormField<String>(
                        value: _favoriteComicsGenre.isEmpty ? null : _favoriteComicsGenre,
                        decoration: InputDecoration(
                          labelText: localizations.comicsGenre,
                          prefixIcon: const Icon(Icons.auto_stories_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        items: _comicsGenres.map((genre) {
                          return DropdownMenuItem(
                            value: genre,
                            child: Text(genre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _favoriteComicsGenre = value ?? '';
                          });
                          _onFieldChanged();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 儲存按鈕
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveUserData,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: Text(localizations.saveProfile),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              
              const SizedBox(height: 100), // 底部空間
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider? _getAvatarImage() {
    if (_avatarPath != null) {
      return FileImage(File(_avatarPath!));
    }
    if (_avatarBytes != null) {
      return MemoryImage(_avatarBytes!);
    }
    return null;
  }
} 