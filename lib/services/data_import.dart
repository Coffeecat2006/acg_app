import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:archive/archive.dart';
import '../database/work_database.dart';
import 'package:drift/drift.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry_plus/dio_retry_plus.dart';

Future<void> importLatestDataDio(
    WorkDatabase db, {
      required void Function(int, int) onProgress,
    }) async {
  const url =
      'https://github.com/Coffeecat2006/acg_app_data/raw/refs/heads/main/latest_data.zip';

  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      logPrint: print,
      retries: 3,
      retryDelays: [Duration(seconds: 2)],
      toNoInternetPageNavigator: () async {
      },
    ),
  );

  final response = await dio.get<List<int>>(
    url,
    options: Options(responseType: ResponseType.bytes),
    onReceiveProgress: onProgress,
  );
  if (response.statusCode != 200) {
    throw Exception('下載失敗：HTTP ${response.statusCode}');
  }

  final bytes = response.data!;
  final batchData = await compute(_parseBytes, bytes);

  await db.transaction(() async {
    await db.batch((batch) {
      if (batchData.animeEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.anime, batchData.animeEntries);
      }
      if (batchData.seasonsEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.seasons, batchData.seasonsEntries);
      }
      if (batchData.episodeEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.episodes, batchData.episodeEntries);
      }
      if (batchData.novelEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.novels, batchData.novelEntries);
      }
      if (batchData.novelBookEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.novelBooks, batchData.novelBookEntries);
      }
      if (batchData.comicsEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.comics, batchData.comicsEntries);
      }
      if (batchData.comicsBookEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.comicsBooks, batchData.comicsBookEntries);
      }
      if (batchData.worksEntries.isNotEmpty) {
        batch.insertAllOnConflictUpdate(db.works, batchData.worksEntries);
      }
    });
  });
  return;
}

/// Isolate 用於解析 bytes 並組成 Companion 列表
BatchData _parseBytes(List<int> bytes) {
  final archive = ZipDecoder().decodeBytes(bytes);
  final animeEntries = <AnimeCompanion>[];
  final seasonsEntries = <SeasonsCompanion>[];
  final episodeEntries = <EpisodesCompanion>[];
  final novelEntries = <NovelsCompanion>[];
  final novelBookEntries = <NovelBooksCompanion>[];
  final comicsEntries = <ComicsCompanion>[];
  final comicsBookEntries = <ComicsBooksCompanion>[];
  final worksEntries = <WorksCompanion>[];

  for (final file in archive) {
    if (!file.isFile || !file.name.toLowerCase().endsWith('.json')) continue;
    final content = utf8.decode(file.content);
    final lowerName = file.name.toLowerCase();

    // 動畫
    if (lowerName.contains('animate')) {
      final jsonData = json.decode(content) as List;
      for (var animeJson in jsonData) {
        animeEntries.add(
          AnimeCompanion.insert(
            id: (animeJson['id'] as String?) ?? '',
            title: Value((animeJson['title'] as String?) ?? ''),
            titleJp: Value((animeJson['title_jp'] as String?) ?? ''),
            coverImageLocal:
            Value((animeJson['cover_image']?['local'] as String?) ?? ''),
            coverImageRemote:
            Value((animeJson['cover_image']?['remote'] as String?) ?? ''),
            studio: Value((animeJson['details']?['studio'] as String?) ?? ''),
            publisher:
            Value((animeJson['details']?['publisher'] as String?) ?? ''),
            announcementDate: Value(
              DateTime.tryParse(
                  animeJson['details']?['announcement_date'] as String? ??
                      '') ??
                  DateTime(1970),
            ),
            grading: Value((animeJson['details']?['grading'] as String?) ?? ''),
            synopsis:
            Value((animeJson['details']?['synopsis'] as String?) ?? ''),
            mainStaff: Value(((animeJson['details']?['main_staff'] as List?)
                ?.join('、')) ??
                ''),
            original:
            Value((animeJson['details']?['original'] as String?) ?? ''),
            cast: Value(((animeJson['details']?['cast'] as List?)
                ?.map((e) => json.encode(e))
                .toList()
                .join('、')) ??
                ''),
            opEd: Value(((animeJson['details']?['op_ed'] as List?)
                ?.map((e) => json.encode(e))
                .toList()
                .join('、')) ??
                ''),
            watchPlatforms: Value(((animeJson['details']?['watch_platforms']
            as List?)
                ?.map((e) => json.encode(e))
                .toList()
                .join('、')) ??
                ''),
            officialSite:
            Value((animeJson['details']?['official_site'] as String?) ??
                ''),
            socialLink:
            Value((animeJson['details']?['social_link'] as String?) ?? ''),
            version: (animeJson['version'] as String?) ?? '',
            lastUpdate: DateTime.tryParse(
                animeJson['last_update'] as String? ?? '') ??
                DateTime(1970),
            seasonalInfo:
            Value(((animeJson['seasonal_info'] as List?)?.join('、')) ??
                ''),
          ),
        );

        if (animeJson['details']?['seasons'] is List) {
          for (var season in animeJson['details']['seasons']) {
            final seasonNumber = (season['season_number'] as int?) ?? 0;
            final prodDate = DateTime.tryParse(
                season['production_announcement_date'] as String? ?? '') ??
                DateTime(1970);
            final releaseDate = DateTime.tryParse(
                season['release_date'] as String? ?? '') ??
                DateTime(1970);
            final episodesCount = (season['episodes_count'] as int?) ?? 0;
            final releaseUnknown =
                (season['release_date_unknown'] as bool?) ?? false;
            seasonsEntries.add(
              SeasonsCompanion.insert(
                animeId: (animeJson['id'] as String?) ?? '',
                seasonNumber: seasonNumber,
                productionAnnouncementDate: Value(prodDate),
                releaseDate: Value(releaseDate),
                episodesCount: Value(episodesCount),
                releaseDateUnknown: Value(releaseUnknown),
              ),
            );

            if (season['episodes'] is List) {
              for (var ep in season['episodes']) {
                final airTime = DateTime.tryParse(
                    ep['air_time'] as String? ?? '') ??
                    DateTime(1970);
                episodeEntries.add(
                  EpisodesCompanion.insert(
                    animeId: (animeJson['id'] as String?) ?? '',
                    seasonNumber: seasonNumber,
                    episodeNumber: (ep['episode_number'] as int?) ?? 0,
                    episodeLabel:
                    Value((ep['episode_label'] as String?) ?? ''),
                    airTime: Value(airTime),
                    isTimeUnknown:
                    Value((ep['isTimeUnknown'] as bool?) ?? false),
                  ),
                );
              }
            }
          }
        }
      }
    }

    // 輕小說
    else if (lowerName.contains('novel')) {
      final jsonData = json.decode(content) as List;
      for (var item in jsonData) {
        novelEntries.add(
          NovelsCompanion.insert(
            id: (item['id'] as String?) ?? '',
            title: Value((item['title'] as String?) ?? ''),
            titleJp: Value((item['title_jp'] as String?) ?? ''),
            coverImageLocal: Value(
                (item['cover_image']?['local'] as String?) ?? ''),
            coverImageRemote: Value(
                (item['cover_image']?['remote'] as String?) ?? ''),
            version: (item['version'] as String?) ?? '',
            lastUpdate: DateTime.tryParse(
                item['last_update'] as String? ?? '') ??
                DateTime(1970),
          ),
        );
        if (item['books'] is List) {
          for (var book in item['books']) {
            final publishDateTw = DateTime.tryParse(
                book['publish_date_tw'] as String? ?? '') ??
                DateTime(1970);
            final publishDateJp = DateTime.tryParse(
                book['publish_date_jp'] as String? ?? '') ??
                DateTime(1970);
            novelBookEntries.add(
              NovelBooksCompanion.insert(
                novelId: (item['id'] as String?) ?? '',
                type: Value((book['type'] as String?) ?? ''),
                author: Value((book['author'] as String?) ?? ''),
                illustrator:
                Value((book['illustrator'] as String?) ?? ''),
                publishDateTw: Value(publishDateTw),
                publishDateJp: Value(publishDateJp),
                grading: Value((book['grading'] as String?) ?? ''),
                pricing: Value(json.encode(book['pricing'] ?? [])),
                synopsis: Value((book['synopsis'] as String?) ?? ''),
                coverImage: Value((book['cover_image'] as String?) ?? ''),
                publisher: Value((book['publisher'] as String?) ?? ''),
                purchasePhysical: Value(book['purchase_physical'] != null
                    ? json.encode(book['purchase_physical'])
                    : ''),
                purchaseEbook: Value(book['purchase_ebook'] != null
                    ? json.encode(book['purchase_ebook'])
                    : ''),
                officialSite:
                Value((book['official_site'] as String?) ?? ''),
                socialLink:
                Value((book['social_link'] as String?) ?? ''),
              ),
            );
          }
        }
      }
    }

    // 漫畫
    else if (lowerName.contains('comics')) {
      final jsonData = json.decode(content) as List;
      for (var item in jsonData) {
        comicsEntries.add(
          ComicsCompanion.insert(
            id: (item['id'] as String?) ?? '',
            title: Value((item['title'] as String?) ?? ''),
            titleJp: Value((item['title_jp'] as String?) ?? ''),
            coverImageLocal:
            Value((item['cover_image']?['local'] as String?) ?? ''),
            coverImageRemote:
            Value((item['cover_image']?['remote'] as String?) ?? ''),
            version: (item['version'] as String?) ?? '',
            lastUpdate: DateTime.tryParse(
                item['last_update'] as String? ?? '') ??
                DateTime(1970),
          ),
        );
        if (item['books'] is List) {
          for (var book in item['books']) {
            final releaseDateTw = DateTime.tryParse(
                book['release_date_tw'] as String? ?? '') ??
                DateTime(1970);
            final releaseDateJp = DateTime.tryParse(
                book['release_date_jp'] as String? ?? '') ??
                DateTime(1970);
            comicsBookEntries.add(
              ComicsBooksCompanion.insert(
                comicsId: (item['id'] as String?) ?? '',
                type: Value((book['type'] as String?) ?? ''),
                publisher: Value((book['publisher'] as String?) ?? ''),
                volumes: Value((book['volumes'] as int?) ?? 0),
                releaseDateTw: Value(releaseDateTw),
                releaseDateJp: Value(releaseDateJp),
                grading: Value((book['grading'] as String?) ?? ''),
                pricing: Value(json.encode(book['pricing'] ?? [])),
                synopsis: Value((book['synopsis'] as String?) ?? ''),
                coverImage: Value((book['cover_image'] as String?) ?? ''),
                purchasePhysical: Value(book['purchase_physical'] != null
                    ? json.encode(book['purchase_physical'])
                    : ''),
                purchaseEbook: Value(book['purchase_ebook'] != null
                    ? json.encode(book['purchase_ebook'])
                    : ''),
                officialSite:
                Value((book['official_site'] as String?) ?? ''),
                socialLink:
                Value((book['social_link'] as String?) ?? ''),
              ),
            );
          }
        }
      }
    }

    // 其他作品
    else if (lowerName.contains('works')) {
      final jsonData = json.decode(content);
      final worksList = (jsonData is Map)
          ? (jsonData['works'] as List? ?? [])
          : (jsonData as List);
      for (var item in worksList) {
        worksEntries.add(
          WorksCompanion.insert(
            id: (item['id'] as String?) ?? '',
            title: Value((item['title'] as String?) ?? ''),
            titleJp: Value((item['title_jp'] as String?) ?? ''),
            categoryTags: Value(item['category_tags'] != null
                ? json.encode(item['category_tags'])
                : ''),
            introduction: Value((item['Introduction'] as String?) ?? ''),
            news: Value((item['news'] as String?) ?? ''),
            animeList: Value(item['anime'] != null
                ? json.encode(item['anime'])
                : ''),
            novelList: Value(item['novel'] != null
                ? json.encode(item['novel'])
                : ''),
            comicsList: Value(item['comics'] != null
                ? json.encode(item['comics'])
                : ''),
            othersList: Value(item['others'] != null
                ? json.encode(item['others'])
                : ''),
            version: (item['version'] as String?) ?? '',
            lastUpdate: DateTime.tryParse(
                item['last_update'] as String? ?? '') ??
                DateTime(1970),
          ),
        );
      }
    }
  }

  return BatchData(
    animeEntries: animeEntries,
    seasonsEntries: seasonsEntries,
    episodeEntries: episodeEntries,
    novelEntries: novelEntries,
    novelBookEntries: novelBookEntries,
    comicsEntries: comicsEntries,
    comicsBookEntries: comicsBookEntries,
    worksEntries: worksEntries,
  );
}

/// 用於封裝所有 Companion 列表，供 Batch 寫入
class BatchData {
  final List<AnimeCompanion> animeEntries;
  final List<SeasonsCompanion> seasonsEntries;
  final List<EpisodesCompanion> episodeEntries;
  final List<NovelsCompanion> novelEntries;
  final List<NovelBooksCompanion> novelBookEntries;
  final List<ComicsCompanion> comicsEntries;
  final List<ComicsBooksCompanion> comicsBookEntries;
  final List<WorksCompanion> worksEntries;

  BatchData({
    required this.animeEntries,
    required this.seasonsEntries,
    required this.episodeEntries,
    required this.novelEntries,
    required this.novelBookEntries,
    required this.comicsEntries,
    required this.comicsBookEntries,
    required this.worksEntries,
  });
}
