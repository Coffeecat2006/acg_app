// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_database.dart';

// ignore_for_file: type=lint
class $AnimeTable extends Anime with TableInfo<$AnimeTable, AnimeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleJpMeta = const VerificationMeta(
    'titleJp',
  );
  @override
  late final GeneratedColumn<String> titleJp = GeneratedColumn<String>(
    'title_jp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageLocalMeta = const VerificationMeta(
    'coverImageLocal',
  );
  @override
  late final GeneratedColumn<String> coverImageLocal = GeneratedColumn<String>(
    'cover_image_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageRemoteMeta = const VerificationMeta(
    'coverImageRemote',
  );
  @override
  late final GeneratedColumn<String> coverImageRemote = GeneratedColumn<String>(
    'cover_image_remote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _studioMeta = const VerificationMeta('studio');
  @override
  late final GeneratedColumn<String> studio = GeneratedColumn<String>(
    'studio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _announcementDateMeta = const VerificationMeta(
    'announcementDate',
  );
  @override
  late final GeneratedColumn<DateTime> announcementDate =
      GeneratedColumn<DateTime>(
        'announcement_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _gradingMeta = const VerificationMeta(
    'grading',
  );
  @override
  late final GeneratedColumn<String> grading = GeneratedColumn<String>(
    'grading',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _synopsisMeta = const VerificationMeta(
    'synopsis',
  );
  @override
  late final GeneratedColumn<String> synopsis = GeneratedColumn<String>(
    'synopsis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mainStaffMeta = const VerificationMeta(
    'mainStaff',
  );
  @override
  late final GeneratedColumn<String> mainStaff = GeneratedColumn<String>(
    'main_staff',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalMeta = const VerificationMeta(
    'original',
  );
  @override
  late final GeneratedColumn<String> original = GeneratedColumn<String>(
    'original',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _castMeta = const VerificationMeta('cast');
  @override
  late final GeneratedColumn<String> cast = GeneratedColumn<String>(
    'cast',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _opEdMeta = const VerificationMeta('opEd');
  @override
  late final GeneratedColumn<String> opEd = GeneratedColumn<String>(
    'op_ed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _watchPlatformsMeta = const VerificationMeta(
    'watchPlatforms',
  );
  @override
  late final GeneratedColumn<String> watchPlatforms = GeneratedColumn<String>(
    'watch_platforms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _officialSiteMeta = const VerificationMeta(
    'officialSite',
  );
  @override
  late final GeneratedColumn<String> officialSite = GeneratedColumn<String>(
    'official_site',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _socialLinkMeta = const VerificationMeta(
    'socialLink',
  );
  @override
  late final GeneratedColumn<String> socialLink = GeneratedColumn<String>(
    'social_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonalInfoMeta = const VerificationMeta(
    'seasonalInfo',
  );
  @override
  late final GeneratedColumn<String> seasonalInfo = GeneratedColumn<String>(
    'seasonal_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    studio,
    publisher,
    announcementDate,
    grading,
    synopsis,
    mainStaff,
    original,
    cast,
    opEd,
    watchPlatforms,
    officialSite,
    socialLink,
    version,
    lastUpdate,
    seasonalInfo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anime';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('title_jp')) {
      context.handle(
        _titleJpMeta,
        titleJp.isAcceptableOrUnknown(data['title_jp']!, _titleJpMeta),
      );
    }
    if (data.containsKey('cover_image_local')) {
      context.handle(
        _coverImageLocalMeta,
        coverImageLocal.isAcceptableOrUnknown(
          data['cover_image_local']!,
          _coverImageLocalMeta,
        ),
      );
    }
    if (data.containsKey('cover_image_remote')) {
      context.handle(
        _coverImageRemoteMeta,
        coverImageRemote.isAcceptableOrUnknown(
          data['cover_image_remote']!,
          _coverImageRemoteMeta,
        ),
      );
    }
    if (data.containsKey('studio')) {
      context.handle(
        _studioMeta,
        studio.isAcceptableOrUnknown(data['studio']!, _studioMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('announcement_date')) {
      context.handle(
        _announcementDateMeta,
        announcementDate.isAcceptableOrUnknown(
          data['announcement_date']!,
          _announcementDateMeta,
        ),
      );
    }
    if (data.containsKey('grading')) {
      context.handle(
        _gradingMeta,
        grading.isAcceptableOrUnknown(data['grading']!, _gradingMeta),
      );
    }
    if (data.containsKey('synopsis')) {
      context.handle(
        _synopsisMeta,
        synopsis.isAcceptableOrUnknown(data['synopsis']!, _synopsisMeta),
      );
    }
    if (data.containsKey('main_staff')) {
      context.handle(
        _mainStaffMeta,
        mainStaff.isAcceptableOrUnknown(data['main_staff']!, _mainStaffMeta),
      );
    }
    if (data.containsKey('original')) {
      context.handle(
        _originalMeta,
        original.isAcceptableOrUnknown(data['original']!, _originalMeta),
      );
    }
    if (data.containsKey('cast')) {
      context.handle(
        _castMeta,
        cast.isAcceptableOrUnknown(data['cast']!, _castMeta),
      );
    }
    if (data.containsKey('op_ed')) {
      context.handle(
        _opEdMeta,
        opEd.isAcceptableOrUnknown(data['op_ed']!, _opEdMeta),
      );
    }
    if (data.containsKey('watch_platforms')) {
      context.handle(
        _watchPlatformsMeta,
        watchPlatforms.isAcceptableOrUnknown(
          data['watch_platforms']!,
          _watchPlatformsMeta,
        ),
      );
    }
    if (data.containsKey('official_site')) {
      context.handle(
        _officialSiteMeta,
        officialSite.isAcceptableOrUnknown(
          data['official_site']!,
          _officialSiteMeta,
        ),
      );
    }
    if (data.containsKey('social_link')) {
      context.handle(
        _socialLinkMeta,
        socialLink.isAcceptableOrUnknown(data['social_link']!, _socialLinkMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    if (data.containsKey('seasonal_info')) {
      context.handle(
        _seasonalInfoMeta,
        seasonalInfo.isAcceptableOrUnknown(
          data['seasonal_info']!,
          _seasonalInfoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimeData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      titleJp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_jp'],
      ),
      coverImageLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_local'],
      ),
      coverImageRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_remote'],
      ),
      studio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}studio'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      announcementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}announcement_date'],
      ),
      grading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grading'],
      ),
      synopsis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synopsis'],
      ),
      mainStaff: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_staff'],
      ),
      original: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original'],
      ),
      cast: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cast'],
      ),
      opEd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op_ed'],
      ),
      watchPlatforms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}watch_platforms'],
      ),
      officialSite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}official_site'],
      ),
      socialLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}social_link'],
      ),
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}version'],
          )!,
      lastUpdate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_update'],
          )!,
      seasonalInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}seasonal_info'],
      ),
    );
  }

  @override
  $AnimeTable createAlias(String alias) {
    return $AnimeTable(attachedDatabase, alias);
  }
}

class AnimeData extends DataClass implements Insertable<AnimeData> {
  final String id;
  final String? title;
  final String? titleJp;
  final String? coverImageLocal;
  final String? coverImageRemote;
  final String? studio;
  final String? publisher;
  final DateTime? announcementDate;
  final String? grading;
  final String? synopsis;
  final String? mainStaff;
  final String? original;
  final String? cast;
  final String? opEd;
  final String? watchPlatforms;
  final String? officialSite;
  final String? socialLink;
  final String version;
  final DateTime lastUpdate;
  final String? seasonalInfo;
  const AnimeData({
    required this.id,
    this.title,
    this.titleJp,
    this.coverImageLocal,
    this.coverImageRemote,
    this.studio,
    this.publisher,
    this.announcementDate,
    this.grading,
    this.synopsis,
    this.mainStaff,
    this.original,
    this.cast,
    this.opEd,
    this.watchPlatforms,
    this.officialSite,
    this.socialLink,
    required this.version,
    required this.lastUpdate,
    this.seasonalInfo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || titleJp != null) {
      map['title_jp'] = Variable<String>(titleJp);
    }
    if (!nullToAbsent || coverImageLocal != null) {
      map['cover_image_local'] = Variable<String>(coverImageLocal);
    }
    if (!nullToAbsent || coverImageRemote != null) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote);
    }
    if (!nullToAbsent || studio != null) {
      map['studio'] = Variable<String>(studio);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || announcementDate != null) {
      map['announcement_date'] = Variable<DateTime>(announcementDate);
    }
    if (!nullToAbsent || grading != null) {
      map['grading'] = Variable<String>(grading);
    }
    if (!nullToAbsent || synopsis != null) {
      map['synopsis'] = Variable<String>(synopsis);
    }
    if (!nullToAbsent || mainStaff != null) {
      map['main_staff'] = Variable<String>(mainStaff);
    }
    if (!nullToAbsent || original != null) {
      map['original'] = Variable<String>(original);
    }
    if (!nullToAbsent || cast != null) {
      map['cast'] = Variable<String>(cast);
    }
    if (!nullToAbsent || opEd != null) {
      map['op_ed'] = Variable<String>(opEd);
    }
    if (!nullToAbsent || watchPlatforms != null) {
      map['watch_platforms'] = Variable<String>(watchPlatforms);
    }
    if (!nullToAbsent || officialSite != null) {
      map['official_site'] = Variable<String>(officialSite);
    }
    if (!nullToAbsent || socialLink != null) {
      map['social_link'] = Variable<String>(socialLink);
    }
    map['version'] = Variable<String>(version);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    if (!nullToAbsent || seasonalInfo != null) {
      map['seasonal_info'] = Variable<String>(seasonalInfo);
    }
    return map;
  }

  AnimeCompanion toCompanion(bool nullToAbsent) {
    return AnimeCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      titleJp:
          titleJp == null && nullToAbsent
              ? const Value.absent()
              : Value(titleJp),
      coverImageLocal:
          coverImageLocal == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageLocal),
      coverImageRemote:
          coverImageRemote == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageRemote),
      studio:
          studio == null && nullToAbsent ? const Value.absent() : Value(studio),
      publisher:
          publisher == null && nullToAbsent
              ? const Value.absent()
              : Value(publisher),
      announcementDate:
          announcementDate == null && nullToAbsent
              ? const Value.absent()
              : Value(announcementDate),
      grading:
          grading == null && nullToAbsent
              ? const Value.absent()
              : Value(grading),
      synopsis:
          synopsis == null && nullToAbsent
              ? const Value.absent()
              : Value(synopsis),
      mainStaff:
          mainStaff == null && nullToAbsent
              ? const Value.absent()
              : Value(mainStaff),
      original:
          original == null && nullToAbsent
              ? const Value.absent()
              : Value(original),
      cast: cast == null && nullToAbsent ? const Value.absent() : Value(cast),
      opEd: opEd == null && nullToAbsent ? const Value.absent() : Value(opEd),
      watchPlatforms:
          watchPlatforms == null && nullToAbsent
              ? const Value.absent()
              : Value(watchPlatforms),
      officialSite:
          officialSite == null && nullToAbsent
              ? const Value.absent()
              : Value(officialSite),
      socialLink:
          socialLink == null && nullToAbsent
              ? const Value.absent()
              : Value(socialLink),
      version: Value(version),
      lastUpdate: Value(lastUpdate),
      seasonalInfo:
          seasonalInfo == null && nullToAbsent
              ? const Value.absent()
              : Value(seasonalInfo),
    );
  }

  factory AnimeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimeData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      titleJp: serializer.fromJson<String?>(json['titleJp']),
      coverImageLocal: serializer.fromJson<String?>(json['coverImageLocal']),
      coverImageRemote: serializer.fromJson<String?>(json['coverImageRemote']),
      studio: serializer.fromJson<String?>(json['studio']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      announcementDate: serializer.fromJson<DateTime?>(
        json['announcementDate'],
      ),
      grading: serializer.fromJson<String?>(json['grading']),
      synopsis: serializer.fromJson<String?>(json['synopsis']),
      mainStaff: serializer.fromJson<String?>(json['mainStaff']),
      original: serializer.fromJson<String?>(json['original']),
      cast: serializer.fromJson<String?>(json['cast']),
      opEd: serializer.fromJson<String?>(json['opEd']),
      watchPlatforms: serializer.fromJson<String?>(json['watchPlatforms']),
      officialSite: serializer.fromJson<String?>(json['officialSite']),
      socialLink: serializer.fromJson<String?>(json['socialLink']),
      version: serializer.fromJson<String>(json['version']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
      seasonalInfo: serializer.fromJson<String?>(json['seasonalInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'titleJp': serializer.toJson<String?>(titleJp),
      'coverImageLocal': serializer.toJson<String?>(coverImageLocal),
      'coverImageRemote': serializer.toJson<String?>(coverImageRemote),
      'studio': serializer.toJson<String?>(studio),
      'publisher': serializer.toJson<String?>(publisher),
      'announcementDate': serializer.toJson<DateTime?>(announcementDate),
      'grading': serializer.toJson<String?>(grading),
      'synopsis': serializer.toJson<String?>(synopsis),
      'mainStaff': serializer.toJson<String?>(mainStaff),
      'original': serializer.toJson<String?>(original),
      'cast': serializer.toJson<String?>(cast),
      'opEd': serializer.toJson<String?>(opEd),
      'watchPlatforms': serializer.toJson<String?>(watchPlatforms),
      'officialSite': serializer.toJson<String?>(officialSite),
      'socialLink': serializer.toJson<String?>(socialLink),
      'version': serializer.toJson<String>(version),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
      'seasonalInfo': serializer.toJson<String?>(seasonalInfo),
    };
  }

  AnimeData copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    Value<String?> titleJp = const Value.absent(),
    Value<String?> coverImageLocal = const Value.absent(),
    Value<String?> coverImageRemote = const Value.absent(),
    Value<String?> studio = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<DateTime?> announcementDate = const Value.absent(),
    Value<String?> grading = const Value.absent(),
    Value<String?> synopsis = const Value.absent(),
    Value<String?> mainStaff = const Value.absent(),
    Value<String?> original = const Value.absent(),
    Value<String?> cast = const Value.absent(),
    Value<String?> opEd = const Value.absent(),
    Value<String?> watchPlatforms = const Value.absent(),
    Value<String?> officialSite = const Value.absent(),
    Value<String?> socialLink = const Value.absent(),
    String? version,
    DateTime? lastUpdate,
    Value<String?> seasonalInfo = const Value.absent(),
  }) => AnimeData(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    titleJp: titleJp.present ? titleJp.value : this.titleJp,
    coverImageLocal:
        coverImageLocal.present ? coverImageLocal.value : this.coverImageLocal,
    coverImageRemote:
        coverImageRemote.present
            ? coverImageRemote.value
            : this.coverImageRemote,
    studio: studio.present ? studio.value : this.studio,
    publisher: publisher.present ? publisher.value : this.publisher,
    announcementDate:
        announcementDate.present
            ? announcementDate.value
            : this.announcementDate,
    grading: grading.present ? grading.value : this.grading,
    synopsis: synopsis.present ? synopsis.value : this.synopsis,
    mainStaff: mainStaff.present ? mainStaff.value : this.mainStaff,
    original: original.present ? original.value : this.original,
    cast: cast.present ? cast.value : this.cast,
    opEd: opEd.present ? opEd.value : this.opEd,
    watchPlatforms:
        watchPlatforms.present ? watchPlatforms.value : this.watchPlatforms,
    officialSite: officialSite.present ? officialSite.value : this.officialSite,
    socialLink: socialLink.present ? socialLink.value : this.socialLink,
    version: version ?? this.version,
    lastUpdate: lastUpdate ?? this.lastUpdate,
    seasonalInfo: seasonalInfo.present ? seasonalInfo.value : this.seasonalInfo,
  );
  AnimeData copyWithCompanion(AnimeCompanion data) {
    return AnimeData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      titleJp: data.titleJp.present ? data.titleJp.value : this.titleJp,
      coverImageLocal:
          data.coverImageLocal.present
              ? data.coverImageLocal.value
              : this.coverImageLocal,
      coverImageRemote:
          data.coverImageRemote.present
              ? data.coverImageRemote.value
              : this.coverImageRemote,
      studio: data.studio.present ? data.studio.value : this.studio,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      announcementDate:
          data.announcementDate.present
              ? data.announcementDate.value
              : this.announcementDate,
      grading: data.grading.present ? data.grading.value : this.grading,
      synopsis: data.synopsis.present ? data.synopsis.value : this.synopsis,
      mainStaff: data.mainStaff.present ? data.mainStaff.value : this.mainStaff,
      original: data.original.present ? data.original.value : this.original,
      cast: data.cast.present ? data.cast.value : this.cast,
      opEd: data.opEd.present ? data.opEd.value : this.opEd,
      watchPlatforms:
          data.watchPlatforms.present
              ? data.watchPlatforms.value
              : this.watchPlatforms,
      officialSite:
          data.officialSite.present
              ? data.officialSite.value
              : this.officialSite,
      socialLink:
          data.socialLink.present ? data.socialLink.value : this.socialLink,
      version: data.version.present ? data.version.value : this.version,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
      seasonalInfo:
          data.seasonalInfo.present
              ? data.seasonalInfo.value
              : this.seasonalInfo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimeData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('studio: $studio, ')
          ..write('publisher: $publisher, ')
          ..write('announcementDate: $announcementDate, ')
          ..write('grading: $grading, ')
          ..write('synopsis: $synopsis, ')
          ..write('mainStaff: $mainStaff, ')
          ..write('original: $original, ')
          ..write('cast: $cast, ')
          ..write('opEd: $opEd, ')
          ..write('watchPlatforms: $watchPlatforms, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('seasonalInfo: $seasonalInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    studio,
    publisher,
    announcementDate,
    grading,
    synopsis,
    mainStaff,
    original,
    cast,
    opEd,
    watchPlatforms,
    officialSite,
    socialLink,
    version,
    lastUpdate,
    seasonalInfo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimeData &&
          other.id == this.id &&
          other.title == this.title &&
          other.titleJp == this.titleJp &&
          other.coverImageLocal == this.coverImageLocal &&
          other.coverImageRemote == this.coverImageRemote &&
          other.studio == this.studio &&
          other.publisher == this.publisher &&
          other.announcementDate == this.announcementDate &&
          other.grading == this.grading &&
          other.synopsis == this.synopsis &&
          other.mainStaff == this.mainStaff &&
          other.original == this.original &&
          other.cast == this.cast &&
          other.opEd == this.opEd &&
          other.watchPlatforms == this.watchPlatforms &&
          other.officialSite == this.officialSite &&
          other.socialLink == this.socialLink &&
          other.version == this.version &&
          other.lastUpdate == this.lastUpdate &&
          other.seasonalInfo == this.seasonalInfo);
}

class AnimeCompanion extends UpdateCompanion<AnimeData> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> titleJp;
  final Value<String?> coverImageLocal;
  final Value<String?> coverImageRemote;
  final Value<String?> studio;
  final Value<String?> publisher;
  final Value<DateTime?> announcementDate;
  final Value<String?> grading;
  final Value<String?> synopsis;
  final Value<String?> mainStaff;
  final Value<String?> original;
  final Value<String?> cast;
  final Value<String?> opEd;
  final Value<String?> watchPlatforms;
  final Value<String?> officialSite;
  final Value<String?> socialLink;
  final Value<String> version;
  final Value<DateTime> lastUpdate;
  final Value<String?> seasonalInfo;
  final Value<int> rowid;
  const AnimeCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    this.studio = const Value.absent(),
    this.publisher = const Value.absent(),
    this.announcementDate = const Value.absent(),
    this.grading = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.mainStaff = const Value.absent(),
    this.original = const Value.absent(),
    this.cast = const Value.absent(),
    this.opEd = const Value.absent(),
    this.watchPlatforms = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
    this.version = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.seasonalInfo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimeCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    this.studio = const Value.absent(),
    this.publisher = const Value.absent(),
    this.announcementDate = const Value.absent(),
    this.grading = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.mainStaff = const Value.absent(),
    this.original = const Value.absent(),
    this.cast = const Value.absent(),
    this.opEd = const Value.absent(),
    this.watchPlatforms = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
    required String version,
    required DateTime lastUpdate,
    this.seasonalInfo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       lastUpdate = Value(lastUpdate);
  static Insertable<AnimeData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? titleJp,
    Expression<String>? coverImageLocal,
    Expression<String>? coverImageRemote,
    Expression<String>? studio,
    Expression<String>? publisher,
    Expression<DateTime>? announcementDate,
    Expression<String>? grading,
    Expression<String>? synopsis,
    Expression<String>? mainStaff,
    Expression<String>? original,
    Expression<String>? cast,
    Expression<String>? opEd,
    Expression<String>? watchPlatforms,
    Expression<String>? officialSite,
    Expression<String>? socialLink,
    Expression<String>? version,
    Expression<DateTime>? lastUpdate,
    Expression<String>? seasonalInfo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (titleJp != null) 'title_jp': titleJp,
      if (coverImageLocal != null) 'cover_image_local': coverImageLocal,
      if (coverImageRemote != null) 'cover_image_remote': coverImageRemote,
      if (studio != null) 'studio': studio,
      if (publisher != null) 'publisher': publisher,
      if (announcementDate != null) 'announcement_date': announcementDate,
      if (grading != null) 'grading': grading,
      if (synopsis != null) 'synopsis': synopsis,
      if (mainStaff != null) 'main_staff': mainStaff,
      if (original != null) 'original': original,
      if (cast != null) 'cast': cast,
      if (opEd != null) 'op_ed': opEd,
      if (watchPlatforms != null) 'watch_platforms': watchPlatforms,
      if (officialSite != null) 'official_site': officialSite,
      if (socialLink != null) 'social_link': socialLink,
      if (version != null) 'version': version,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (seasonalInfo != null) 'seasonal_info': seasonalInfo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimeCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String?>? titleJp,
    Value<String?>? coverImageLocal,
    Value<String?>? coverImageRemote,
    Value<String?>? studio,
    Value<String?>? publisher,
    Value<DateTime?>? announcementDate,
    Value<String?>? grading,
    Value<String?>? synopsis,
    Value<String?>? mainStaff,
    Value<String?>? original,
    Value<String?>? cast,
    Value<String?>? opEd,
    Value<String?>? watchPlatforms,
    Value<String?>? officialSite,
    Value<String?>? socialLink,
    Value<String>? version,
    Value<DateTime>? lastUpdate,
    Value<String?>? seasonalInfo,
    Value<int>? rowid,
  }) {
    return AnimeCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      titleJp: titleJp ?? this.titleJp,
      coverImageLocal: coverImageLocal ?? this.coverImageLocal,
      coverImageRemote: coverImageRemote ?? this.coverImageRemote,
      studio: studio ?? this.studio,
      publisher: publisher ?? this.publisher,
      announcementDate: announcementDate ?? this.announcementDate,
      grading: grading ?? this.grading,
      synopsis: synopsis ?? this.synopsis,
      mainStaff: mainStaff ?? this.mainStaff,
      original: original ?? this.original,
      cast: cast ?? this.cast,
      opEd: opEd ?? this.opEd,
      watchPlatforms: watchPlatforms ?? this.watchPlatforms,
      officialSite: officialSite ?? this.officialSite,
      socialLink: socialLink ?? this.socialLink,
      version: version ?? this.version,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      seasonalInfo: seasonalInfo ?? this.seasonalInfo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleJp.present) {
      map['title_jp'] = Variable<String>(titleJp.value);
    }
    if (coverImageLocal.present) {
      map['cover_image_local'] = Variable<String>(coverImageLocal.value);
    }
    if (coverImageRemote.present) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote.value);
    }
    if (studio.present) {
      map['studio'] = Variable<String>(studio.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (announcementDate.present) {
      map['announcement_date'] = Variable<DateTime>(announcementDate.value);
    }
    if (grading.present) {
      map['grading'] = Variable<String>(grading.value);
    }
    if (synopsis.present) {
      map['synopsis'] = Variable<String>(synopsis.value);
    }
    if (mainStaff.present) {
      map['main_staff'] = Variable<String>(mainStaff.value);
    }
    if (original.present) {
      map['original'] = Variable<String>(original.value);
    }
    if (cast.present) {
      map['cast'] = Variable<String>(cast.value);
    }
    if (opEd.present) {
      map['op_ed'] = Variable<String>(opEd.value);
    }
    if (watchPlatforms.present) {
      map['watch_platforms'] = Variable<String>(watchPlatforms.value);
    }
    if (officialSite.present) {
      map['official_site'] = Variable<String>(officialSite.value);
    }
    if (socialLink.present) {
      map['social_link'] = Variable<String>(socialLink.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (seasonalInfo.present) {
      map['seasonal_info'] = Variable<String>(seasonalInfo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimeCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('studio: $studio, ')
          ..write('publisher: $publisher, ')
          ..write('announcementDate: $announcementDate, ')
          ..write('grading: $grading, ')
          ..write('synopsis: $synopsis, ')
          ..write('mainStaff: $mainStaff, ')
          ..write('original: $original, ')
          ..write('cast: $cast, ')
          ..write('opEd: $opEd, ')
          ..write('watchPlatforms: $watchPlatforms, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('seasonalInfo: $seasonalInfo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeasonsTable extends Seasons with TableInfo<$SeasonsTable, Season> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeasonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _animeIdMeta = const VerificationMeta(
    'animeId',
  );
  @override
  late final GeneratedColumn<String> animeId = GeneratedColumn<String>(
    'anime_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonNumberMeta = const VerificationMeta(
    'seasonNumber',
  );
  @override
  late final GeneratedColumn<int> seasonNumber = GeneratedColumn<int>(
    'season_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productionAnnouncementDateMeta =
      const VerificationMeta('productionAnnouncementDate');
  @override
  late final GeneratedColumn<DateTime> productionAnnouncementDate =
      GeneratedColumn<DateTime>(
        'production_announcement_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> releaseDate = GeneratedColumn<DateTime>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _episodesCountMeta = const VerificationMeta(
    'episodesCount',
  );
  @override
  late final GeneratedColumn<int> episodesCount = GeneratedColumn<int>(
    'episodes_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateUnknownMeta =
      const VerificationMeta('releaseDateUnknown');
  @override
  late final GeneratedColumn<bool> releaseDateUnknown = GeneratedColumn<bool>(
    'release_date_unknown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("release_date_unknown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    animeId,
    seasonNumber,
    productionAnnouncementDate,
    releaseDate,
    episodesCount,
    releaseDateUnknown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seasons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Season> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('anime_id')) {
      context.handle(
        _animeIdMeta,
        animeId.isAcceptableOrUnknown(data['anime_id']!, _animeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animeIdMeta);
    }
    if (data.containsKey('season_number')) {
      context.handle(
        _seasonNumberMeta,
        seasonNumber.isAcceptableOrUnknown(
          data['season_number']!,
          _seasonNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seasonNumberMeta);
    }
    if (data.containsKey('production_announcement_date')) {
      context.handle(
        _productionAnnouncementDateMeta,
        productionAnnouncementDate.isAcceptableOrUnknown(
          data['production_announcement_date']!,
          _productionAnnouncementDateMeta,
        ),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('episodes_count')) {
      context.handle(
        _episodesCountMeta,
        episodesCount.isAcceptableOrUnknown(
          data['episodes_count']!,
          _episodesCountMeta,
        ),
      );
    }
    if (data.containsKey('release_date_unknown')) {
      context.handle(
        _releaseDateUnknownMeta,
        releaseDateUnknown.isAcceptableOrUnknown(
          data['release_date_unknown']!,
          _releaseDateUnknownMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {animeId, seasonNumber};
  @override
  Season map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Season(
      animeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}anime_id'],
          )!,
      seasonNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}season_number'],
          )!,
      productionAnnouncementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}production_announcement_date'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}release_date'],
      ),
      episodesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}episodes_count'],
      ),
      releaseDateUnknown:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}release_date_unknown'],
          )!,
    );
  }

  @override
  $SeasonsTable createAlias(String alias) {
    return $SeasonsTable(attachedDatabase, alias);
  }
}

class Season extends DataClass implements Insertable<Season> {
  final String animeId;
  final int seasonNumber;
  final DateTime? productionAnnouncementDate;
  final DateTime? releaseDate;
  final int? episodesCount;
  final bool releaseDateUnknown;
  const Season({
    required this.animeId,
    required this.seasonNumber,
    this.productionAnnouncementDate,
    this.releaseDate,
    this.episodesCount,
    required this.releaseDateUnknown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['anime_id'] = Variable<String>(animeId);
    map['season_number'] = Variable<int>(seasonNumber);
    if (!nullToAbsent || productionAnnouncementDate != null) {
      map['production_announcement_date'] = Variable<DateTime>(
        productionAnnouncementDate,
      );
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<DateTime>(releaseDate);
    }
    if (!nullToAbsent || episodesCount != null) {
      map['episodes_count'] = Variable<int>(episodesCount);
    }
    map['release_date_unknown'] = Variable<bool>(releaseDateUnknown);
    return map;
  }

  SeasonsCompanion toCompanion(bool nullToAbsent) {
    return SeasonsCompanion(
      animeId: Value(animeId),
      seasonNumber: Value(seasonNumber),
      productionAnnouncementDate:
          productionAnnouncementDate == null && nullToAbsent
              ? const Value.absent()
              : Value(productionAnnouncementDate),
      releaseDate:
          releaseDate == null && nullToAbsent
              ? const Value.absent()
              : Value(releaseDate),
      episodesCount:
          episodesCount == null && nullToAbsent
              ? const Value.absent()
              : Value(episodesCount),
      releaseDateUnknown: Value(releaseDateUnknown),
    );
  }

  factory Season.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Season(
      animeId: serializer.fromJson<String>(json['animeId']),
      seasonNumber: serializer.fromJson<int>(json['seasonNumber']),
      productionAnnouncementDate: serializer.fromJson<DateTime?>(
        json['productionAnnouncementDate'],
      ),
      releaseDate: serializer.fromJson<DateTime?>(json['releaseDate']),
      episodesCount: serializer.fromJson<int?>(json['episodesCount']),
      releaseDateUnknown: serializer.fromJson<bool>(json['releaseDateUnknown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'animeId': serializer.toJson<String>(animeId),
      'seasonNumber': serializer.toJson<int>(seasonNumber),
      'productionAnnouncementDate': serializer.toJson<DateTime?>(
        productionAnnouncementDate,
      ),
      'releaseDate': serializer.toJson<DateTime?>(releaseDate),
      'episodesCount': serializer.toJson<int?>(episodesCount),
      'releaseDateUnknown': serializer.toJson<bool>(releaseDateUnknown),
    };
  }

  Season copyWith({
    String? animeId,
    int? seasonNumber,
    Value<DateTime?> productionAnnouncementDate = const Value.absent(),
    Value<DateTime?> releaseDate = const Value.absent(),
    Value<int?> episodesCount = const Value.absent(),
    bool? releaseDateUnknown,
  }) => Season(
    animeId: animeId ?? this.animeId,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    productionAnnouncementDate:
        productionAnnouncementDate.present
            ? productionAnnouncementDate.value
            : this.productionAnnouncementDate,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    episodesCount:
        episodesCount.present ? episodesCount.value : this.episodesCount,
    releaseDateUnknown: releaseDateUnknown ?? this.releaseDateUnknown,
  );
  Season copyWithCompanion(SeasonsCompanion data) {
    return Season(
      animeId: data.animeId.present ? data.animeId.value : this.animeId,
      seasonNumber:
          data.seasonNumber.present
              ? data.seasonNumber.value
              : this.seasonNumber,
      productionAnnouncementDate:
          data.productionAnnouncementDate.present
              ? data.productionAnnouncementDate.value
              : this.productionAnnouncementDate,
      releaseDate:
          data.releaseDate.present ? data.releaseDate.value : this.releaseDate,
      episodesCount:
          data.episodesCount.present
              ? data.episodesCount.value
              : this.episodesCount,
      releaseDateUnknown:
          data.releaseDateUnknown.present
              ? data.releaseDateUnknown.value
              : this.releaseDateUnknown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Season(')
          ..write('animeId: $animeId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('productionAnnouncementDate: $productionAnnouncementDate, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('episodesCount: $episodesCount, ')
          ..write('releaseDateUnknown: $releaseDateUnknown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    animeId,
    seasonNumber,
    productionAnnouncementDate,
    releaseDate,
    episodesCount,
    releaseDateUnknown,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Season &&
          other.animeId == this.animeId &&
          other.seasonNumber == this.seasonNumber &&
          other.productionAnnouncementDate == this.productionAnnouncementDate &&
          other.releaseDate == this.releaseDate &&
          other.episodesCount == this.episodesCount &&
          other.releaseDateUnknown == this.releaseDateUnknown);
}

class SeasonsCompanion extends UpdateCompanion<Season> {
  final Value<String> animeId;
  final Value<int> seasonNumber;
  final Value<DateTime?> productionAnnouncementDate;
  final Value<DateTime?> releaseDate;
  final Value<int?> episodesCount;
  final Value<bool> releaseDateUnknown;
  final Value<int> rowid;
  const SeasonsCompanion({
    this.animeId = const Value.absent(),
    this.seasonNumber = const Value.absent(),
    this.productionAnnouncementDate = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.episodesCount = const Value.absent(),
    this.releaseDateUnknown = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeasonsCompanion.insert({
    required String animeId,
    required int seasonNumber,
    this.productionAnnouncementDate = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.episodesCount = const Value.absent(),
    this.releaseDateUnknown = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : animeId = Value(animeId),
       seasonNumber = Value(seasonNumber);
  static Insertable<Season> custom({
    Expression<String>? animeId,
    Expression<int>? seasonNumber,
    Expression<DateTime>? productionAnnouncementDate,
    Expression<DateTime>? releaseDate,
    Expression<int>? episodesCount,
    Expression<bool>? releaseDateUnknown,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (animeId != null) 'anime_id': animeId,
      if (seasonNumber != null) 'season_number': seasonNumber,
      if (productionAnnouncementDate != null)
        'production_announcement_date': productionAnnouncementDate,
      if (releaseDate != null) 'release_date': releaseDate,
      if (episodesCount != null) 'episodes_count': episodesCount,
      if (releaseDateUnknown != null)
        'release_date_unknown': releaseDateUnknown,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeasonsCompanion copyWith({
    Value<String>? animeId,
    Value<int>? seasonNumber,
    Value<DateTime?>? productionAnnouncementDate,
    Value<DateTime?>? releaseDate,
    Value<int?>? episodesCount,
    Value<bool>? releaseDateUnknown,
    Value<int>? rowid,
  }) {
    return SeasonsCompanion(
      animeId: animeId ?? this.animeId,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      productionAnnouncementDate:
          productionAnnouncementDate ?? this.productionAnnouncementDate,
      releaseDate: releaseDate ?? this.releaseDate,
      episodesCount: episodesCount ?? this.episodesCount,
      releaseDateUnknown: releaseDateUnknown ?? this.releaseDateUnknown,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (animeId.present) {
      map['anime_id'] = Variable<String>(animeId.value);
    }
    if (seasonNumber.present) {
      map['season_number'] = Variable<int>(seasonNumber.value);
    }
    if (productionAnnouncementDate.present) {
      map['production_announcement_date'] = Variable<DateTime>(
        productionAnnouncementDate.value,
      );
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<DateTime>(releaseDate.value);
    }
    if (episodesCount.present) {
      map['episodes_count'] = Variable<int>(episodesCount.value);
    }
    if (releaseDateUnknown.present) {
      map['release_date_unknown'] = Variable<bool>(releaseDateUnknown.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeasonsCompanion(')
          ..write('animeId: $animeId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('productionAnnouncementDate: $productionAnnouncementDate, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('episodesCount: $episodesCount, ')
          ..write('releaseDateUnknown: $releaseDateUnknown, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EpisodesTable extends Episodes with TableInfo<$EpisodesTable, Episode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpisodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _animeIdMeta = const VerificationMeta(
    'animeId',
  );
  @override
  late final GeneratedColumn<String> animeId = GeneratedColumn<String>(
    'anime_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonNumberMeta = const VerificationMeta(
    'seasonNumber',
  );
  @override
  late final GeneratedColumn<int> seasonNumber = GeneratedColumn<int>(
    'season_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeNumberMeta = const VerificationMeta(
    'episodeNumber',
  );
  @override
  late final GeneratedColumn<int> episodeNumber = GeneratedColumn<int>(
    'episode_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeLabelMeta = const VerificationMeta(
    'episodeLabel',
  );
  @override
  late final GeneratedColumn<String> episodeLabel = GeneratedColumn<String>(
    'episode_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _airTimeMeta = const VerificationMeta(
    'airTime',
  );
  @override
  late final GeneratedColumn<DateTime> airTime = GeneratedColumn<DateTime>(
    'air_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isTimeUnknownMeta = const VerificationMeta(
    'isTimeUnknown',
  );
  @override
  late final GeneratedColumn<bool> isTimeUnknown = GeneratedColumn<bool>(
    'is_time_unknown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_time_unknown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animeId,
    seasonNumber,
    episodeNumber,
    episodeLabel,
    airTime,
    isTimeUnknown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'episodes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Episode> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('anime_id')) {
      context.handle(
        _animeIdMeta,
        animeId.isAcceptableOrUnknown(data['anime_id']!, _animeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animeIdMeta);
    }
    if (data.containsKey('season_number')) {
      context.handle(
        _seasonNumberMeta,
        seasonNumber.isAcceptableOrUnknown(
          data['season_number']!,
          _seasonNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_seasonNumberMeta);
    }
    if (data.containsKey('episode_number')) {
      context.handle(
        _episodeNumberMeta,
        episodeNumber.isAcceptableOrUnknown(
          data['episode_number']!,
          _episodeNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_episodeNumberMeta);
    }
    if (data.containsKey('episode_label')) {
      context.handle(
        _episodeLabelMeta,
        episodeLabel.isAcceptableOrUnknown(
          data['episode_label']!,
          _episodeLabelMeta,
        ),
      );
    }
    if (data.containsKey('air_time')) {
      context.handle(
        _airTimeMeta,
        airTime.isAcceptableOrUnknown(data['air_time']!, _airTimeMeta),
      );
    }
    if (data.containsKey('is_time_unknown')) {
      context.handle(
        _isTimeUnknownMeta,
        isTimeUnknown.isAcceptableOrUnknown(
          data['is_time_unknown']!,
          _isTimeUnknownMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Episode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Episode(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      animeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}anime_id'],
          )!,
      seasonNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}season_number'],
          )!,
      episodeNumber:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}episode_number'],
          )!,
      episodeLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_label'],
      ),
      airTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}air_time'],
      ),
      isTimeUnknown:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_time_unknown'],
          )!,
    );
  }

  @override
  $EpisodesTable createAlias(String alias) {
    return $EpisodesTable(attachedDatabase, alias);
  }
}

class Episode extends DataClass implements Insertable<Episode> {
  final int id;
  final String animeId;
  final int seasonNumber;
  final int episodeNumber;
  final String? episodeLabel;
  final DateTime? airTime;
  final bool isTimeUnknown;
  const Episode({
    required this.id,
    required this.animeId,
    required this.seasonNumber,
    required this.episodeNumber,
    this.episodeLabel,
    this.airTime,
    required this.isTimeUnknown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['anime_id'] = Variable<String>(animeId);
    map['season_number'] = Variable<int>(seasonNumber);
    map['episode_number'] = Variable<int>(episodeNumber);
    if (!nullToAbsent || episodeLabel != null) {
      map['episode_label'] = Variable<String>(episodeLabel);
    }
    if (!nullToAbsent || airTime != null) {
      map['air_time'] = Variable<DateTime>(airTime);
    }
    map['is_time_unknown'] = Variable<bool>(isTimeUnknown);
    return map;
  }

  EpisodesCompanion toCompanion(bool nullToAbsent) {
    return EpisodesCompanion(
      id: Value(id),
      animeId: Value(animeId),
      seasonNumber: Value(seasonNumber),
      episodeNumber: Value(episodeNumber),
      episodeLabel:
          episodeLabel == null && nullToAbsent
              ? const Value.absent()
              : Value(episodeLabel),
      airTime:
          airTime == null && nullToAbsent
              ? const Value.absent()
              : Value(airTime),
      isTimeUnknown: Value(isTimeUnknown),
    );
  }

  factory Episode.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Episode(
      id: serializer.fromJson<int>(json['id']),
      animeId: serializer.fromJson<String>(json['animeId']),
      seasonNumber: serializer.fromJson<int>(json['seasonNumber']),
      episodeNumber: serializer.fromJson<int>(json['episodeNumber']),
      episodeLabel: serializer.fromJson<String?>(json['episodeLabel']),
      airTime: serializer.fromJson<DateTime?>(json['airTime']),
      isTimeUnknown: serializer.fromJson<bool>(json['isTimeUnknown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'animeId': serializer.toJson<String>(animeId),
      'seasonNumber': serializer.toJson<int>(seasonNumber),
      'episodeNumber': serializer.toJson<int>(episodeNumber),
      'episodeLabel': serializer.toJson<String?>(episodeLabel),
      'airTime': serializer.toJson<DateTime?>(airTime),
      'isTimeUnknown': serializer.toJson<bool>(isTimeUnknown),
    };
  }

  Episode copyWith({
    int? id,
    String? animeId,
    int? seasonNumber,
    int? episodeNumber,
    Value<String?> episodeLabel = const Value.absent(),
    Value<DateTime?> airTime = const Value.absent(),
    bool? isTimeUnknown,
  }) => Episode(
    id: id ?? this.id,
    animeId: animeId ?? this.animeId,
    seasonNumber: seasonNumber ?? this.seasonNumber,
    episodeNumber: episodeNumber ?? this.episodeNumber,
    episodeLabel: episodeLabel.present ? episodeLabel.value : this.episodeLabel,
    airTime: airTime.present ? airTime.value : this.airTime,
    isTimeUnknown: isTimeUnknown ?? this.isTimeUnknown,
  );
  Episode copyWithCompanion(EpisodesCompanion data) {
    return Episode(
      id: data.id.present ? data.id.value : this.id,
      animeId: data.animeId.present ? data.animeId.value : this.animeId,
      seasonNumber:
          data.seasonNumber.present
              ? data.seasonNumber.value
              : this.seasonNumber,
      episodeNumber:
          data.episodeNumber.present
              ? data.episodeNumber.value
              : this.episodeNumber,
      episodeLabel:
          data.episodeLabel.present
              ? data.episodeLabel.value
              : this.episodeLabel,
      airTime: data.airTime.present ? data.airTime.value : this.airTime,
      isTimeUnknown:
          data.isTimeUnknown.present
              ? data.isTimeUnknown.value
              : this.isTimeUnknown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Episode(')
          ..write('id: $id, ')
          ..write('animeId: $animeId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('episodeNumber: $episodeNumber, ')
          ..write('episodeLabel: $episodeLabel, ')
          ..write('airTime: $airTime, ')
          ..write('isTimeUnknown: $isTimeUnknown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animeId,
    seasonNumber,
    episodeNumber,
    episodeLabel,
    airTime,
    isTimeUnknown,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Episode &&
          other.id == this.id &&
          other.animeId == this.animeId &&
          other.seasonNumber == this.seasonNumber &&
          other.episodeNumber == this.episodeNumber &&
          other.episodeLabel == this.episodeLabel &&
          other.airTime == this.airTime &&
          other.isTimeUnknown == this.isTimeUnknown);
}

class EpisodesCompanion extends UpdateCompanion<Episode> {
  final Value<int> id;
  final Value<String> animeId;
  final Value<int> seasonNumber;
  final Value<int> episodeNumber;
  final Value<String?> episodeLabel;
  final Value<DateTime?> airTime;
  final Value<bool> isTimeUnknown;
  const EpisodesCompanion({
    this.id = const Value.absent(),
    this.animeId = const Value.absent(),
    this.seasonNumber = const Value.absent(),
    this.episodeNumber = const Value.absent(),
    this.episodeLabel = const Value.absent(),
    this.airTime = const Value.absent(),
    this.isTimeUnknown = const Value.absent(),
  });
  EpisodesCompanion.insert({
    this.id = const Value.absent(),
    required String animeId,
    required int seasonNumber,
    required int episodeNumber,
    this.episodeLabel = const Value.absent(),
    this.airTime = const Value.absent(),
    this.isTimeUnknown = const Value.absent(),
  }) : animeId = Value(animeId),
       seasonNumber = Value(seasonNumber),
       episodeNumber = Value(episodeNumber);
  static Insertable<Episode> custom({
    Expression<int>? id,
    Expression<String>? animeId,
    Expression<int>? seasonNumber,
    Expression<int>? episodeNumber,
    Expression<String>? episodeLabel,
    Expression<DateTime>? airTime,
    Expression<bool>? isTimeUnknown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animeId != null) 'anime_id': animeId,
      if (seasonNumber != null) 'season_number': seasonNumber,
      if (episodeNumber != null) 'episode_number': episodeNumber,
      if (episodeLabel != null) 'episode_label': episodeLabel,
      if (airTime != null) 'air_time': airTime,
      if (isTimeUnknown != null) 'is_time_unknown': isTimeUnknown,
    });
  }

  EpisodesCompanion copyWith({
    Value<int>? id,
    Value<String>? animeId,
    Value<int>? seasonNumber,
    Value<int>? episodeNumber,
    Value<String?>? episodeLabel,
    Value<DateTime?>? airTime,
    Value<bool>? isTimeUnknown,
  }) {
    return EpisodesCompanion(
      id: id ?? this.id,
      animeId: animeId ?? this.animeId,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      episodeLabel: episodeLabel ?? this.episodeLabel,
      airTime: airTime ?? this.airTime,
      isTimeUnknown: isTimeUnknown ?? this.isTimeUnknown,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (animeId.present) {
      map['anime_id'] = Variable<String>(animeId.value);
    }
    if (seasonNumber.present) {
      map['season_number'] = Variable<int>(seasonNumber.value);
    }
    if (episodeNumber.present) {
      map['episode_number'] = Variable<int>(episodeNumber.value);
    }
    if (episodeLabel.present) {
      map['episode_label'] = Variable<String>(episodeLabel.value);
    }
    if (airTime.present) {
      map['air_time'] = Variable<DateTime>(airTime.value);
    }
    if (isTimeUnknown.present) {
      map['is_time_unknown'] = Variable<bool>(isTimeUnknown.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpisodesCompanion(')
          ..write('id: $id, ')
          ..write('animeId: $animeId, ')
          ..write('seasonNumber: $seasonNumber, ')
          ..write('episodeNumber: $episodeNumber, ')
          ..write('episodeLabel: $episodeLabel, ')
          ..write('airTime: $airTime, ')
          ..write('isTimeUnknown: $isTimeUnknown')
          ..write(')'))
        .toString();
  }
}

class $ComicsTable extends Comics with TableInfo<$ComicsTable, Comic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleJpMeta = const VerificationMeta(
    'titleJp',
  );
  @override
  late final GeneratedColumn<String> titleJp = GeneratedColumn<String>(
    'title_jp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageLocalMeta = const VerificationMeta(
    'coverImageLocal',
  );
  @override
  late final GeneratedColumn<String> coverImageLocal = GeneratedColumn<String>(
    'cover_image_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageRemoteMeta = const VerificationMeta(
    'coverImageRemote',
  );
  @override
  late final GeneratedColumn<String> coverImageRemote = GeneratedColumn<String>(
    'cover_image_remote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    version,
    lastUpdate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Comic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('title_jp')) {
      context.handle(
        _titleJpMeta,
        titleJp.isAcceptableOrUnknown(data['title_jp']!, _titleJpMeta),
      );
    }
    if (data.containsKey('cover_image_local')) {
      context.handle(
        _coverImageLocalMeta,
        coverImageLocal.isAcceptableOrUnknown(
          data['cover_image_local']!,
          _coverImageLocalMeta,
        ),
      );
    }
    if (data.containsKey('cover_image_remote')) {
      context.handle(
        _coverImageRemoteMeta,
        coverImageRemote.isAcceptableOrUnknown(
          data['cover_image_remote']!,
          _coverImageRemoteMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Comic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Comic(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      titleJp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_jp'],
      ),
      coverImageLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_local'],
      ),
      coverImageRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_remote'],
      ),
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}version'],
          )!,
      lastUpdate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_update'],
          )!,
    );
  }

  @override
  $ComicsTable createAlias(String alias) {
    return $ComicsTable(attachedDatabase, alias);
  }
}

class Comic extends DataClass implements Insertable<Comic> {
  final String id;
  final String? title;
  final String? titleJp;
  final String? coverImageLocal;
  final String? coverImageRemote;
  final String version;
  final DateTime lastUpdate;
  const Comic({
    required this.id,
    this.title,
    this.titleJp,
    this.coverImageLocal,
    this.coverImageRemote,
    required this.version,
    required this.lastUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || titleJp != null) {
      map['title_jp'] = Variable<String>(titleJp);
    }
    if (!nullToAbsent || coverImageLocal != null) {
      map['cover_image_local'] = Variable<String>(coverImageLocal);
    }
    if (!nullToAbsent || coverImageRemote != null) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote);
    }
    map['version'] = Variable<String>(version);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  ComicsCompanion toCompanion(bool nullToAbsent) {
    return ComicsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      titleJp:
          titleJp == null && nullToAbsent
              ? const Value.absent()
              : Value(titleJp),
      coverImageLocal:
          coverImageLocal == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageLocal),
      coverImageRemote:
          coverImageRemote == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageRemote),
      version: Value(version),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory Comic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Comic(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      titleJp: serializer.fromJson<String?>(json['titleJp']),
      coverImageLocal: serializer.fromJson<String?>(json['coverImageLocal']),
      coverImageRemote: serializer.fromJson<String?>(json['coverImageRemote']),
      version: serializer.fromJson<String>(json['version']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'titleJp': serializer.toJson<String?>(titleJp),
      'coverImageLocal': serializer.toJson<String?>(coverImageLocal),
      'coverImageRemote': serializer.toJson<String?>(coverImageRemote),
      'version': serializer.toJson<String>(version),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  Comic copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    Value<String?> titleJp = const Value.absent(),
    Value<String?> coverImageLocal = const Value.absent(),
    Value<String?> coverImageRemote = const Value.absent(),
    String? version,
    DateTime? lastUpdate,
  }) => Comic(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    titleJp: titleJp.present ? titleJp.value : this.titleJp,
    coverImageLocal:
        coverImageLocal.present ? coverImageLocal.value : this.coverImageLocal,
    coverImageRemote:
        coverImageRemote.present
            ? coverImageRemote.value
            : this.coverImageRemote,
    version: version ?? this.version,
    lastUpdate: lastUpdate ?? this.lastUpdate,
  );
  Comic copyWithCompanion(ComicsCompanion data) {
    return Comic(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      titleJp: data.titleJp.present ? data.titleJp.value : this.titleJp,
      coverImageLocal:
          data.coverImageLocal.present
              ? data.coverImageLocal.value
              : this.coverImageLocal,
      coverImageRemote:
          data.coverImageRemote.present
              ? data.coverImageRemote.value
              : this.coverImageRemote,
      version: data.version.present ? data.version.value : this.version,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Comic(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    version,
    lastUpdate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comic &&
          other.id == this.id &&
          other.title == this.title &&
          other.titleJp == this.titleJp &&
          other.coverImageLocal == this.coverImageLocal &&
          other.coverImageRemote == this.coverImageRemote &&
          other.version == this.version &&
          other.lastUpdate == this.lastUpdate);
}

class ComicsCompanion extends UpdateCompanion<Comic> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> titleJp;
  final Value<String?> coverImageLocal;
  final Value<String?> coverImageRemote;
  final Value<String> version;
  final Value<DateTime> lastUpdate;
  final Value<int> rowid;
  const ComicsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    this.version = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComicsCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    required String version,
    required DateTime lastUpdate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       lastUpdate = Value(lastUpdate);
  static Insertable<Comic> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? titleJp,
    Expression<String>? coverImageLocal,
    Expression<String>? coverImageRemote,
    Expression<String>? version,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (titleJp != null) 'title_jp': titleJp,
      if (coverImageLocal != null) 'cover_image_local': coverImageLocal,
      if (coverImageRemote != null) 'cover_image_remote': coverImageRemote,
      if (version != null) 'version': version,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComicsCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String?>? titleJp,
    Value<String?>? coverImageLocal,
    Value<String?>? coverImageRemote,
    Value<String>? version,
    Value<DateTime>? lastUpdate,
    Value<int>? rowid,
  }) {
    return ComicsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      titleJp: titleJp ?? this.titleJp,
      coverImageLocal: coverImageLocal ?? this.coverImageLocal,
      coverImageRemote: coverImageRemote ?? this.coverImageRemote,
      version: version ?? this.version,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleJp.present) {
      map['title_jp'] = Variable<String>(titleJp.value);
    }
    if (coverImageLocal.present) {
      map['cover_image_local'] = Variable<String>(coverImageLocal.value);
    }
    if (coverImageRemote.present) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComicsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ComicsBooksTable extends ComicsBooks
    with TableInfo<$ComicsBooksTable, ComicsBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComicsBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _comicsIdMeta = const VerificationMeta(
    'comicsId',
  );
  @override
  late final GeneratedColumn<String> comicsId = GeneratedColumn<String>(
    'comics_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumesMeta = const VerificationMeta(
    'volumes',
  );
  @override
  late final GeneratedColumn<int> volumes = GeneratedColumn<int>(
    'volumes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateTwMeta = const VerificationMeta(
    'releaseDateTw',
  );
  @override
  late final GeneratedColumn<DateTime> releaseDateTw =
      GeneratedColumn<DateTime>(
        'release_date_tw',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _releaseDateJpMeta = const VerificationMeta(
    'releaseDateJp',
  );
  @override
  late final GeneratedColumn<DateTime> releaseDateJp =
      GeneratedColumn<DateTime>(
        'release_date_jp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _gradingMeta = const VerificationMeta(
    'grading',
  );
  @override
  late final GeneratedColumn<String> grading = GeneratedColumn<String>(
    'grading',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricingMeta = const VerificationMeta(
    'pricing',
  );
  @override
  late final GeneratedColumn<String> pricing = GeneratedColumn<String>(
    'pricing',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _synopsisMeta = const VerificationMeta(
    'synopsis',
  );
  @override
  late final GeneratedColumn<String> synopsis = GeneratedColumn<String>(
    'synopsis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageMeta = const VerificationMeta(
    'coverImage',
  );
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
    'cover_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePhysicalMeta = const VerificationMeta(
    'purchasePhysical',
  );
  @override
  late final GeneratedColumn<String> purchasePhysical = GeneratedColumn<String>(
    'purchase_physical',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseEbookMeta = const VerificationMeta(
    'purchaseEbook',
  );
  @override
  late final GeneratedColumn<String> purchaseEbook = GeneratedColumn<String>(
    'purchase_ebook',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _officialSiteMeta = const VerificationMeta(
    'officialSite',
  );
  @override
  late final GeneratedColumn<String> officialSite = GeneratedColumn<String>(
    'official_site',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _socialLinkMeta = const VerificationMeta(
    'socialLink',
  );
  @override
  late final GeneratedColumn<String> socialLink = GeneratedColumn<String>(
    'social_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    comicsId,
    type,
    publisher,
    volumes,
    releaseDateTw,
    releaseDateJp,
    grading,
    pricing,
    synopsis,
    coverImage,
    purchasePhysical,
    purchaseEbook,
    officialSite,
    socialLink,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comics_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComicsBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('comics_id')) {
      context.handle(
        _comicsIdMeta,
        comicsId.isAcceptableOrUnknown(data['comics_id']!, _comicsIdMeta),
      );
    } else if (isInserting) {
      context.missing(_comicsIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('volumes')) {
      context.handle(
        _volumesMeta,
        volumes.isAcceptableOrUnknown(data['volumes']!, _volumesMeta),
      );
    }
    if (data.containsKey('release_date_tw')) {
      context.handle(
        _releaseDateTwMeta,
        releaseDateTw.isAcceptableOrUnknown(
          data['release_date_tw']!,
          _releaseDateTwMeta,
        ),
      );
    }
    if (data.containsKey('release_date_jp')) {
      context.handle(
        _releaseDateJpMeta,
        releaseDateJp.isAcceptableOrUnknown(
          data['release_date_jp']!,
          _releaseDateJpMeta,
        ),
      );
    }
    if (data.containsKey('grading')) {
      context.handle(
        _gradingMeta,
        grading.isAcceptableOrUnknown(data['grading']!, _gradingMeta),
      );
    }
    if (data.containsKey('pricing')) {
      context.handle(
        _pricingMeta,
        pricing.isAcceptableOrUnknown(data['pricing']!, _pricingMeta),
      );
    }
    if (data.containsKey('synopsis')) {
      context.handle(
        _synopsisMeta,
        synopsis.isAcceptableOrUnknown(data['synopsis']!, _synopsisMeta),
      );
    }
    if (data.containsKey('cover_image')) {
      context.handle(
        _coverImageMeta,
        coverImage.isAcceptableOrUnknown(data['cover_image']!, _coverImageMeta),
      );
    }
    if (data.containsKey('purchase_physical')) {
      context.handle(
        _purchasePhysicalMeta,
        purchasePhysical.isAcceptableOrUnknown(
          data['purchase_physical']!,
          _purchasePhysicalMeta,
        ),
      );
    }
    if (data.containsKey('purchase_ebook')) {
      context.handle(
        _purchaseEbookMeta,
        purchaseEbook.isAcceptableOrUnknown(
          data['purchase_ebook']!,
          _purchaseEbookMeta,
        ),
      );
    }
    if (data.containsKey('official_site')) {
      context.handle(
        _officialSiteMeta,
        officialSite.isAcceptableOrUnknown(
          data['official_site']!,
          _officialSiteMeta,
        ),
      );
    }
    if (data.containsKey('social_link')) {
      context.handle(
        _socialLinkMeta,
        socialLink.isAcceptableOrUnknown(data['social_link']!, _socialLinkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComicsBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComicsBook(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      comicsId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}comics_id'],
          )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      volumes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volumes'],
      ),
      releaseDateTw: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}release_date_tw'],
      ),
      releaseDateJp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}release_date_jp'],
      ),
      grading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grading'],
      ),
      pricing: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing'],
      ),
      synopsis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synopsis'],
      ),
      coverImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image'],
      ),
      purchasePhysical: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_physical'],
      ),
      purchaseEbook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_ebook'],
      ),
      officialSite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}official_site'],
      ),
      socialLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}social_link'],
      ),
    );
  }

  @override
  $ComicsBooksTable createAlias(String alias) {
    return $ComicsBooksTable(attachedDatabase, alias);
  }
}

class ComicsBook extends DataClass implements Insertable<ComicsBook> {
  final int id;
  final String comicsId;
  final String? type;
  final String? publisher;
  final int? volumes;
  final DateTime? releaseDateTw;
  final DateTime? releaseDateJp;
  final String? grading;
  final String? pricing;
  final String? synopsis;
  final String? coverImage;
  final String? purchasePhysical;
  final String? purchaseEbook;
  final String? officialSite;
  final String? socialLink;
  const ComicsBook({
    required this.id,
    required this.comicsId,
    this.type,
    this.publisher,
    this.volumes,
    this.releaseDateTw,
    this.releaseDateJp,
    this.grading,
    this.pricing,
    this.synopsis,
    this.coverImage,
    this.purchasePhysical,
    this.purchaseEbook,
    this.officialSite,
    this.socialLink,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['comics_id'] = Variable<String>(comicsId);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || volumes != null) {
      map['volumes'] = Variable<int>(volumes);
    }
    if (!nullToAbsent || releaseDateTw != null) {
      map['release_date_tw'] = Variable<DateTime>(releaseDateTw);
    }
    if (!nullToAbsent || releaseDateJp != null) {
      map['release_date_jp'] = Variable<DateTime>(releaseDateJp);
    }
    if (!nullToAbsent || grading != null) {
      map['grading'] = Variable<String>(grading);
    }
    if (!nullToAbsent || pricing != null) {
      map['pricing'] = Variable<String>(pricing);
    }
    if (!nullToAbsent || synopsis != null) {
      map['synopsis'] = Variable<String>(synopsis);
    }
    if (!nullToAbsent || coverImage != null) {
      map['cover_image'] = Variable<String>(coverImage);
    }
    if (!nullToAbsent || purchasePhysical != null) {
      map['purchase_physical'] = Variable<String>(purchasePhysical);
    }
    if (!nullToAbsent || purchaseEbook != null) {
      map['purchase_ebook'] = Variable<String>(purchaseEbook);
    }
    if (!nullToAbsent || officialSite != null) {
      map['official_site'] = Variable<String>(officialSite);
    }
    if (!nullToAbsent || socialLink != null) {
      map['social_link'] = Variable<String>(socialLink);
    }
    return map;
  }

  ComicsBooksCompanion toCompanion(bool nullToAbsent) {
    return ComicsBooksCompanion(
      id: Value(id),
      comicsId: Value(comicsId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      publisher:
          publisher == null && nullToAbsent
              ? const Value.absent()
              : Value(publisher),
      volumes:
          volumes == null && nullToAbsent
              ? const Value.absent()
              : Value(volumes),
      releaseDateTw:
          releaseDateTw == null && nullToAbsent
              ? const Value.absent()
              : Value(releaseDateTw),
      releaseDateJp:
          releaseDateJp == null && nullToAbsent
              ? const Value.absent()
              : Value(releaseDateJp),
      grading:
          grading == null && nullToAbsent
              ? const Value.absent()
              : Value(grading),
      pricing:
          pricing == null && nullToAbsent
              ? const Value.absent()
              : Value(pricing),
      synopsis:
          synopsis == null && nullToAbsent
              ? const Value.absent()
              : Value(synopsis),
      coverImage:
          coverImage == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImage),
      purchasePhysical:
          purchasePhysical == null && nullToAbsent
              ? const Value.absent()
              : Value(purchasePhysical),
      purchaseEbook:
          purchaseEbook == null && nullToAbsent
              ? const Value.absent()
              : Value(purchaseEbook),
      officialSite:
          officialSite == null && nullToAbsent
              ? const Value.absent()
              : Value(officialSite),
      socialLink:
          socialLink == null && nullToAbsent
              ? const Value.absent()
              : Value(socialLink),
    );
  }

  factory ComicsBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComicsBook(
      id: serializer.fromJson<int>(json['id']),
      comicsId: serializer.fromJson<String>(json['comicsId']),
      type: serializer.fromJson<String?>(json['type']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      volumes: serializer.fromJson<int?>(json['volumes']),
      releaseDateTw: serializer.fromJson<DateTime?>(json['releaseDateTw']),
      releaseDateJp: serializer.fromJson<DateTime?>(json['releaseDateJp']),
      grading: serializer.fromJson<String?>(json['grading']),
      pricing: serializer.fromJson<String?>(json['pricing']),
      synopsis: serializer.fromJson<String?>(json['synopsis']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      purchasePhysical: serializer.fromJson<String?>(json['purchasePhysical']),
      purchaseEbook: serializer.fromJson<String?>(json['purchaseEbook']),
      officialSite: serializer.fromJson<String?>(json['officialSite']),
      socialLink: serializer.fromJson<String?>(json['socialLink']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'comicsId': serializer.toJson<String>(comicsId),
      'type': serializer.toJson<String?>(type),
      'publisher': serializer.toJson<String?>(publisher),
      'volumes': serializer.toJson<int?>(volumes),
      'releaseDateTw': serializer.toJson<DateTime?>(releaseDateTw),
      'releaseDateJp': serializer.toJson<DateTime?>(releaseDateJp),
      'grading': serializer.toJson<String?>(grading),
      'pricing': serializer.toJson<String?>(pricing),
      'synopsis': serializer.toJson<String?>(synopsis),
      'coverImage': serializer.toJson<String?>(coverImage),
      'purchasePhysical': serializer.toJson<String?>(purchasePhysical),
      'purchaseEbook': serializer.toJson<String?>(purchaseEbook),
      'officialSite': serializer.toJson<String?>(officialSite),
      'socialLink': serializer.toJson<String?>(socialLink),
    };
  }

  ComicsBook copyWith({
    int? id,
    String? comicsId,
    Value<String?> type = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<int?> volumes = const Value.absent(),
    Value<DateTime?> releaseDateTw = const Value.absent(),
    Value<DateTime?> releaseDateJp = const Value.absent(),
    Value<String?> grading = const Value.absent(),
    Value<String?> pricing = const Value.absent(),
    Value<String?> synopsis = const Value.absent(),
    Value<String?> coverImage = const Value.absent(),
    Value<String?> purchasePhysical = const Value.absent(),
    Value<String?> purchaseEbook = const Value.absent(),
    Value<String?> officialSite = const Value.absent(),
    Value<String?> socialLink = const Value.absent(),
  }) => ComicsBook(
    id: id ?? this.id,
    comicsId: comicsId ?? this.comicsId,
    type: type.present ? type.value : this.type,
    publisher: publisher.present ? publisher.value : this.publisher,
    volumes: volumes.present ? volumes.value : this.volumes,
    releaseDateTw:
        releaseDateTw.present ? releaseDateTw.value : this.releaseDateTw,
    releaseDateJp:
        releaseDateJp.present ? releaseDateJp.value : this.releaseDateJp,
    grading: grading.present ? grading.value : this.grading,
    pricing: pricing.present ? pricing.value : this.pricing,
    synopsis: synopsis.present ? synopsis.value : this.synopsis,
    coverImage: coverImage.present ? coverImage.value : this.coverImage,
    purchasePhysical:
        purchasePhysical.present
            ? purchasePhysical.value
            : this.purchasePhysical,
    purchaseEbook:
        purchaseEbook.present ? purchaseEbook.value : this.purchaseEbook,
    officialSite: officialSite.present ? officialSite.value : this.officialSite,
    socialLink: socialLink.present ? socialLink.value : this.socialLink,
  );
  ComicsBook copyWithCompanion(ComicsBooksCompanion data) {
    return ComicsBook(
      id: data.id.present ? data.id.value : this.id,
      comicsId: data.comicsId.present ? data.comicsId.value : this.comicsId,
      type: data.type.present ? data.type.value : this.type,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      volumes: data.volumes.present ? data.volumes.value : this.volumes,
      releaseDateTw:
          data.releaseDateTw.present
              ? data.releaseDateTw.value
              : this.releaseDateTw,
      releaseDateJp:
          data.releaseDateJp.present
              ? data.releaseDateJp.value
              : this.releaseDateJp,
      grading: data.grading.present ? data.grading.value : this.grading,
      pricing: data.pricing.present ? data.pricing.value : this.pricing,
      synopsis: data.synopsis.present ? data.synopsis.value : this.synopsis,
      coverImage:
          data.coverImage.present ? data.coverImage.value : this.coverImage,
      purchasePhysical:
          data.purchasePhysical.present
              ? data.purchasePhysical.value
              : this.purchasePhysical,
      purchaseEbook:
          data.purchaseEbook.present
              ? data.purchaseEbook.value
              : this.purchaseEbook,
      officialSite:
          data.officialSite.present
              ? data.officialSite.value
              : this.officialSite,
      socialLink:
          data.socialLink.present ? data.socialLink.value : this.socialLink,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComicsBook(')
          ..write('id: $id, ')
          ..write('comicsId: $comicsId, ')
          ..write('type: $type, ')
          ..write('publisher: $publisher, ')
          ..write('volumes: $volumes, ')
          ..write('releaseDateTw: $releaseDateTw, ')
          ..write('releaseDateJp: $releaseDateJp, ')
          ..write('grading: $grading, ')
          ..write('pricing: $pricing, ')
          ..write('synopsis: $synopsis, ')
          ..write('coverImage: $coverImage, ')
          ..write('purchasePhysical: $purchasePhysical, ')
          ..write('purchaseEbook: $purchaseEbook, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    comicsId,
    type,
    publisher,
    volumes,
    releaseDateTw,
    releaseDateJp,
    grading,
    pricing,
    synopsis,
    coverImage,
    purchasePhysical,
    purchaseEbook,
    officialSite,
    socialLink,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComicsBook &&
          other.id == this.id &&
          other.comicsId == this.comicsId &&
          other.type == this.type &&
          other.publisher == this.publisher &&
          other.volumes == this.volumes &&
          other.releaseDateTw == this.releaseDateTw &&
          other.releaseDateJp == this.releaseDateJp &&
          other.grading == this.grading &&
          other.pricing == this.pricing &&
          other.synopsis == this.synopsis &&
          other.coverImage == this.coverImage &&
          other.purchasePhysical == this.purchasePhysical &&
          other.purchaseEbook == this.purchaseEbook &&
          other.officialSite == this.officialSite &&
          other.socialLink == this.socialLink);
}

class ComicsBooksCompanion extends UpdateCompanion<ComicsBook> {
  final Value<int> id;
  final Value<String> comicsId;
  final Value<String?> type;
  final Value<String?> publisher;
  final Value<int?> volumes;
  final Value<DateTime?> releaseDateTw;
  final Value<DateTime?> releaseDateJp;
  final Value<String?> grading;
  final Value<String?> pricing;
  final Value<String?> synopsis;
  final Value<String?> coverImage;
  final Value<String?> purchasePhysical;
  final Value<String?> purchaseEbook;
  final Value<String?> officialSite;
  final Value<String?> socialLink;
  const ComicsBooksCompanion({
    this.id = const Value.absent(),
    this.comicsId = const Value.absent(),
    this.type = const Value.absent(),
    this.publisher = const Value.absent(),
    this.volumes = const Value.absent(),
    this.releaseDateTw = const Value.absent(),
    this.releaseDateJp = const Value.absent(),
    this.grading = const Value.absent(),
    this.pricing = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.purchasePhysical = const Value.absent(),
    this.purchaseEbook = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
  });
  ComicsBooksCompanion.insert({
    this.id = const Value.absent(),
    required String comicsId,
    this.type = const Value.absent(),
    this.publisher = const Value.absent(),
    this.volumes = const Value.absent(),
    this.releaseDateTw = const Value.absent(),
    this.releaseDateJp = const Value.absent(),
    this.grading = const Value.absent(),
    this.pricing = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.purchasePhysical = const Value.absent(),
    this.purchaseEbook = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
  }) : comicsId = Value(comicsId);
  static Insertable<ComicsBook> custom({
    Expression<int>? id,
    Expression<String>? comicsId,
    Expression<String>? type,
    Expression<String>? publisher,
    Expression<int>? volumes,
    Expression<DateTime>? releaseDateTw,
    Expression<DateTime>? releaseDateJp,
    Expression<String>? grading,
    Expression<String>? pricing,
    Expression<String>? synopsis,
    Expression<String>? coverImage,
    Expression<String>? purchasePhysical,
    Expression<String>? purchaseEbook,
    Expression<String>? officialSite,
    Expression<String>? socialLink,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (comicsId != null) 'comics_id': comicsId,
      if (type != null) 'type': type,
      if (publisher != null) 'publisher': publisher,
      if (volumes != null) 'volumes': volumes,
      if (releaseDateTw != null) 'release_date_tw': releaseDateTw,
      if (releaseDateJp != null) 'release_date_jp': releaseDateJp,
      if (grading != null) 'grading': grading,
      if (pricing != null) 'pricing': pricing,
      if (synopsis != null) 'synopsis': synopsis,
      if (coverImage != null) 'cover_image': coverImage,
      if (purchasePhysical != null) 'purchase_physical': purchasePhysical,
      if (purchaseEbook != null) 'purchase_ebook': purchaseEbook,
      if (officialSite != null) 'official_site': officialSite,
      if (socialLink != null) 'social_link': socialLink,
    });
  }

  ComicsBooksCompanion copyWith({
    Value<int>? id,
    Value<String>? comicsId,
    Value<String?>? type,
    Value<String?>? publisher,
    Value<int?>? volumes,
    Value<DateTime?>? releaseDateTw,
    Value<DateTime?>? releaseDateJp,
    Value<String?>? grading,
    Value<String?>? pricing,
    Value<String?>? synopsis,
    Value<String?>? coverImage,
    Value<String?>? purchasePhysical,
    Value<String?>? purchaseEbook,
    Value<String?>? officialSite,
    Value<String?>? socialLink,
  }) {
    return ComicsBooksCompanion(
      id: id ?? this.id,
      comicsId: comicsId ?? this.comicsId,
      type: type ?? this.type,
      publisher: publisher ?? this.publisher,
      volumes: volumes ?? this.volumes,
      releaseDateTw: releaseDateTw ?? this.releaseDateTw,
      releaseDateJp: releaseDateJp ?? this.releaseDateJp,
      grading: grading ?? this.grading,
      pricing: pricing ?? this.pricing,
      synopsis: synopsis ?? this.synopsis,
      coverImage: coverImage ?? this.coverImage,
      purchasePhysical: purchasePhysical ?? this.purchasePhysical,
      purchaseEbook: purchaseEbook ?? this.purchaseEbook,
      officialSite: officialSite ?? this.officialSite,
      socialLink: socialLink ?? this.socialLink,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (comicsId.present) {
      map['comics_id'] = Variable<String>(comicsId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (volumes.present) {
      map['volumes'] = Variable<int>(volumes.value);
    }
    if (releaseDateTw.present) {
      map['release_date_tw'] = Variable<DateTime>(releaseDateTw.value);
    }
    if (releaseDateJp.present) {
      map['release_date_jp'] = Variable<DateTime>(releaseDateJp.value);
    }
    if (grading.present) {
      map['grading'] = Variable<String>(grading.value);
    }
    if (pricing.present) {
      map['pricing'] = Variable<String>(pricing.value);
    }
    if (synopsis.present) {
      map['synopsis'] = Variable<String>(synopsis.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (purchasePhysical.present) {
      map['purchase_physical'] = Variable<String>(purchasePhysical.value);
    }
    if (purchaseEbook.present) {
      map['purchase_ebook'] = Variable<String>(purchaseEbook.value);
    }
    if (officialSite.present) {
      map['official_site'] = Variable<String>(officialSite.value);
    }
    if (socialLink.present) {
      map['social_link'] = Variable<String>(socialLink.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComicsBooksCompanion(')
          ..write('id: $id, ')
          ..write('comicsId: $comicsId, ')
          ..write('type: $type, ')
          ..write('publisher: $publisher, ')
          ..write('volumes: $volumes, ')
          ..write('releaseDateTw: $releaseDateTw, ')
          ..write('releaseDateJp: $releaseDateJp, ')
          ..write('grading: $grading, ')
          ..write('pricing: $pricing, ')
          ..write('synopsis: $synopsis, ')
          ..write('coverImage: $coverImage, ')
          ..write('purchasePhysical: $purchasePhysical, ')
          ..write('purchaseEbook: $purchaseEbook, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink')
          ..write(')'))
        .toString();
  }
}

class $NovelsTable extends Novels with TableInfo<$NovelsTable, Novel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleJpMeta = const VerificationMeta(
    'titleJp',
  );
  @override
  late final GeneratedColumn<String> titleJp = GeneratedColumn<String>(
    'title_jp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageLocalMeta = const VerificationMeta(
    'coverImageLocal',
  );
  @override
  late final GeneratedColumn<String> coverImageLocal = GeneratedColumn<String>(
    'cover_image_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageRemoteMeta = const VerificationMeta(
    'coverImageRemote',
  );
  @override
  late final GeneratedColumn<String> coverImageRemote = GeneratedColumn<String>(
    'cover_image_remote',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    version,
    lastUpdate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'novels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Novel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('title_jp')) {
      context.handle(
        _titleJpMeta,
        titleJp.isAcceptableOrUnknown(data['title_jp']!, _titleJpMeta),
      );
    }
    if (data.containsKey('cover_image_local')) {
      context.handle(
        _coverImageLocalMeta,
        coverImageLocal.isAcceptableOrUnknown(
          data['cover_image_local']!,
          _coverImageLocalMeta,
        ),
      );
    }
    if (data.containsKey('cover_image_remote')) {
      context.handle(
        _coverImageRemoteMeta,
        coverImageRemote.isAcceptableOrUnknown(
          data['cover_image_remote']!,
          _coverImageRemoteMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Novel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Novel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      titleJp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_jp'],
      ),
      coverImageLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_local'],
      ),
      coverImageRemote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image_remote'],
      ),
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}version'],
          )!,
      lastUpdate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_update'],
          )!,
    );
  }

  @override
  $NovelsTable createAlias(String alias) {
    return $NovelsTable(attachedDatabase, alias);
  }
}

class Novel extends DataClass implements Insertable<Novel> {
  final String id;
  final String? title;
  final String? titleJp;
  final String? coverImageLocal;
  final String? coverImageRemote;
  final String version;
  final DateTime lastUpdate;
  const Novel({
    required this.id,
    this.title,
    this.titleJp,
    this.coverImageLocal,
    this.coverImageRemote,
    required this.version,
    required this.lastUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || titleJp != null) {
      map['title_jp'] = Variable<String>(titleJp);
    }
    if (!nullToAbsent || coverImageLocal != null) {
      map['cover_image_local'] = Variable<String>(coverImageLocal);
    }
    if (!nullToAbsent || coverImageRemote != null) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote);
    }
    map['version'] = Variable<String>(version);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  NovelsCompanion toCompanion(bool nullToAbsent) {
    return NovelsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      titleJp:
          titleJp == null && nullToAbsent
              ? const Value.absent()
              : Value(titleJp),
      coverImageLocal:
          coverImageLocal == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageLocal),
      coverImageRemote:
          coverImageRemote == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImageRemote),
      version: Value(version),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory Novel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Novel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      titleJp: serializer.fromJson<String?>(json['titleJp']),
      coverImageLocal: serializer.fromJson<String?>(json['coverImageLocal']),
      coverImageRemote: serializer.fromJson<String?>(json['coverImageRemote']),
      version: serializer.fromJson<String>(json['version']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'titleJp': serializer.toJson<String?>(titleJp),
      'coverImageLocal': serializer.toJson<String?>(coverImageLocal),
      'coverImageRemote': serializer.toJson<String?>(coverImageRemote),
      'version': serializer.toJson<String>(version),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  Novel copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    Value<String?> titleJp = const Value.absent(),
    Value<String?> coverImageLocal = const Value.absent(),
    Value<String?> coverImageRemote = const Value.absent(),
    String? version,
    DateTime? lastUpdate,
  }) => Novel(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    titleJp: titleJp.present ? titleJp.value : this.titleJp,
    coverImageLocal:
        coverImageLocal.present ? coverImageLocal.value : this.coverImageLocal,
    coverImageRemote:
        coverImageRemote.present
            ? coverImageRemote.value
            : this.coverImageRemote,
    version: version ?? this.version,
    lastUpdate: lastUpdate ?? this.lastUpdate,
  );
  Novel copyWithCompanion(NovelsCompanion data) {
    return Novel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      titleJp: data.titleJp.present ? data.titleJp.value : this.titleJp,
      coverImageLocal:
          data.coverImageLocal.present
              ? data.coverImageLocal.value
              : this.coverImageLocal,
      coverImageRemote:
          data.coverImageRemote.present
              ? data.coverImageRemote.value
              : this.coverImageRemote,
      version: data.version.present ? data.version.value : this.version,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Novel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    titleJp,
    coverImageLocal,
    coverImageRemote,
    version,
    lastUpdate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Novel &&
          other.id == this.id &&
          other.title == this.title &&
          other.titleJp == this.titleJp &&
          other.coverImageLocal == this.coverImageLocal &&
          other.coverImageRemote == this.coverImageRemote &&
          other.version == this.version &&
          other.lastUpdate == this.lastUpdate);
}

class NovelsCompanion extends UpdateCompanion<Novel> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> titleJp;
  final Value<String?> coverImageLocal;
  final Value<String?> coverImageRemote;
  final Value<String> version;
  final Value<DateTime> lastUpdate;
  final Value<int> rowid;
  const NovelsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    this.version = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NovelsCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.coverImageLocal = const Value.absent(),
    this.coverImageRemote = const Value.absent(),
    required String version,
    required DateTime lastUpdate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       lastUpdate = Value(lastUpdate);
  static Insertable<Novel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? titleJp,
    Expression<String>? coverImageLocal,
    Expression<String>? coverImageRemote,
    Expression<String>? version,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (titleJp != null) 'title_jp': titleJp,
      if (coverImageLocal != null) 'cover_image_local': coverImageLocal,
      if (coverImageRemote != null) 'cover_image_remote': coverImageRemote,
      if (version != null) 'version': version,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NovelsCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String?>? titleJp,
    Value<String?>? coverImageLocal,
    Value<String?>? coverImageRemote,
    Value<String>? version,
    Value<DateTime>? lastUpdate,
    Value<int>? rowid,
  }) {
    return NovelsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      titleJp: titleJp ?? this.titleJp,
      coverImageLocal: coverImageLocal ?? this.coverImageLocal,
      coverImageRemote: coverImageRemote ?? this.coverImageRemote,
      version: version ?? this.version,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleJp.present) {
      map['title_jp'] = Variable<String>(titleJp.value);
    }
    if (coverImageLocal.present) {
      map['cover_image_local'] = Variable<String>(coverImageLocal.value);
    }
    if (coverImageRemote.present) {
      map['cover_image_remote'] = Variable<String>(coverImageRemote.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('coverImageLocal: $coverImageLocal, ')
          ..write('coverImageRemote: $coverImageRemote, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NovelBooksTable extends NovelBooks
    with TableInfo<$NovelBooksTable, NovelBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _novelIdMeta = const VerificationMeta(
    'novelId',
  );
  @override
  late final GeneratedColumn<String> novelId = GeneratedColumn<String>(
    'novel_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _illustratorMeta = const VerificationMeta(
    'illustrator',
  );
  @override
  late final GeneratedColumn<String> illustrator = GeneratedColumn<String>(
    'illustrator',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publishDateTwMeta = const VerificationMeta(
    'publishDateTw',
  );
  @override
  late final GeneratedColumn<DateTime> publishDateTw =
      GeneratedColumn<DateTime>(
        'publish_date_tw',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _publishDateJpMeta = const VerificationMeta(
    'publishDateJp',
  );
  @override
  late final GeneratedColumn<DateTime> publishDateJp =
      GeneratedColumn<DateTime>(
        'publish_date_jp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _gradingMeta = const VerificationMeta(
    'grading',
  );
  @override
  late final GeneratedColumn<String> grading = GeneratedColumn<String>(
    'grading',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricingMeta = const VerificationMeta(
    'pricing',
  );
  @override
  late final GeneratedColumn<String> pricing = GeneratedColumn<String>(
    'pricing',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _synopsisMeta = const VerificationMeta(
    'synopsis',
  );
  @override
  late final GeneratedColumn<String> synopsis = GeneratedColumn<String>(
    'synopsis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverImageMeta = const VerificationMeta(
    'coverImage',
  );
  @override
  late final GeneratedColumn<String> coverImage = GeneratedColumn<String>(
    'cover_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePhysicalMeta = const VerificationMeta(
    'purchasePhysical',
  );
  @override
  late final GeneratedColumn<String> purchasePhysical = GeneratedColumn<String>(
    'purchase_physical',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseEbookMeta = const VerificationMeta(
    'purchaseEbook',
  );
  @override
  late final GeneratedColumn<String> purchaseEbook = GeneratedColumn<String>(
    'purchase_ebook',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _officialSiteMeta = const VerificationMeta(
    'officialSite',
  );
  @override
  late final GeneratedColumn<String> officialSite = GeneratedColumn<String>(
    'official_site',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _socialLinkMeta = const VerificationMeta(
    'socialLink',
  );
  @override
  late final GeneratedColumn<String> socialLink = GeneratedColumn<String>(
    'social_link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    novelId,
    type,
    author,
    illustrator,
    publishDateTw,
    publishDateJp,
    grading,
    pricing,
    synopsis,
    coverImage,
    publisher,
    purchasePhysical,
    purchaseEbook,
    officialSite,
    socialLink,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'novel_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<NovelBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('novel_id')) {
      context.handle(
        _novelIdMeta,
        novelId.isAcceptableOrUnknown(data['novel_id']!, _novelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_novelIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('illustrator')) {
      context.handle(
        _illustratorMeta,
        illustrator.isAcceptableOrUnknown(
          data['illustrator']!,
          _illustratorMeta,
        ),
      );
    }
    if (data.containsKey('publish_date_tw')) {
      context.handle(
        _publishDateTwMeta,
        publishDateTw.isAcceptableOrUnknown(
          data['publish_date_tw']!,
          _publishDateTwMeta,
        ),
      );
    }
    if (data.containsKey('publish_date_jp')) {
      context.handle(
        _publishDateJpMeta,
        publishDateJp.isAcceptableOrUnknown(
          data['publish_date_jp']!,
          _publishDateJpMeta,
        ),
      );
    }
    if (data.containsKey('grading')) {
      context.handle(
        _gradingMeta,
        grading.isAcceptableOrUnknown(data['grading']!, _gradingMeta),
      );
    }
    if (data.containsKey('pricing')) {
      context.handle(
        _pricingMeta,
        pricing.isAcceptableOrUnknown(data['pricing']!, _pricingMeta),
      );
    }
    if (data.containsKey('synopsis')) {
      context.handle(
        _synopsisMeta,
        synopsis.isAcceptableOrUnknown(data['synopsis']!, _synopsisMeta),
      );
    }
    if (data.containsKey('cover_image')) {
      context.handle(
        _coverImageMeta,
        coverImage.isAcceptableOrUnknown(data['cover_image']!, _coverImageMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('purchase_physical')) {
      context.handle(
        _purchasePhysicalMeta,
        purchasePhysical.isAcceptableOrUnknown(
          data['purchase_physical']!,
          _purchasePhysicalMeta,
        ),
      );
    }
    if (data.containsKey('purchase_ebook')) {
      context.handle(
        _purchaseEbookMeta,
        purchaseEbook.isAcceptableOrUnknown(
          data['purchase_ebook']!,
          _purchaseEbookMeta,
        ),
      );
    }
    if (data.containsKey('official_site')) {
      context.handle(
        _officialSiteMeta,
        officialSite.isAcceptableOrUnknown(
          data['official_site']!,
          _officialSiteMeta,
        ),
      );
    }
    if (data.containsKey('social_link')) {
      context.handle(
        _socialLinkMeta,
        socialLink.isAcceptableOrUnknown(data['social_link']!, _socialLinkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NovelBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NovelBook(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      novelId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}novel_id'],
          )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      illustrator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}illustrator'],
      ),
      publishDateTw: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}publish_date_tw'],
      ),
      publishDateJp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}publish_date_jp'],
      ),
      grading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grading'],
      ),
      pricing: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pricing'],
      ),
      synopsis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synopsis'],
      ),
      coverImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_image'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      purchasePhysical: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_physical'],
      ),
      purchaseEbook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_ebook'],
      ),
      officialSite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}official_site'],
      ),
      socialLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}social_link'],
      ),
    );
  }

  @override
  $NovelBooksTable createAlias(String alias) {
    return $NovelBooksTable(attachedDatabase, alias);
  }
}

class NovelBook extends DataClass implements Insertable<NovelBook> {
  final int id;
  final String novelId;
  final String? type;
  final String? author;
  final String? illustrator;
  final DateTime? publishDateTw;
  final DateTime? publishDateJp;
  final String? grading;
  final String? pricing;
  final String? synopsis;
  final String? coverImage;
  final String? publisher;
  final String? purchasePhysical;
  final String? purchaseEbook;
  final String? officialSite;
  final String? socialLink;
  const NovelBook({
    required this.id,
    required this.novelId,
    this.type,
    this.author,
    this.illustrator,
    this.publishDateTw,
    this.publishDateJp,
    this.grading,
    this.pricing,
    this.synopsis,
    this.coverImage,
    this.publisher,
    this.purchasePhysical,
    this.purchaseEbook,
    this.officialSite,
    this.socialLink,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['novel_id'] = Variable<String>(novelId);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || illustrator != null) {
      map['illustrator'] = Variable<String>(illustrator);
    }
    if (!nullToAbsent || publishDateTw != null) {
      map['publish_date_tw'] = Variable<DateTime>(publishDateTw);
    }
    if (!nullToAbsent || publishDateJp != null) {
      map['publish_date_jp'] = Variable<DateTime>(publishDateJp);
    }
    if (!nullToAbsent || grading != null) {
      map['grading'] = Variable<String>(grading);
    }
    if (!nullToAbsent || pricing != null) {
      map['pricing'] = Variable<String>(pricing);
    }
    if (!nullToAbsent || synopsis != null) {
      map['synopsis'] = Variable<String>(synopsis);
    }
    if (!nullToAbsent || coverImage != null) {
      map['cover_image'] = Variable<String>(coverImage);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    if (!nullToAbsent || purchasePhysical != null) {
      map['purchase_physical'] = Variable<String>(purchasePhysical);
    }
    if (!nullToAbsent || purchaseEbook != null) {
      map['purchase_ebook'] = Variable<String>(purchaseEbook);
    }
    if (!nullToAbsent || officialSite != null) {
      map['official_site'] = Variable<String>(officialSite);
    }
    if (!nullToAbsent || socialLink != null) {
      map['social_link'] = Variable<String>(socialLink);
    }
    return map;
  }

  NovelBooksCompanion toCompanion(bool nullToAbsent) {
    return NovelBooksCompanion(
      id: Value(id),
      novelId: Value(novelId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      illustrator:
          illustrator == null && nullToAbsent
              ? const Value.absent()
              : Value(illustrator),
      publishDateTw:
          publishDateTw == null && nullToAbsent
              ? const Value.absent()
              : Value(publishDateTw),
      publishDateJp:
          publishDateJp == null && nullToAbsent
              ? const Value.absent()
              : Value(publishDateJp),
      grading:
          grading == null && nullToAbsent
              ? const Value.absent()
              : Value(grading),
      pricing:
          pricing == null && nullToAbsent
              ? const Value.absent()
              : Value(pricing),
      synopsis:
          synopsis == null && nullToAbsent
              ? const Value.absent()
              : Value(synopsis),
      coverImage:
          coverImage == null && nullToAbsent
              ? const Value.absent()
              : Value(coverImage),
      publisher:
          publisher == null && nullToAbsent
              ? const Value.absent()
              : Value(publisher),
      purchasePhysical:
          purchasePhysical == null && nullToAbsent
              ? const Value.absent()
              : Value(purchasePhysical),
      purchaseEbook:
          purchaseEbook == null && nullToAbsent
              ? const Value.absent()
              : Value(purchaseEbook),
      officialSite:
          officialSite == null && nullToAbsent
              ? const Value.absent()
              : Value(officialSite),
      socialLink:
          socialLink == null && nullToAbsent
              ? const Value.absent()
              : Value(socialLink),
    );
  }

  factory NovelBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NovelBook(
      id: serializer.fromJson<int>(json['id']),
      novelId: serializer.fromJson<String>(json['novelId']),
      type: serializer.fromJson<String?>(json['type']),
      author: serializer.fromJson<String?>(json['author']),
      illustrator: serializer.fromJson<String?>(json['illustrator']),
      publishDateTw: serializer.fromJson<DateTime?>(json['publishDateTw']),
      publishDateJp: serializer.fromJson<DateTime?>(json['publishDateJp']),
      grading: serializer.fromJson<String?>(json['grading']),
      pricing: serializer.fromJson<String?>(json['pricing']),
      synopsis: serializer.fromJson<String?>(json['synopsis']),
      coverImage: serializer.fromJson<String?>(json['coverImage']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      purchasePhysical: serializer.fromJson<String?>(json['purchasePhysical']),
      purchaseEbook: serializer.fromJson<String?>(json['purchaseEbook']),
      officialSite: serializer.fromJson<String?>(json['officialSite']),
      socialLink: serializer.fromJson<String?>(json['socialLink']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'novelId': serializer.toJson<String>(novelId),
      'type': serializer.toJson<String?>(type),
      'author': serializer.toJson<String?>(author),
      'illustrator': serializer.toJson<String?>(illustrator),
      'publishDateTw': serializer.toJson<DateTime?>(publishDateTw),
      'publishDateJp': serializer.toJson<DateTime?>(publishDateJp),
      'grading': serializer.toJson<String?>(grading),
      'pricing': serializer.toJson<String?>(pricing),
      'synopsis': serializer.toJson<String?>(synopsis),
      'coverImage': serializer.toJson<String?>(coverImage),
      'publisher': serializer.toJson<String?>(publisher),
      'purchasePhysical': serializer.toJson<String?>(purchasePhysical),
      'purchaseEbook': serializer.toJson<String?>(purchaseEbook),
      'officialSite': serializer.toJson<String?>(officialSite),
      'socialLink': serializer.toJson<String?>(socialLink),
    };
  }

  NovelBook copyWith({
    int? id,
    String? novelId,
    Value<String?> type = const Value.absent(),
    Value<String?> author = const Value.absent(),
    Value<String?> illustrator = const Value.absent(),
    Value<DateTime?> publishDateTw = const Value.absent(),
    Value<DateTime?> publishDateJp = const Value.absent(),
    Value<String?> grading = const Value.absent(),
    Value<String?> pricing = const Value.absent(),
    Value<String?> synopsis = const Value.absent(),
    Value<String?> coverImage = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    Value<String?> purchasePhysical = const Value.absent(),
    Value<String?> purchaseEbook = const Value.absent(),
    Value<String?> officialSite = const Value.absent(),
    Value<String?> socialLink = const Value.absent(),
  }) => NovelBook(
    id: id ?? this.id,
    novelId: novelId ?? this.novelId,
    type: type.present ? type.value : this.type,
    author: author.present ? author.value : this.author,
    illustrator: illustrator.present ? illustrator.value : this.illustrator,
    publishDateTw:
        publishDateTw.present ? publishDateTw.value : this.publishDateTw,
    publishDateJp:
        publishDateJp.present ? publishDateJp.value : this.publishDateJp,
    grading: grading.present ? grading.value : this.grading,
    pricing: pricing.present ? pricing.value : this.pricing,
    synopsis: synopsis.present ? synopsis.value : this.synopsis,
    coverImage: coverImage.present ? coverImage.value : this.coverImage,
    publisher: publisher.present ? publisher.value : this.publisher,
    purchasePhysical:
        purchasePhysical.present
            ? purchasePhysical.value
            : this.purchasePhysical,
    purchaseEbook:
        purchaseEbook.present ? purchaseEbook.value : this.purchaseEbook,
    officialSite: officialSite.present ? officialSite.value : this.officialSite,
    socialLink: socialLink.present ? socialLink.value : this.socialLink,
  );
  NovelBook copyWithCompanion(NovelBooksCompanion data) {
    return NovelBook(
      id: data.id.present ? data.id.value : this.id,
      novelId: data.novelId.present ? data.novelId.value : this.novelId,
      type: data.type.present ? data.type.value : this.type,
      author: data.author.present ? data.author.value : this.author,
      illustrator:
          data.illustrator.present ? data.illustrator.value : this.illustrator,
      publishDateTw:
          data.publishDateTw.present
              ? data.publishDateTw.value
              : this.publishDateTw,
      publishDateJp:
          data.publishDateJp.present
              ? data.publishDateJp.value
              : this.publishDateJp,
      grading: data.grading.present ? data.grading.value : this.grading,
      pricing: data.pricing.present ? data.pricing.value : this.pricing,
      synopsis: data.synopsis.present ? data.synopsis.value : this.synopsis,
      coverImage:
          data.coverImage.present ? data.coverImage.value : this.coverImage,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      purchasePhysical:
          data.purchasePhysical.present
              ? data.purchasePhysical.value
              : this.purchasePhysical,
      purchaseEbook:
          data.purchaseEbook.present
              ? data.purchaseEbook.value
              : this.purchaseEbook,
      officialSite:
          data.officialSite.present
              ? data.officialSite.value
              : this.officialSite,
      socialLink:
          data.socialLink.present ? data.socialLink.value : this.socialLink,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NovelBook(')
          ..write('id: $id, ')
          ..write('novelId: $novelId, ')
          ..write('type: $type, ')
          ..write('author: $author, ')
          ..write('illustrator: $illustrator, ')
          ..write('publishDateTw: $publishDateTw, ')
          ..write('publishDateJp: $publishDateJp, ')
          ..write('grading: $grading, ')
          ..write('pricing: $pricing, ')
          ..write('synopsis: $synopsis, ')
          ..write('coverImage: $coverImage, ')
          ..write('publisher: $publisher, ')
          ..write('purchasePhysical: $purchasePhysical, ')
          ..write('purchaseEbook: $purchaseEbook, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    novelId,
    type,
    author,
    illustrator,
    publishDateTw,
    publishDateJp,
    grading,
    pricing,
    synopsis,
    coverImage,
    publisher,
    purchasePhysical,
    purchaseEbook,
    officialSite,
    socialLink,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NovelBook &&
          other.id == this.id &&
          other.novelId == this.novelId &&
          other.type == this.type &&
          other.author == this.author &&
          other.illustrator == this.illustrator &&
          other.publishDateTw == this.publishDateTw &&
          other.publishDateJp == this.publishDateJp &&
          other.grading == this.grading &&
          other.pricing == this.pricing &&
          other.synopsis == this.synopsis &&
          other.coverImage == this.coverImage &&
          other.publisher == this.publisher &&
          other.purchasePhysical == this.purchasePhysical &&
          other.purchaseEbook == this.purchaseEbook &&
          other.officialSite == this.officialSite &&
          other.socialLink == this.socialLink);
}

class NovelBooksCompanion extends UpdateCompanion<NovelBook> {
  final Value<int> id;
  final Value<String> novelId;
  final Value<String?> type;
  final Value<String?> author;
  final Value<String?> illustrator;
  final Value<DateTime?> publishDateTw;
  final Value<DateTime?> publishDateJp;
  final Value<String?> grading;
  final Value<String?> pricing;
  final Value<String?> synopsis;
  final Value<String?> coverImage;
  final Value<String?> publisher;
  final Value<String?> purchasePhysical;
  final Value<String?> purchaseEbook;
  final Value<String?> officialSite;
  final Value<String?> socialLink;
  const NovelBooksCompanion({
    this.id = const Value.absent(),
    this.novelId = const Value.absent(),
    this.type = const Value.absent(),
    this.author = const Value.absent(),
    this.illustrator = const Value.absent(),
    this.publishDateTw = const Value.absent(),
    this.publishDateJp = const Value.absent(),
    this.grading = const Value.absent(),
    this.pricing = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.publisher = const Value.absent(),
    this.purchasePhysical = const Value.absent(),
    this.purchaseEbook = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
  });
  NovelBooksCompanion.insert({
    this.id = const Value.absent(),
    required String novelId,
    this.type = const Value.absent(),
    this.author = const Value.absent(),
    this.illustrator = const Value.absent(),
    this.publishDateTw = const Value.absent(),
    this.publishDateJp = const Value.absent(),
    this.grading = const Value.absent(),
    this.pricing = const Value.absent(),
    this.synopsis = const Value.absent(),
    this.coverImage = const Value.absent(),
    this.publisher = const Value.absent(),
    this.purchasePhysical = const Value.absent(),
    this.purchaseEbook = const Value.absent(),
    this.officialSite = const Value.absent(),
    this.socialLink = const Value.absent(),
  }) : novelId = Value(novelId);
  static Insertable<NovelBook> custom({
    Expression<int>? id,
    Expression<String>? novelId,
    Expression<String>? type,
    Expression<String>? author,
    Expression<String>? illustrator,
    Expression<DateTime>? publishDateTw,
    Expression<DateTime>? publishDateJp,
    Expression<String>? grading,
    Expression<String>? pricing,
    Expression<String>? synopsis,
    Expression<String>? coverImage,
    Expression<String>? publisher,
    Expression<String>? purchasePhysical,
    Expression<String>? purchaseEbook,
    Expression<String>? officialSite,
    Expression<String>? socialLink,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (novelId != null) 'novel_id': novelId,
      if (type != null) 'type': type,
      if (author != null) 'author': author,
      if (illustrator != null) 'illustrator': illustrator,
      if (publishDateTw != null) 'publish_date_tw': publishDateTw,
      if (publishDateJp != null) 'publish_date_jp': publishDateJp,
      if (grading != null) 'grading': grading,
      if (pricing != null) 'pricing': pricing,
      if (synopsis != null) 'synopsis': synopsis,
      if (coverImage != null) 'cover_image': coverImage,
      if (publisher != null) 'publisher': publisher,
      if (purchasePhysical != null) 'purchase_physical': purchasePhysical,
      if (purchaseEbook != null) 'purchase_ebook': purchaseEbook,
      if (officialSite != null) 'official_site': officialSite,
      if (socialLink != null) 'social_link': socialLink,
    });
  }

  NovelBooksCompanion copyWith({
    Value<int>? id,
    Value<String>? novelId,
    Value<String?>? type,
    Value<String?>? author,
    Value<String?>? illustrator,
    Value<DateTime?>? publishDateTw,
    Value<DateTime?>? publishDateJp,
    Value<String?>? grading,
    Value<String?>? pricing,
    Value<String?>? synopsis,
    Value<String?>? coverImage,
    Value<String?>? publisher,
    Value<String?>? purchasePhysical,
    Value<String?>? purchaseEbook,
    Value<String?>? officialSite,
    Value<String?>? socialLink,
  }) {
    return NovelBooksCompanion(
      id: id ?? this.id,
      novelId: novelId ?? this.novelId,
      type: type ?? this.type,
      author: author ?? this.author,
      illustrator: illustrator ?? this.illustrator,
      publishDateTw: publishDateTw ?? this.publishDateTw,
      publishDateJp: publishDateJp ?? this.publishDateJp,
      grading: grading ?? this.grading,
      pricing: pricing ?? this.pricing,
      synopsis: synopsis ?? this.synopsis,
      coverImage: coverImage ?? this.coverImage,
      publisher: publisher ?? this.publisher,
      purchasePhysical: purchasePhysical ?? this.purchasePhysical,
      purchaseEbook: purchaseEbook ?? this.purchaseEbook,
      officialSite: officialSite ?? this.officialSite,
      socialLink: socialLink ?? this.socialLink,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (novelId.present) {
      map['novel_id'] = Variable<String>(novelId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (illustrator.present) {
      map['illustrator'] = Variable<String>(illustrator.value);
    }
    if (publishDateTw.present) {
      map['publish_date_tw'] = Variable<DateTime>(publishDateTw.value);
    }
    if (publishDateJp.present) {
      map['publish_date_jp'] = Variable<DateTime>(publishDateJp.value);
    }
    if (grading.present) {
      map['grading'] = Variable<String>(grading.value);
    }
    if (pricing.present) {
      map['pricing'] = Variable<String>(pricing.value);
    }
    if (synopsis.present) {
      map['synopsis'] = Variable<String>(synopsis.value);
    }
    if (coverImage.present) {
      map['cover_image'] = Variable<String>(coverImage.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (purchasePhysical.present) {
      map['purchase_physical'] = Variable<String>(purchasePhysical.value);
    }
    if (purchaseEbook.present) {
      map['purchase_ebook'] = Variable<String>(purchaseEbook.value);
    }
    if (officialSite.present) {
      map['official_site'] = Variable<String>(officialSite.value);
    }
    if (socialLink.present) {
      map['social_link'] = Variable<String>(socialLink.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelBooksCompanion(')
          ..write('id: $id, ')
          ..write('novelId: $novelId, ')
          ..write('type: $type, ')
          ..write('author: $author, ')
          ..write('illustrator: $illustrator, ')
          ..write('publishDateTw: $publishDateTw, ')
          ..write('publishDateJp: $publishDateJp, ')
          ..write('grading: $grading, ')
          ..write('pricing: $pricing, ')
          ..write('synopsis: $synopsis, ')
          ..write('coverImage: $coverImage, ')
          ..write('publisher: $publisher, ')
          ..write('purchasePhysical: $purchasePhysical, ')
          ..write('purchaseEbook: $purchaseEbook, ')
          ..write('officialSite: $officialSite, ')
          ..write('socialLink: $socialLink')
          ..write(')'))
        .toString();
  }
}

class $WorksTable extends Works with TableInfo<$WorksTable, Work> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleJpMeta = const VerificationMeta(
    'titleJp',
  );
  @override
  late final GeneratedColumn<String> titleJp = GeneratedColumn<String>(
    'title_jp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryTagsMeta = const VerificationMeta(
    'categoryTags',
  );
  @override
  late final GeneratedColumn<String> categoryTags = GeneratedColumn<String>(
    'category_tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _introductionMeta = const VerificationMeta(
    'introduction',
  );
  @override
  late final GeneratedColumn<String> introduction = GeneratedColumn<String>(
    'introduction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newsMeta = const VerificationMeta('news');
  @override
  late final GeneratedColumn<String> news = GeneratedColumn<String>(
    'news',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _animeListMeta = const VerificationMeta(
    'animeList',
  );
  @override
  late final GeneratedColumn<String> animeList = GeneratedColumn<String>(
    'anime_list',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _novelListMeta = const VerificationMeta(
    'novelList',
  );
  @override
  late final GeneratedColumn<String> novelList = GeneratedColumn<String>(
    'novel_list',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _comicsListMeta = const VerificationMeta(
    'comicsList',
  );
  @override
  late final GeneratedColumn<String> comicsList = GeneratedColumn<String>(
    'comics_list',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _othersListMeta = const VerificationMeta(
    'othersList',
  );
  @override
  late final GeneratedColumn<String> othersList = GeneratedColumn<String>(
    'others_list',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    titleJp,
    categoryTags,
    introduction,
    news,
    animeList,
    novelList,
    comicsList,
    othersList,
    version,
    lastUpdate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'works';
  @override
  VerificationContext validateIntegrity(
    Insertable<Work> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('title_jp')) {
      context.handle(
        _titleJpMeta,
        titleJp.isAcceptableOrUnknown(data['title_jp']!, _titleJpMeta),
      );
    }
    if (data.containsKey('category_tags')) {
      context.handle(
        _categoryTagsMeta,
        categoryTags.isAcceptableOrUnknown(
          data['category_tags']!,
          _categoryTagsMeta,
        ),
      );
    }
    if (data.containsKey('introduction')) {
      context.handle(
        _introductionMeta,
        introduction.isAcceptableOrUnknown(
          data['introduction']!,
          _introductionMeta,
        ),
      );
    }
    if (data.containsKey('news')) {
      context.handle(
        _newsMeta,
        news.isAcceptableOrUnknown(data['news']!, _newsMeta),
      );
    }
    if (data.containsKey('anime_list')) {
      context.handle(
        _animeListMeta,
        animeList.isAcceptableOrUnknown(data['anime_list']!, _animeListMeta),
      );
    }
    if (data.containsKey('novel_list')) {
      context.handle(
        _novelListMeta,
        novelList.isAcceptableOrUnknown(data['novel_list']!, _novelListMeta),
      );
    }
    if (data.containsKey('comics_list')) {
      context.handle(
        _comicsListMeta,
        comicsList.isAcceptableOrUnknown(data['comics_list']!, _comicsListMeta),
      );
    }
    if (data.containsKey('others_list')) {
      context.handle(
        _othersListMeta,
        othersList.isAcceptableOrUnknown(data['others_list']!, _othersListMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Work map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Work(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      titleJp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_jp'],
      ),
      categoryTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_tags'],
      ),
      introduction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}introduction'],
      ),
      news: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}news'],
      ),
      animeList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anime_list'],
      ),
      novelList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}novel_list'],
      ),
      comicsList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comics_list'],
      ),
      othersList: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}others_list'],
      ),
      version:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}version'],
          )!,
      lastUpdate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_update'],
          )!,
    );
  }

  @override
  $WorksTable createAlias(String alias) {
    return $WorksTable(attachedDatabase, alias);
  }
}

class Work extends DataClass implements Insertable<Work> {
  final String id;
  final String? title;
  final String? titleJp;
  final String? categoryTags;
  final String? introduction;
  final String? news;
  final String? animeList;
  final String? novelList;
  final String? comicsList;
  final String? othersList;
  final String version;
  final DateTime lastUpdate;
  const Work({
    required this.id,
    this.title,
    this.titleJp,
    this.categoryTags,
    this.introduction,
    this.news,
    this.animeList,
    this.novelList,
    this.comicsList,
    this.othersList,
    required this.version,
    required this.lastUpdate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || titleJp != null) {
      map['title_jp'] = Variable<String>(titleJp);
    }
    if (!nullToAbsent || categoryTags != null) {
      map['category_tags'] = Variable<String>(categoryTags);
    }
    if (!nullToAbsent || introduction != null) {
      map['introduction'] = Variable<String>(introduction);
    }
    if (!nullToAbsent || news != null) {
      map['news'] = Variable<String>(news);
    }
    if (!nullToAbsent || animeList != null) {
      map['anime_list'] = Variable<String>(animeList);
    }
    if (!nullToAbsent || novelList != null) {
      map['novel_list'] = Variable<String>(novelList);
    }
    if (!nullToAbsent || comicsList != null) {
      map['comics_list'] = Variable<String>(comicsList);
    }
    if (!nullToAbsent || othersList != null) {
      map['others_list'] = Variable<String>(othersList);
    }
    map['version'] = Variable<String>(version);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  WorksCompanion toCompanion(bool nullToAbsent) {
    return WorksCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      titleJp:
          titleJp == null && nullToAbsent
              ? const Value.absent()
              : Value(titleJp),
      categoryTags:
          categoryTags == null && nullToAbsent
              ? const Value.absent()
              : Value(categoryTags),
      introduction:
          introduction == null && nullToAbsent
              ? const Value.absent()
              : Value(introduction),
      news: news == null && nullToAbsent ? const Value.absent() : Value(news),
      animeList:
          animeList == null && nullToAbsent
              ? const Value.absent()
              : Value(animeList),
      novelList:
          novelList == null && nullToAbsent
              ? const Value.absent()
              : Value(novelList),
      comicsList:
          comicsList == null && nullToAbsent
              ? const Value.absent()
              : Value(comicsList),
      othersList:
          othersList == null && nullToAbsent
              ? const Value.absent()
              : Value(othersList),
      version: Value(version),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory Work.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Work(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      titleJp: serializer.fromJson<String?>(json['titleJp']),
      categoryTags: serializer.fromJson<String?>(json['categoryTags']),
      introduction: serializer.fromJson<String?>(json['introduction']),
      news: serializer.fromJson<String?>(json['news']),
      animeList: serializer.fromJson<String?>(json['animeList']),
      novelList: serializer.fromJson<String?>(json['novelList']),
      comicsList: serializer.fromJson<String?>(json['comicsList']),
      othersList: serializer.fromJson<String?>(json['othersList']),
      version: serializer.fromJson<String>(json['version']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'titleJp': serializer.toJson<String?>(titleJp),
      'categoryTags': serializer.toJson<String?>(categoryTags),
      'introduction': serializer.toJson<String?>(introduction),
      'news': serializer.toJson<String?>(news),
      'animeList': serializer.toJson<String?>(animeList),
      'novelList': serializer.toJson<String?>(novelList),
      'comicsList': serializer.toJson<String?>(comicsList),
      'othersList': serializer.toJson<String?>(othersList),
      'version': serializer.toJson<String>(version),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  Work copyWith({
    String? id,
    Value<String?> title = const Value.absent(),
    Value<String?> titleJp = const Value.absent(),
    Value<String?> categoryTags = const Value.absent(),
    Value<String?> introduction = const Value.absent(),
    Value<String?> news = const Value.absent(),
    Value<String?> animeList = const Value.absent(),
    Value<String?> novelList = const Value.absent(),
    Value<String?> comicsList = const Value.absent(),
    Value<String?> othersList = const Value.absent(),
    String? version,
    DateTime? lastUpdate,
  }) => Work(
    id: id ?? this.id,
    title: title.present ? title.value : this.title,
    titleJp: titleJp.present ? titleJp.value : this.titleJp,
    categoryTags: categoryTags.present ? categoryTags.value : this.categoryTags,
    introduction: introduction.present ? introduction.value : this.introduction,
    news: news.present ? news.value : this.news,
    animeList: animeList.present ? animeList.value : this.animeList,
    novelList: novelList.present ? novelList.value : this.novelList,
    comicsList: comicsList.present ? comicsList.value : this.comicsList,
    othersList: othersList.present ? othersList.value : this.othersList,
    version: version ?? this.version,
    lastUpdate: lastUpdate ?? this.lastUpdate,
  );
  Work copyWithCompanion(WorksCompanion data) {
    return Work(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      titleJp: data.titleJp.present ? data.titleJp.value : this.titleJp,
      categoryTags:
          data.categoryTags.present
              ? data.categoryTags.value
              : this.categoryTags,
      introduction:
          data.introduction.present
              ? data.introduction.value
              : this.introduction,
      news: data.news.present ? data.news.value : this.news,
      animeList: data.animeList.present ? data.animeList.value : this.animeList,
      novelList: data.novelList.present ? data.novelList.value : this.novelList,
      comicsList:
          data.comicsList.present ? data.comicsList.value : this.comicsList,
      othersList:
          data.othersList.present ? data.othersList.value : this.othersList,
      version: data.version.present ? data.version.value : this.version,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Work(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('categoryTags: $categoryTags, ')
          ..write('introduction: $introduction, ')
          ..write('news: $news, ')
          ..write('animeList: $animeList, ')
          ..write('novelList: $novelList, ')
          ..write('comicsList: $comicsList, ')
          ..write('othersList: $othersList, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    titleJp,
    categoryTags,
    introduction,
    news,
    animeList,
    novelList,
    comicsList,
    othersList,
    version,
    lastUpdate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Work &&
          other.id == this.id &&
          other.title == this.title &&
          other.titleJp == this.titleJp &&
          other.categoryTags == this.categoryTags &&
          other.introduction == this.introduction &&
          other.news == this.news &&
          other.animeList == this.animeList &&
          other.novelList == this.novelList &&
          other.comicsList == this.comicsList &&
          other.othersList == this.othersList &&
          other.version == this.version &&
          other.lastUpdate == this.lastUpdate);
}

class WorksCompanion extends UpdateCompanion<Work> {
  final Value<String> id;
  final Value<String?> title;
  final Value<String?> titleJp;
  final Value<String?> categoryTags;
  final Value<String?> introduction;
  final Value<String?> news;
  final Value<String?> animeList;
  final Value<String?> novelList;
  final Value<String?> comicsList;
  final Value<String?> othersList;
  final Value<String> version;
  final Value<DateTime> lastUpdate;
  final Value<int> rowid;
  const WorksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.categoryTags = const Value.absent(),
    this.introduction = const Value.absent(),
    this.news = const Value.absent(),
    this.animeList = const Value.absent(),
    this.novelList = const Value.absent(),
    this.comicsList = const Value.absent(),
    this.othersList = const Value.absent(),
    this.version = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorksCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.titleJp = const Value.absent(),
    this.categoryTags = const Value.absent(),
    this.introduction = const Value.absent(),
    this.news = const Value.absent(),
    this.animeList = const Value.absent(),
    this.novelList = const Value.absent(),
    this.comicsList = const Value.absent(),
    this.othersList = const Value.absent(),
    required String version,
    required DateTime lastUpdate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       version = Value(version),
       lastUpdate = Value(lastUpdate);
  static Insertable<Work> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? titleJp,
    Expression<String>? categoryTags,
    Expression<String>? introduction,
    Expression<String>? news,
    Expression<String>? animeList,
    Expression<String>? novelList,
    Expression<String>? comicsList,
    Expression<String>? othersList,
    Expression<String>? version,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (titleJp != null) 'title_jp': titleJp,
      if (categoryTags != null) 'category_tags': categoryTags,
      if (introduction != null) 'introduction': introduction,
      if (news != null) 'news': news,
      if (animeList != null) 'anime_list': animeList,
      if (novelList != null) 'novel_list': novelList,
      if (comicsList != null) 'comics_list': comicsList,
      if (othersList != null) 'others_list': othersList,
      if (version != null) 'version': version,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorksCompanion copyWith({
    Value<String>? id,
    Value<String?>? title,
    Value<String?>? titleJp,
    Value<String?>? categoryTags,
    Value<String?>? introduction,
    Value<String?>? news,
    Value<String?>? animeList,
    Value<String?>? novelList,
    Value<String?>? comicsList,
    Value<String?>? othersList,
    Value<String>? version,
    Value<DateTime>? lastUpdate,
    Value<int>? rowid,
  }) {
    return WorksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      titleJp: titleJp ?? this.titleJp,
      categoryTags: categoryTags ?? this.categoryTags,
      introduction: introduction ?? this.introduction,
      news: news ?? this.news,
      animeList: animeList ?? this.animeList,
      novelList: novelList ?? this.novelList,
      comicsList: comicsList ?? this.comicsList,
      othersList: othersList ?? this.othersList,
      version: version ?? this.version,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleJp.present) {
      map['title_jp'] = Variable<String>(titleJp.value);
    }
    if (categoryTags.present) {
      map['category_tags'] = Variable<String>(categoryTags.value);
    }
    if (introduction.present) {
      map['introduction'] = Variable<String>(introduction.value);
    }
    if (news.present) {
      map['news'] = Variable<String>(news.value);
    }
    if (animeList.present) {
      map['anime_list'] = Variable<String>(animeList.value);
    }
    if (novelList.present) {
      map['novel_list'] = Variable<String>(novelList.value);
    }
    if (comicsList.present) {
      map['comics_list'] = Variable<String>(comicsList.value);
    }
    if (othersList.present) {
      map['others_list'] = Variable<String>(othersList.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleJp: $titleJp, ')
          ..write('categoryTags: $categoryTags, ')
          ..write('introduction: $introduction, ')
          ..write('news: $news, ')
          ..write('animeList: $animeList, ')
          ..write('novelList: $novelList, ')
          ..write('comicsList: $comicsList, ')
          ..write('othersList: $othersList, ')
          ..write('version: $version, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$WorkDatabase extends GeneratedDatabase {
  _$WorkDatabase(QueryExecutor e) : super(e);
  $WorkDatabaseManager get managers => $WorkDatabaseManager(this);
  late final $AnimeTable anime = $AnimeTable(this);
  late final $SeasonsTable seasons = $SeasonsTable(this);
  late final $EpisodesTable episodes = $EpisodesTable(this);
  late final $ComicsTable comics = $ComicsTable(this);
  late final $ComicsBooksTable comicsBooks = $ComicsBooksTable(this);
  late final $NovelsTable novels = $NovelsTable(this);
  late final $NovelBooksTable novelBooks = $NovelBooksTable(this);
  late final $WorksTable works = $WorksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    anime,
    seasons,
    episodes,
    comics,
    comicsBooks,
    novels,
    novelBooks,
    works,
  ];
}

typedef $$AnimeTableCreateCompanionBuilder =
    AnimeCompanion Function({
      required String id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      Value<String?> studio,
      Value<String?> publisher,
      Value<DateTime?> announcementDate,
      Value<String?> grading,
      Value<String?> synopsis,
      Value<String?> mainStaff,
      Value<String?> original,
      Value<String?> cast,
      Value<String?> opEd,
      Value<String?> watchPlatforms,
      Value<String?> officialSite,
      Value<String?> socialLink,
      required String version,
      required DateTime lastUpdate,
      Value<String?> seasonalInfo,
      Value<int> rowid,
    });
typedef $$AnimeTableUpdateCompanionBuilder =
    AnimeCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      Value<String?> studio,
      Value<String?> publisher,
      Value<DateTime?> announcementDate,
      Value<String?> grading,
      Value<String?> synopsis,
      Value<String?> mainStaff,
      Value<String?> original,
      Value<String?> cast,
      Value<String?> opEd,
      Value<String?> watchPlatforms,
      Value<String?> officialSite,
      Value<String?> socialLink,
      Value<String> version,
      Value<DateTime> lastUpdate,
      Value<String?> seasonalInfo,
      Value<int> rowid,
    });

class $$AnimeTableFilterComposer extends Composer<_$WorkDatabase, $AnimeTable> {
  $$AnimeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studio => $composableBuilder(
    column: $table.studio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get announcementDate => $composableBuilder(
    column: $table.announcementDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainStaff => $composableBuilder(
    column: $table.mainStaff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get original => $composableBuilder(
    column: $table.original,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cast => $composableBuilder(
    column: $table.cast,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opEd => $composableBuilder(
    column: $table.opEd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get watchPlatforms => $composableBuilder(
    column: $table.watchPlatforms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seasonalInfo => $composableBuilder(
    column: $table.seasonalInfo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnimeTableOrderingComposer
    extends Composer<_$WorkDatabase, $AnimeTable> {
  $$AnimeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studio => $composableBuilder(
    column: $table.studio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get announcementDate => $composableBuilder(
    column: $table.announcementDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainStaff => $composableBuilder(
    column: $table.mainStaff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get original => $composableBuilder(
    column: $table.original,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cast => $composableBuilder(
    column: $table.cast,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opEd => $composableBuilder(
    column: $table.opEd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get watchPlatforms => $composableBuilder(
    column: $table.watchPlatforms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seasonalInfo => $composableBuilder(
    column: $table.seasonalInfo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnimeTableAnnotationComposer
    extends Composer<_$WorkDatabase, $AnimeTable> {
  $$AnimeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleJp =>
      $composableBuilder(column: $table.titleJp, builder: (column) => column);

  GeneratedColumn<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get studio =>
      $composableBuilder(column: $table.studio, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<DateTime> get announcementDate => $composableBuilder(
    column: $table.announcementDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grading =>
      $composableBuilder(column: $table.grading, builder: (column) => column);

  GeneratedColumn<String> get synopsis =>
      $composableBuilder(column: $table.synopsis, builder: (column) => column);

  GeneratedColumn<String> get mainStaff =>
      $composableBuilder(column: $table.mainStaff, builder: (column) => column);

  GeneratedColumn<String> get original =>
      $composableBuilder(column: $table.original, builder: (column) => column);

  GeneratedColumn<String> get cast =>
      $composableBuilder(column: $table.cast, builder: (column) => column);

  GeneratedColumn<String> get opEd =>
      $composableBuilder(column: $table.opEd, builder: (column) => column);

  GeneratedColumn<String> get watchPlatforms => $composableBuilder(
    column: $table.watchPlatforms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => column,
  );

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seasonalInfo => $composableBuilder(
    column: $table.seasonalInfo,
    builder: (column) => column,
  );
}

class $$AnimeTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $AnimeTable,
          AnimeData,
          $$AnimeTableFilterComposer,
          $$AnimeTableOrderingComposer,
          $$AnimeTableAnnotationComposer,
          $$AnimeTableCreateCompanionBuilder,
          $$AnimeTableUpdateCompanionBuilder,
          (AnimeData, BaseReferences<_$WorkDatabase, $AnimeTable, AnimeData>),
          AnimeData,
          PrefetchHooks Function()
        > {
  $$AnimeTableTableManager(_$WorkDatabase db, $AnimeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AnimeTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AnimeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AnimeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                Value<String?> studio = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<DateTime?> announcementDate = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> mainStaff = const Value.absent(),
                Value<String?> original = const Value.absent(),
                Value<String?> cast = const Value.absent(),
                Value<String?> opEd = const Value.absent(),
                Value<String?> watchPlatforms = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<String?> seasonalInfo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimeCompanion(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                studio: studio,
                publisher: publisher,
                announcementDate: announcementDate,
                grading: grading,
                synopsis: synopsis,
                mainStaff: mainStaff,
                original: original,
                cast: cast,
                opEd: opEd,
                watchPlatforms: watchPlatforms,
                officialSite: officialSite,
                socialLink: socialLink,
                version: version,
                lastUpdate: lastUpdate,
                seasonalInfo: seasonalInfo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                Value<String?> studio = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<DateTime?> announcementDate = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> mainStaff = const Value.absent(),
                Value<String?> original = const Value.absent(),
                Value<String?> cast = const Value.absent(),
                Value<String?> opEd = const Value.absent(),
                Value<String?> watchPlatforms = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
                required String version,
                required DateTime lastUpdate,
                Value<String?> seasonalInfo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimeCompanion.insert(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                studio: studio,
                publisher: publisher,
                announcementDate: announcementDate,
                grading: grading,
                synopsis: synopsis,
                mainStaff: mainStaff,
                original: original,
                cast: cast,
                opEd: opEd,
                watchPlatforms: watchPlatforms,
                officialSite: officialSite,
                socialLink: socialLink,
                version: version,
                lastUpdate: lastUpdate,
                seasonalInfo: seasonalInfo,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnimeTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $AnimeTable,
      AnimeData,
      $$AnimeTableFilterComposer,
      $$AnimeTableOrderingComposer,
      $$AnimeTableAnnotationComposer,
      $$AnimeTableCreateCompanionBuilder,
      $$AnimeTableUpdateCompanionBuilder,
      (AnimeData, BaseReferences<_$WorkDatabase, $AnimeTable, AnimeData>),
      AnimeData,
      PrefetchHooks Function()
    >;
typedef $$SeasonsTableCreateCompanionBuilder =
    SeasonsCompanion Function({
      required String animeId,
      required int seasonNumber,
      Value<DateTime?> productionAnnouncementDate,
      Value<DateTime?> releaseDate,
      Value<int?> episodesCount,
      Value<bool> releaseDateUnknown,
      Value<int> rowid,
    });
typedef $$SeasonsTableUpdateCompanionBuilder =
    SeasonsCompanion Function({
      Value<String> animeId,
      Value<int> seasonNumber,
      Value<DateTime?> productionAnnouncementDate,
      Value<DateTime?> releaseDate,
      Value<int?> episodesCount,
      Value<bool> releaseDateUnknown,
      Value<int> rowid,
    });

class $$SeasonsTableFilterComposer
    extends Composer<_$WorkDatabase, $SeasonsTable> {
  $$SeasonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get productionAnnouncementDate => $composableBuilder(
    column: $table.productionAnnouncementDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episodesCount => $composableBuilder(
    column: $table.episodesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get releaseDateUnknown => $composableBuilder(
    column: $table.releaseDateUnknown,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SeasonsTableOrderingComposer
    extends Composer<_$WorkDatabase, $SeasonsTable> {
  $$SeasonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get productionAnnouncementDate =>
      $composableBuilder(
        column: $table.productionAnnouncementDate,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episodesCount => $composableBuilder(
    column: $table.episodesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get releaseDateUnknown => $composableBuilder(
    column: $table.releaseDateUnknown,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeasonsTableAnnotationComposer
    extends Composer<_$WorkDatabase, $SeasonsTable> {
  $$SeasonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get animeId =>
      $composableBuilder(column: $table.animeId, builder: (column) => column);

  GeneratedColumn<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get productionAnnouncementDate =>
      $composableBuilder(
        column: $table.productionAnnouncementDate,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get episodesCount => $composableBuilder(
    column: $table.episodesCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get releaseDateUnknown => $composableBuilder(
    column: $table.releaseDateUnknown,
    builder: (column) => column,
  );
}

class $$SeasonsTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $SeasonsTable,
          Season,
          $$SeasonsTableFilterComposer,
          $$SeasonsTableOrderingComposer,
          $$SeasonsTableAnnotationComposer,
          $$SeasonsTableCreateCompanionBuilder,
          $$SeasonsTableUpdateCompanionBuilder,
          (Season, BaseReferences<_$WorkDatabase, $SeasonsTable, Season>),
          Season,
          PrefetchHooks Function()
        > {
  $$SeasonsTableTableManager(_$WorkDatabase db, $SeasonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SeasonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SeasonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SeasonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> animeId = const Value.absent(),
                Value<int> seasonNumber = const Value.absent(),
                Value<DateTime?> productionAnnouncementDate =
                    const Value.absent(),
                Value<DateTime?> releaseDate = const Value.absent(),
                Value<int?> episodesCount = const Value.absent(),
                Value<bool> releaseDateUnknown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonsCompanion(
                animeId: animeId,
                seasonNumber: seasonNumber,
                productionAnnouncementDate: productionAnnouncementDate,
                releaseDate: releaseDate,
                episodesCount: episodesCount,
                releaseDateUnknown: releaseDateUnknown,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String animeId,
                required int seasonNumber,
                Value<DateTime?> productionAnnouncementDate =
                    const Value.absent(),
                Value<DateTime?> releaseDate = const Value.absent(),
                Value<int?> episodesCount = const Value.absent(),
                Value<bool> releaseDateUnknown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeasonsCompanion.insert(
                animeId: animeId,
                seasonNumber: seasonNumber,
                productionAnnouncementDate: productionAnnouncementDate,
                releaseDate: releaseDate,
                episodesCount: episodesCount,
                releaseDateUnknown: releaseDateUnknown,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeasonsTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $SeasonsTable,
      Season,
      $$SeasonsTableFilterComposer,
      $$SeasonsTableOrderingComposer,
      $$SeasonsTableAnnotationComposer,
      $$SeasonsTableCreateCompanionBuilder,
      $$SeasonsTableUpdateCompanionBuilder,
      (Season, BaseReferences<_$WorkDatabase, $SeasonsTable, Season>),
      Season,
      PrefetchHooks Function()
    >;
typedef $$EpisodesTableCreateCompanionBuilder =
    EpisodesCompanion Function({
      Value<int> id,
      required String animeId,
      required int seasonNumber,
      required int episodeNumber,
      Value<String?> episodeLabel,
      Value<DateTime?> airTime,
      Value<bool> isTimeUnknown,
    });
typedef $$EpisodesTableUpdateCompanionBuilder =
    EpisodesCompanion Function({
      Value<int> id,
      Value<String> animeId,
      Value<int> seasonNumber,
      Value<int> episodeNumber,
      Value<String?> episodeLabel,
      Value<DateTime?> airTime,
      Value<bool> isTimeUnknown,
    });

class $$EpisodesTableFilterComposer
    extends Composer<_$WorkDatabase, $EpisodesTable> {
  $$EpisodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get episodeNumber => $composableBuilder(
    column: $table.episodeNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get episodeLabel => $composableBuilder(
    column: $table.episodeLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get airTime => $composableBuilder(
    column: $table.airTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTimeUnknown => $composableBuilder(
    column: $table.isTimeUnknown,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EpisodesTableOrderingComposer
    extends Composer<_$WorkDatabase, $EpisodesTable> {
  $$EpisodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animeId => $composableBuilder(
    column: $table.animeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get episodeNumber => $composableBuilder(
    column: $table.episodeNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episodeLabel => $composableBuilder(
    column: $table.episodeLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get airTime => $composableBuilder(
    column: $table.airTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTimeUnknown => $composableBuilder(
    column: $table.isTimeUnknown,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EpisodesTableAnnotationComposer
    extends Composer<_$WorkDatabase, $EpisodesTable> {
  $$EpisodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get animeId =>
      $composableBuilder(column: $table.animeId, builder: (column) => column);

  GeneratedColumn<int> get seasonNumber => $composableBuilder(
    column: $table.seasonNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get episodeNumber => $composableBuilder(
    column: $table.episodeNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get episodeLabel => $composableBuilder(
    column: $table.episodeLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get airTime =>
      $composableBuilder(column: $table.airTime, builder: (column) => column);

  GeneratedColumn<bool> get isTimeUnknown => $composableBuilder(
    column: $table.isTimeUnknown,
    builder: (column) => column,
  );
}

class $$EpisodesTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $EpisodesTable,
          Episode,
          $$EpisodesTableFilterComposer,
          $$EpisodesTableOrderingComposer,
          $$EpisodesTableAnnotationComposer,
          $$EpisodesTableCreateCompanionBuilder,
          $$EpisodesTableUpdateCompanionBuilder,
          (Episode, BaseReferences<_$WorkDatabase, $EpisodesTable, Episode>),
          Episode,
          PrefetchHooks Function()
        > {
  $$EpisodesTableTableManager(_$WorkDatabase db, $EpisodesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EpisodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EpisodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$EpisodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> animeId = const Value.absent(),
                Value<int> seasonNumber = const Value.absent(),
                Value<int> episodeNumber = const Value.absent(),
                Value<String?> episodeLabel = const Value.absent(),
                Value<DateTime?> airTime = const Value.absent(),
                Value<bool> isTimeUnknown = const Value.absent(),
              }) => EpisodesCompanion(
                id: id,
                animeId: animeId,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                episodeLabel: episodeLabel,
                airTime: airTime,
                isTimeUnknown: isTimeUnknown,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String animeId,
                required int seasonNumber,
                required int episodeNumber,
                Value<String?> episodeLabel = const Value.absent(),
                Value<DateTime?> airTime = const Value.absent(),
                Value<bool> isTimeUnknown = const Value.absent(),
              }) => EpisodesCompanion.insert(
                id: id,
                animeId: animeId,
                seasonNumber: seasonNumber,
                episodeNumber: episodeNumber,
                episodeLabel: episodeLabel,
                airTime: airTime,
                isTimeUnknown: isTimeUnknown,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EpisodesTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $EpisodesTable,
      Episode,
      $$EpisodesTableFilterComposer,
      $$EpisodesTableOrderingComposer,
      $$EpisodesTableAnnotationComposer,
      $$EpisodesTableCreateCompanionBuilder,
      $$EpisodesTableUpdateCompanionBuilder,
      (Episode, BaseReferences<_$WorkDatabase, $EpisodesTable, Episode>),
      Episode,
      PrefetchHooks Function()
    >;
typedef $$ComicsTableCreateCompanionBuilder =
    ComicsCompanion Function({
      required String id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      required String version,
      required DateTime lastUpdate,
      Value<int> rowid,
    });
typedef $$ComicsTableUpdateCompanionBuilder =
    ComicsCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      Value<String> version,
      Value<DateTime> lastUpdate,
      Value<int> rowid,
    });

class $$ComicsTableFilterComposer
    extends Composer<_$WorkDatabase, $ComicsTable> {
  $$ComicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ComicsTableOrderingComposer
    extends Composer<_$WorkDatabase, $ComicsTable> {
  $$ComicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ComicsTableAnnotationComposer
    extends Composer<_$WorkDatabase, $ComicsTable> {
  $$ComicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleJp =>
      $composableBuilder(column: $table.titleJp, builder: (column) => column);

  GeneratedColumn<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );
}

class $$ComicsTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $ComicsTable,
          Comic,
          $$ComicsTableFilterComposer,
          $$ComicsTableOrderingComposer,
          $$ComicsTableAnnotationComposer,
          $$ComicsTableCreateCompanionBuilder,
          $$ComicsTableUpdateCompanionBuilder,
          (Comic, BaseReferences<_$WorkDatabase, $ComicsTable, Comic>),
          Comic,
          PrefetchHooks Function()
        > {
  $$ComicsTableTableManager(_$WorkDatabase db, $ComicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ComicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ComicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ComicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ComicsCompanion(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                required String version,
                required DateTime lastUpdate,
                Value<int> rowid = const Value.absent(),
              }) => ComicsCompanion.insert(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ComicsTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $ComicsTable,
      Comic,
      $$ComicsTableFilterComposer,
      $$ComicsTableOrderingComposer,
      $$ComicsTableAnnotationComposer,
      $$ComicsTableCreateCompanionBuilder,
      $$ComicsTableUpdateCompanionBuilder,
      (Comic, BaseReferences<_$WorkDatabase, $ComicsTable, Comic>),
      Comic,
      PrefetchHooks Function()
    >;
typedef $$ComicsBooksTableCreateCompanionBuilder =
    ComicsBooksCompanion Function({
      Value<int> id,
      required String comicsId,
      Value<String?> type,
      Value<String?> publisher,
      Value<int?> volumes,
      Value<DateTime?> releaseDateTw,
      Value<DateTime?> releaseDateJp,
      Value<String?> grading,
      Value<String?> pricing,
      Value<String?> synopsis,
      Value<String?> coverImage,
      Value<String?> purchasePhysical,
      Value<String?> purchaseEbook,
      Value<String?> officialSite,
      Value<String?> socialLink,
    });
typedef $$ComicsBooksTableUpdateCompanionBuilder =
    ComicsBooksCompanion Function({
      Value<int> id,
      Value<String> comicsId,
      Value<String?> type,
      Value<String?> publisher,
      Value<int?> volumes,
      Value<DateTime?> releaseDateTw,
      Value<DateTime?> releaseDateJp,
      Value<String?> grading,
      Value<String?> pricing,
      Value<String?> synopsis,
      Value<String?> coverImage,
      Value<String?> purchasePhysical,
      Value<String?> purchaseEbook,
      Value<String?> officialSite,
      Value<String?> socialLink,
    });

class $$ComicsBooksTableFilterComposer
    extends Composer<_$WorkDatabase, $ComicsBooksTable> {
  $$ComicsBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comicsId => $composableBuilder(
    column: $table.comicsId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get volumes => $composableBuilder(
    column: $table.volumes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get releaseDateTw => $composableBuilder(
    column: $table.releaseDateTw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get releaseDateJp => $composableBuilder(
    column: $table.releaseDateJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricing => $composableBuilder(
    column: $table.pricing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ComicsBooksTableOrderingComposer
    extends Composer<_$WorkDatabase, $ComicsBooksTable> {
  $$ComicsBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comicsId => $composableBuilder(
    column: $table.comicsId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get volumes => $composableBuilder(
    column: $table.volumes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get releaseDateTw => $composableBuilder(
    column: $table.releaseDateTw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get releaseDateJp => $composableBuilder(
    column: $table.releaseDateJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricing => $composableBuilder(
    column: $table.pricing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ComicsBooksTableAnnotationComposer
    extends Composer<_$WorkDatabase, $ComicsBooksTable> {
  $$ComicsBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get comicsId =>
      $composableBuilder(column: $table.comicsId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<int> get volumes =>
      $composableBuilder(column: $table.volumes, builder: (column) => column);

  GeneratedColumn<DateTime> get releaseDateTw => $composableBuilder(
    column: $table.releaseDateTw,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get releaseDateJp => $composableBuilder(
    column: $table.releaseDateJp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grading =>
      $composableBuilder(column: $table.grading, builder: (column) => column);

  GeneratedColumn<String> get pricing =>
      $composableBuilder(column: $table.pricing, builder: (column) => column);

  GeneratedColumn<String> get synopsis =>
      $composableBuilder(column: $table.synopsis, builder: (column) => column);

  GeneratedColumn<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => column,
  );

  GeneratedColumn<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => column,
  );
}

class $$ComicsBooksTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $ComicsBooksTable,
          ComicsBook,
          $$ComicsBooksTableFilterComposer,
          $$ComicsBooksTableOrderingComposer,
          $$ComicsBooksTableAnnotationComposer,
          $$ComicsBooksTableCreateCompanionBuilder,
          $$ComicsBooksTableUpdateCompanionBuilder,
          (
            ComicsBook,
            BaseReferences<_$WorkDatabase, $ComicsBooksTable, ComicsBook>,
          ),
          ComicsBook,
          PrefetchHooks Function()
        > {
  $$ComicsBooksTableTableManager(_$WorkDatabase db, $ComicsBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ComicsBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ComicsBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ComicsBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> comicsId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> volumes = const Value.absent(),
                Value<DateTime?> releaseDateTw = const Value.absent(),
                Value<DateTime?> releaseDateJp = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> pricing = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> purchasePhysical = const Value.absent(),
                Value<String?> purchaseEbook = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
              }) => ComicsBooksCompanion(
                id: id,
                comicsId: comicsId,
                type: type,
                publisher: publisher,
                volumes: volumes,
                releaseDateTw: releaseDateTw,
                releaseDateJp: releaseDateJp,
                grading: grading,
                pricing: pricing,
                synopsis: synopsis,
                coverImage: coverImage,
                purchasePhysical: purchasePhysical,
                purchaseEbook: purchaseEbook,
                officialSite: officialSite,
                socialLink: socialLink,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String comicsId,
                Value<String?> type = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<int?> volumes = const Value.absent(),
                Value<DateTime?> releaseDateTw = const Value.absent(),
                Value<DateTime?> releaseDateJp = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> pricing = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> purchasePhysical = const Value.absent(),
                Value<String?> purchaseEbook = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
              }) => ComicsBooksCompanion.insert(
                id: id,
                comicsId: comicsId,
                type: type,
                publisher: publisher,
                volumes: volumes,
                releaseDateTw: releaseDateTw,
                releaseDateJp: releaseDateJp,
                grading: grading,
                pricing: pricing,
                synopsis: synopsis,
                coverImage: coverImage,
                purchasePhysical: purchasePhysical,
                purchaseEbook: purchaseEbook,
                officialSite: officialSite,
                socialLink: socialLink,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ComicsBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $ComicsBooksTable,
      ComicsBook,
      $$ComicsBooksTableFilterComposer,
      $$ComicsBooksTableOrderingComposer,
      $$ComicsBooksTableAnnotationComposer,
      $$ComicsBooksTableCreateCompanionBuilder,
      $$ComicsBooksTableUpdateCompanionBuilder,
      (
        ComicsBook,
        BaseReferences<_$WorkDatabase, $ComicsBooksTable, ComicsBook>,
      ),
      ComicsBook,
      PrefetchHooks Function()
    >;
typedef $$NovelsTableCreateCompanionBuilder =
    NovelsCompanion Function({
      required String id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      required String version,
      required DateTime lastUpdate,
      Value<int> rowid,
    });
typedef $$NovelsTableUpdateCompanionBuilder =
    NovelsCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> coverImageLocal,
      Value<String?> coverImageRemote,
      Value<String> version,
      Value<DateTime> lastUpdate,
      Value<int> rowid,
    });

class $$NovelsTableFilterComposer
    extends Composer<_$WorkDatabase, $NovelsTable> {
  $$NovelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NovelsTableOrderingComposer
    extends Composer<_$WorkDatabase, $NovelsTable> {
  $$NovelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NovelsTableAnnotationComposer
    extends Composer<_$WorkDatabase, $NovelsTable> {
  $$NovelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleJp =>
      $composableBuilder(column: $table.titleJp, builder: (column) => column);

  GeneratedColumn<String> get coverImageLocal => $composableBuilder(
    column: $table.coverImageLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverImageRemote => $composableBuilder(
    column: $table.coverImageRemote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );
}

class $$NovelsTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $NovelsTable,
          Novel,
          $$NovelsTableFilterComposer,
          $$NovelsTableOrderingComposer,
          $$NovelsTableAnnotationComposer,
          $$NovelsTableCreateCompanionBuilder,
          $$NovelsTableUpdateCompanionBuilder,
          (Novel, BaseReferences<_$WorkDatabase, $NovelsTable, Novel>),
          Novel,
          PrefetchHooks Function()
        > {
  $$NovelsTableTableManager(_$WorkDatabase db, $NovelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NovelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NovelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NovelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NovelsCompanion(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> coverImageLocal = const Value.absent(),
                Value<String?> coverImageRemote = const Value.absent(),
                required String version,
                required DateTime lastUpdate,
                Value<int> rowid = const Value.absent(),
              }) => NovelsCompanion.insert(
                id: id,
                title: title,
                titleJp: titleJp,
                coverImageLocal: coverImageLocal,
                coverImageRemote: coverImageRemote,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NovelsTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $NovelsTable,
      Novel,
      $$NovelsTableFilterComposer,
      $$NovelsTableOrderingComposer,
      $$NovelsTableAnnotationComposer,
      $$NovelsTableCreateCompanionBuilder,
      $$NovelsTableUpdateCompanionBuilder,
      (Novel, BaseReferences<_$WorkDatabase, $NovelsTable, Novel>),
      Novel,
      PrefetchHooks Function()
    >;
typedef $$NovelBooksTableCreateCompanionBuilder =
    NovelBooksCompanion Function({
      Value<int> id,
      required String novelId,
      Value<String?> type,
      Value<String?> author,
      Value<String?> illustrator,
      Value<DateTime?> publishDateTw,
      Value<DateTime?> publishDateJp,
      Value<String?> grading,
      Value<String?> pricing,
      Value<String?> synopsis,
      Value<String?> coverImage,
      Value<String?> publisher,
      Value<String?> purchasePhysical,
      Value<String?> purchaseEbook,
      Value<String?> officialSite,
      Value<String?> socialLink,
    });
typedef $$NovelBooksTableUpdateCompanionBuilder =
    NovelBooksCompanion Function({
      Value<int> id,
      Value<String> novelId,
      Value<String?> type,
      Value<String?> author,
      Value<String?> illustrator,
      Value<DateTime?> publishDateTw,
      Value<DateTime?> publishDateJp,
      Value<String?> grading,
      Value<String?> pricing,
      Value<String?> synopsis,
      Value<String?> coverImage,
      Value<String?> publisher,
      Value<String?> purchasePhysical,
      Value<String?> purchaseEbook,
      Value<String?> officialSite,
      Value<String?> socialLink,
    });

class $$NovelBooksTableFilterComposer
    extends Composer<_$WorkDatabase, $NovelBooksTable> {
  $$NovelBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get illustrator => $composableBuilder(
    column: $table.illustrator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishDateTw => $composableBuilder(
    column: $table.publishDateTw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get publishDateJp => $composableBuilder(
    column: $table.publishDateJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pricing => $composableBuilder(
    column: $table.pricing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NovelBooksTableOrderingComposer
    extends Composer<_$WorkDatabase, $NovelBooksTable> {
  $$NovelBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get novelId => $composableBuilder(
    column: $table.novelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get illustrator => $composableBuilder(
    column: $table.illustrator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishDateTw => $composableBuilder(
    column: $table.publishDateTw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get publishDateJp => $composableBuilder(
    column: $table.publishDateJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grading => $composableBuilder(
    column: $table.grading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pricing => $composableBuilder(
    column: $table.pricing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synopsis => $composableBuilder(
    column: $table.synopsis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NovelBooksTableAnnotationComposer
    extends Composer<_$WorkDatabase, $NovelBooksTable> {
  $$NovelBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get novelId =>
      $composableBuilder(column: $table.novelId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get illustrator => $composableBuilder(
    column: $table.illustrator,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get publishDateTw => $composableBuilder(
    column: $table.publishDateTw,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get publishDateJp => $composableBuilder(
    column: $table.publishDateJp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grading =>
      $composableBuilder(column: $table.grading, builder: (column) => column);

  GeneratedColumn<String> get pricing =>
      $composableBuilder(column: $table.pricing, builder: (column) => column);

  GeneratedColumn<String> get synopsis =>
      $composableBuilder(column: $table.synopsis, builder: (column) => column);

  GeneratedColumn<String> get coverImage => $composableBuilder(
    column: $table.coverImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<String> get purchasePhysical => $composableBuilder(
    column: $table.purchasePhysical,
    builder: (column) => column,
  );

  GeneratedColumn<String> get purchaseEbook => $composableBuilder(
    column: $table.purchaseEbook,
    builder: (column) => column,
  );

  GeneratedColumn<String> get officialSite => $composableBuilder(
    column: $table.officialSite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get socialLink => $composableBuilder(
    column: $table.socialLink,
    builder: (column) => column,
  );
}

class $$NovelBooksTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $NovelBooksTable,
          NovelBook,
          $$NovelBooksTableFilterComposer,
          $$NovelBooksTableOrderingComposer,
          $$NovelBooksTableAnnotationComposer,
          $$NovelBooksTableCreateCompanionBuilder,
          $$NovelBooksTableUpdateCompanionBuilder,
          (
            NovelBook,
            BaseReferences<_$WorkDatabase, $NovelBooksTable, NovelBook>,
          ),
          NovelBook,
          PrefetchHooks Function()
        > {
  $$NovelBooksTableTableManager(_$WorkDatabase db, $NovelBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$NovelBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$NovelBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$NovelBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> novelId = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> illustrator = const Value.absent(),
                Value<DateTime?> publishDateTw = const Value.absent(),
                Value<DateTime?> publishDateJp = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> pricing = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<String?> purchasePhysical = const Value.absent(),
                Value<String?> purchaseEbook = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
              }) => NovelBooksCompanion(
                id: id,
                novelId: novelId,
                type: type,
                author: author,
                illustrator: illustrator,
                publishDateTw: publishDateTw,
                publishDateJp: publishDateJp,
                grading: grading,
                pricing: pricing,
                synopsis: synopsis,
                coverImage: coverImage,
                publisher: publisher,
                purchasePhysical: purchasePhysical,
                purchaseEbook: purchaseEbook,
                officialSite: officialSite,
                socialLink: socialLink,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String novelId,
                Value<String?> type = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> illustrator = const Value.absent(),
                Value<DateTime?> publishDateTw = const Value.absent(),
                Value<DateTime?> publishDateJp = const Value.absent(),
                Value<String?> grading = const Value.absent(),
                Value<String?> pricing = const Value.absent(),
                Value<String?> synopsis = const Value.absent(),
                Value<String?> coverImage = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<String?> purchasePhysical = const Value.absent(),
                Value<String?> purchaseEbook = const Value.absent(),
                Value<String?> officialSite = const Value.absent(),
                Value<String?> socialLink = const Value.absent(),
              }) => NovelBooksCompanion.insert(
                id: id,
                novelId: novelId,
                type: type,
                author: author,
                illustrator: illustrator,
                publishDateTw: publishDateTw,
                publishDateJp: publishDateJp,
                grading: grading,
                pricing: pricing,
                synopsis: synopsis,
                coverImage: coverImage,
                publisher: publisher,
                purchasePhysical: purchasePhysical,
                purchaseEbook: purchaseEbook,
                officialSite: officialSite,
                socialLink: socialLink,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NovelBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $NovelBooksTable,
      NovelBook,
      $$NovelBooksTableFilterComposer,
      $$NovelBooksTableOrderingComposer,
      $$NovelBooksTableAnnotationComposer,
      $$NovelBooksTableCreateCompanionBuilder,
      $$NovelBooksTableUpdateCompanionBuilder,
      (NovelBook, BaseReferences<_$WorkDatabase, $NovelBooksTable, NovelBook>),
      NovelBook,
      PrefetchHooks Function()
    >;
typedef $$WorksTableCreateCompanionBuilder =
    WorksCompanion Function({
      required String id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> categoryTags,
      Value<String?> introduction,
      Value<String?> news,
      Value<String?> animeList,
      Value<String?> novelList,
      Value<String?> comicsList,
      Value<String?> othersList,
      required String version,
      required DateTime lastUpdate,
      Value<int> rowid,
    });
typedef $$WorksTableUpdateCompanionBuilder =
    WorksCompanion Function({
      Value<String> id,
      Value<String?> title,
      Value<String?> titleJp,
      Value<String?> categoryTags,
      Value<String?> introduction,
      Value<String?> news,
      Value<String?> animeList,
      Value<String?> novelList,
      Value<String?> comicsList,
      Value<String?> othersList,
      Value<String> version,
      Value<DateTime> lastUpdate,
      Value<int> rowid,
    });

class $$WorksTableFilterComposer extends Composer<_$WorkDatabase, $WorksTable> {
  $$WorksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryTags => $composableBuilder(
    column: $table.categoryTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get introduction => $composableBuilder(
    column: $table.introduction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get news => $composableBuilder(
    column: $table.news,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animeList => $composableBuilder(
    column: $table.animeList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get novelList => $composableBuilder(
    column: $table.novelList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comicsList => $composableBuilder(
    column: $table.comicsList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get othersList => $composableBuilder(
    column: $table.othersList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorksTableOrderingComposer
    extends Composer<_$WorkDatabase, $WorksTable> {
  $$WorksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleJp => $composableBuilder(
    column: $table.titleJp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryTags => $composableBuilder(
    column: $table.categoryTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get introduction => $composableBuilder(
    column: $table.introduction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get news => $composableBuilder(
    column: $table.news,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animeList => $composableBuilder(
    column: $table.animeList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get novelList => $composableBuilder(
    column: $table.novelList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comicsList => $composableBuilder(
    column: $table.comicsList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get othersList => $composableBuilder(
    column: $table.othersList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorksTableAnnotationComposer
    extends Composer<_$WorkDatabase, $WorksTable> {
  $$WorksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleJp =>
      $composableBuilder(column: $table.titleJp, builder: (column) => column);

  GeneratedColumn<String> get categoryTags => $composableBuilder(
    column: $table.categoryTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get introduction => $composableBuilder(
    column: $table.introduction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get news =>
      $composableBuilder(column: $table.news, builder: (column) => column);

  GeneratedColumn<String> get animeList =>
      $composableBuilder(column: $table.animeList, builder: (column) => column);

  GeneratedColumn<String> get novelList =>
      $composableBuilder(column: $table.novelList, builder: (column) => column);

  GeneratedColumn<String> get comicsList => $composableBuilder(
    column: $table.comicsList,
    builder: (column) => column,
  );

  GeneratedColumn<String> get othersList => $composableBuilder(
    column: $table.othersList,
    builder: (column) => column,
  );

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );
}

class $$WorksTableTableManager
    extends
        RootTableManager<
          _$WorkDatabase,
          $WorksTable,
          Work,
          $$WorksTableFilterComposer,
          $$WorksTableOrderingComposer,
          $$WorksTableAnnotationComposer,
          $$WorksTableCreateCompanionBuilder,
          $$WorksTableUpdateCompanionBuilder,
          (Work, BaseReferences<_$WorkDatabase, $WorksTable, Work>),
          Work,
          PrefetchHooks Function()
        > {
  $$WorksTableTableManager(_$WorkDatabase db, $WorksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WorksTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WorksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WorksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> categoryTags = const Value.absent(),
                Value<String?> introduction = const Value.absent(),
                Value<String?> news = const Value.absent(),
                Value<String?> animeList = const Value.absent(),
                Value<String?> novelList = const Value.absent(),
                Value<String?> comicsList = const Value.absent(),
                Value<String?> othersList = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorksCompanion(
                id: id,
                title: title,
                titleJp: titleJp,
                categoryTags: categoryTags,
                introduction: introduction,
                news: news,
                animeList: animeList,
                novelList: novelList,
                comicsList: comicsList,
                othersList: othersList,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> title = const Value.absent(),
                Value<String?> titleJp = const Value.absent(),
                Value<String?> categoryTags = const Value.absent(),
                Value<String?> introduction = const Value.absent(),
                Value<String?> news = const Value.absent(),
                Value<String?> animeList = const Value.absent(),
                Value<String?> novelList = const Value.absent(),
                Value<String?> comicsList = const Value.absent(),
                Value<String?> othersList = const Value.absent(),
                required String version,
                required DateTime lastUpdate,
                Value<int> rowid = const Value.absent(),
              }) => WorksCompanion.insert(
                id: id,
                title: title,
                titleJp: titleJp,
                categoryTags: categoryTags,
                introduction: introduction,
                news: news,
                animeList: animeList,
                novelList: novelList,
                comicsList: comicsList,
                othersList: othersList,
                version: version,
                lastUpdate: lastUpdate,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorksTableProcessedTableManager =
    ProcessedTableManager<
      _$WorkDatabase,
      $WorksTable,
      Work,
      $$WorksTableFilterComposer,
      $$WorksTableOrderingComposer,
      $$WorksTableAnnotationComposer,
      $$WorksTableCreateCompanionBuilder,
      $$WorksTableUpdateCompanionBuilder,
      (Work, BaseReferences<_$WorkDatabase, $WorksTable, Work>),
      Work,
      PrefetchHooks Function()
    >;

class $WorkDatabaseManager {
  final _$WorkDatabase _db;
  $WorkDatabaseManager(this._db);
  $$AnimeTableTableManager get anime =>
      $$AnimeTableTableManager(_db, _db.anime);
  $$SeasonsTableTableManager get seasons =>
      $$SeasonsTableTableManager(_db, _db.seasons);
  $$EpisodesTableTableManager get episodes =>
      $$EpisodesTableTableManager(_db, _db.episodes);
  $$ComicsTableTableManager get comics =>
      $$ComicsTableTableManager(_db, _db.comics);
  $$ComicsBooksTableTableManager get comicsBooks =>
      $$ComicsBooksTableTableManager(_db, _db.comicsBooks);
  $$NovelsTableTableManager get novels =>
      $$NovelsTableTableManager(_db, _db.novels);
  $$NovelBooksTableTableManager get novelBooks =>
      $$NovelBooksTableTableManager(_db, _db.novelBooks);
  $$WorksTableTableManager get works =>
      $$WorksTableTableManager(_db, _db.works);
}
