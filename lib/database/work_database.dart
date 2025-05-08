import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'work_database.g.dart';

// Anime table: stores top-level anime info.
class Anime extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();
  TextColumn get titleJp => text().nullable()();
  TextColumn get coverImageLocal => text().nullable()();
  TextColumn get coverImageRemote => text().nullable()();
  TextColumn get studio => text().nullable()();
  TextColumn get publisher => text().nullable()();
  DateTimeColumn get announcementDate => dateTime().nullable()();
  TextColumn get grading => text().nullable()();
  TextColumn get synopsis => text().nullable()();
  TextColumn get mainStaff => text().nullable()(); // JSON string
  TextColumn get original => text().nullable()();
  TextColumn get cast => text().nullable()(); // JSON array
  TextColumn get opEd => text().nullable()(); // JSON array
  TextColumn get watchPlatforms => text().nullable()(); // JSON array
  TextColumn get officialSite => text().nullable()();
  TextColumn get socialLink => text().nullable()();
  TextColumn get version => text()();
  DateTimeColumn get lastUpdate => dateTime()();
  TextColumn get seasonalInfo => text().nullable()(); // JSON or comma-separated
  @override
  Set<Column> get primaryKey => {id};
}

// Season table: one season per anime.
class Seasons extends Table {
  TextColumn get animeId => text()();
  IntColumn get seasonNumber => integer()();
  DateTimeColumn get productionAnnouncementDate => dateTime().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  IntColumn get episodesCount => integer().nullable()();
  BoolColumn get releaseDateUnknown => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {animeId, seasonNumber};
}

// Episode table: episodes under a season.
class Episodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get animeId => text()();
  IntColumn get seasonNumber => integer()();
  IntColumn get episodeNumber => integer()();
  TextColumn get episodeLabel => text().nullable()();
  DateTimeColumn get airTime => dateTime().nullable()();
  BoolColumn get isTimeUnknown => boolean().withDefault(const Constant(false))();
}

// Comics table: top-level comics info.
class Comics extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();
  TextColumn get titleJp => text().nullable()();
  TextColumn get coverImageLocal => text().nullable()();
  TextColumn get coverImageRemote => text().nullable()();
  TextColumn get version => text()();
  DateTimeColumn get lastUpdate => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

// ComicsBook table: 每本漫畫的分冊。
class ComicsBooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get comicsId => text()();
  TextColumn get type => text().nullable()();
  TextColumn get publisher => text().nullable()();
  IntColumn get volumes => integer().nullable()();
  DateTimeColumn get releaseDateTw => dateTime().nullable()();
  DateTimeColumn get releaseDateJp => dateTime().nullable()();
  TextColumn get grading => text().nullable()();
  TextColumn get pricing => text().nullable()(); // JSON string
  TextColumn get synopsis => text().nullable()();
  TextColumn get coverImage => text().nullable()();
  TextColumn get purchasePhysical => text().nullable()(); // JSON string if needed
  TextColumn get purchaseEbook => text().nullable()();
  TextColumn get officialSite => text().nullable()();
  TextColumn get socialLink => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

// Novel table: top-level novel info.
class Novels extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();
  TextColumn get titleJp => text().nullable()();
  TextColumn get coverImageLocal => text().nullable()();
  TextColumn get coverImageRemote => text().nullable()();
  TextColumn get version => text()();
  DateTimeColumn get lastUpdate => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

// NovelBook table: 每本輕小說的分冊或單位。
class NovelBooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get novelId => text()();
  TextColumn get type => text().nullable()();
  TextColumn get author => text().nullable()();
  TextColumn get illustrator => text().nullable()();
  DateTimeColumn get publishDateTw => dateTime().nullable()();
  DateTimeColumn get publishDateJp => dateTime().nullable()();
  TextColumn get grading => text().nullable()();
  TextColumn get pricing => text().nullable()(); // JSON string
  TextColumn get synopsis => text().nullable()();
  TextColumn get coverImage => text().nullable()();
  TextColumn get publisher => text().nullable()();
  TextColumn get purchasePhysical => text().nullable()();
  TextColumn get purchaseEbook => text().nullable()();
  TextColumn get officialSite => text().nullable()();
  TextColumn get socialLink => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

// Works table: stores work info.
class Works extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().nullable()();
  TextColumn get titleJp => text().nullable()();
  TextColumn get categoryTags => text().nullable()(); // JSON array as string
  TextColumn get introduction => text().nullable()();
  TextColumn get news => text().nullable()();
  TextColumn get animeList => text().nullable()(); // JSON array string
  TextColumn get novelList => text().nullable()(); // JSON array string
  TextColumn get comicsList => text().nullable()(); // JSON array string
  TextColumn get othersList => text().nullable()(); // JSON array string
  TextColumn get version => text()();
  DateTimeColumn get lastUpdate => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Anime, Seasons, Episodes, Comics, ComicsBooks, Novels, NovelBooks, Works])
class WorkDatabase extends _$WorkDatabase {
  WorkDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Upsert methods for each table
  Future<void> upsertAnime(AnimeCompanion entry) async {
    await into(anime).insertOnConflictUpdate(entry);
  }
  Future<void> upsertSeason(SeasonsCompanion entry) async {
    await into(seasons).insertOnConflictUpdate(entry);
  }
  Future<void> upsertEpisode(EpisodesCompanion entry) async {
    await into(episodes).insertOnConflictUpdate(entry);
  }
  Future<void> upsertComic(ComicsCompanion entry) async {
    await into(comics).insertOnConflictUpdate(entry);
  }
  Future<void> upsertComicsBook(ComicsBooksCompanion entry) async {
    await into(comicsBooks).insertOnConflictUpdate(entry);
  }
  Future<void> upsertNovel(NovelsCompanion entry) async {
    await into(novels).insertOnConflictUpdate(entry);
  }
  Future<void> upsertNovelBook(NovelBooksCompanion entry) async {
    await into(novelBooks).insertOnConflictUpdate(entry);
  }
  Future<void> upsertWork(WorksCompanion entry) async {
    await into(works).insertOnConflictUpdate(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'work_database.sqlite'));
    return NativeDatabase(file);
  });
}
