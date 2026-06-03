// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnimeCollection on Isar {
  IsarCollection<Anime> get animes => this.collection();
}

const AnimeSchema = CollectionSchema(
  name: r'Anime',
  id: -2255851914829551581,
  properties: {
    r'durationMinutes': PropertySchema(
      id: 0,
      name: r'durationMinutes',
      type: IsarType.long,
    ),
    r'episode': PropertySchema(
      id: 1,
      name: r'episode',
      type: IsarType.long,
    ),
    r'evaluation': PropertySchema(
      id: 2,
      name: r'evaluation',
      type: IsarType.long,
    ),
    r'memo': PropertySchema(
      id: 3,
      name: r'memo',
      type: IsarType.string,
    ),
    r'onAirYear': PropertySchema(
      id: 4,
      name: r'onAirYear',
      type: IsarType.long,
    ),
    r'season': PropertySchema(
      id: 5,
      name: r'season',
      type: IsarType.byte,
      enumMap: _AnimeseasonEnumValueMap,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.byte,
      enumMap: _AnimestatusEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleKana': PropertySchema(
      id: 8,
      name: r'titleKana',
      type: IsarType.string,
    ),
    r'updateAt': PropertySchema(
      id: 9,
      name: r'updateAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _animeEstimateSize,
  serialize: _animeSerialize,
  deserialize: _animeDeserialize,
  deserializeProp: _animeDeserializeProp,
  idName: r'id',
  indexes: {
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'titleKana': IndexSchema(
      id: -9083369571609416545,
      name: r'titleKana',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titleKana',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'updateAt': IndexSchema(
      id: 3053952138173439629,
      name: r'updateAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updateAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'onAirYear': IndexSchema(
      id: -7385684786951549042,
      name: r'onAirYear',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'onAirYear',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'episode': IndexSchema(
      id: 5077628722353948045,
      name: r'episode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'episode',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'evaluation': IndexSchema(
      id: -6076097278353109056,
      name: r'evaluation',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'evaluation',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'genres': LinkSchema(
      id: -4595269950727152923,
      name: r'genres',
      target: r'Genre',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _animeGetId,
  getLinks: _animeGetLinks,
  attach: _animeAttach,
  version: '3.1.0+1',
);

int _animeEstimateSize(
  Anime object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.memo.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.titleKana.length * 3;
  return bytesCount;
}

void _animeSerialize(
  Anime object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.durationMinutes);
  writer.writeLong(offsets[1], object.episode);
  writer.writeLong(offsets[2], object.evaluation);
  writer.writeString(offsets[3], object.memo);
  writer.writeLong(offsets[4], object.onAirYear);
  writer.writeByte(offsets[5], object.season.index);
  writer.writeByte(offsets[6], object.status.index);
  writer.writeString(offsets[7], object.title);
  writer.writeString(offsets[8], object.titleKana);
  writer.writeDateTime(offsets[9], object.updateAt);
}

Anime _animeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Anime();
  object.durationMinutes = reader.readLong(offsets[0]);
  object.episode = reader.readLong(offsets[1]);
  object.evaluation = reader.readLong(offsets[2]);
  object.id = id;
  object.memo = reader.readString(offsets[3]);
  object.onAirYear = reader.readLong(offsets[4]);
  object.season = _AnimeseasonValueEnumMap[reader.readByteOrNull(offsets[5])] ??
      OnAirSeason.spring;
  object.status = _AnimestatusValueEnumMap[reader.readByteOrNull(offsets[6])] ??
      AnimeStatus.never;
  object.title = reader.readString(offsets[7]);
  object.titleKana = reader.readString(offsets[8]);
  object.updateAt = reader.readDateTime(offsets[9]);
  return object;
}

P _animeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (_AnimeseasonValueEnumMap[reader.readByteOrNull(offset)] ??
          OnAirSeason.spring) as P;
    case 6:
      return (_AnimestatusValueEnumMap[reader.readByteOrNull(offset)] ??
          AnimeStatus.never) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _AnimeseasonEnumValueMap = {
  'spring': 0,
  'summer': 1,
  'autumn': 2,
  'winter': 3,
};
const _AnimeseasonValueEnumMap = {
  0: OnAirSeason.spring,
  1: OnAirSeason.summer,
  2: OnAirSeason.autumn,
  3: OnAirSeason.winter,
};
const _AnimestatusEnumValueMap = {
  'never': 0,
  'watching': 1,
  'complete': 2,
  'cancel': 3,
  'interruption': 4,
};
const _AnimestatusValueEnumMap = {
  0: AnimeStatus.never,
  1: AnimeStatus.watching,
  2: AnimeStatus.complete,
  3: AnimeStatus.cancel,
  4: AnimeStatus.interruption,
};

Id _animeGetId(Anime object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _animeGetLinks(Anime object) {
  return [object.genres];
}

void _animeAttach(IsarCollection<dynamic> col, Id id, Anime object) {
  object.id = id;
  object.genres.attach(col, col.isar.collection<Genre>(), r'genres', id);
}

extension AnimeQueryWhereSort on QueryBuilder<Anime, Anime, QWhere> {
  QueryBuilder<Anime, Anime, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'status'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyTitleKana() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'titleKana'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updateAt'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyOnAirYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'onAirYear'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyEpisode() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'episode'),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhere> anyEvaluation() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'evaluation'),
      );
    });
  }
}

extension AnimeQueryWhere on QueryBuilder<Anime, Anime, QWhereClause> {
  QueryBuilder<Anime, Anime, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> statusEqualTo(
      AnimeStatus status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> statusNotEqualTo(
      AnimeStatus status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> statusGreaterThan(
    AnimeStatus status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [status],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> statusLessThan(
    AnimeStatus status, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [],
        upper: [status],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> statusBetween(
    AnimeStatus lowerStatus,
    AnimeStatus upperStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [lowerStatus],
        includeLower: includeLower,
        upper: [upperStatus],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleNotEqualTo(String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [title],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [],
        upper: [title],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [lowerTitle],
        includeLower: includeLower,
        upper: [upperTitle],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleStartsWith(
      String TitlePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [TitlePrefix],
        upper: ['$TitlePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [''],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaEqualTo(
      String titleKana) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titleKana',
        value: [titleKana],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaNotEqualTo(
      String titleKana) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleKana',
              lower: [],
              upper: [titleKana],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleKana',
              lower: [titleKana],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleKana',
              lower: [titleKana],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleKana',
              lower: [],
              upper: [titleKana],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaGreaterThan(
    String titleKana, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleKana',
        lower: [titleKana],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaLessThan(
    String titleKana, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleKana',
        lower: [],
        upper: [titleKana],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaBetween(
    String lowerTitleKana,
    String upperTitleKana, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleKana',
        lower: [lowerTitleKana],
        includeLower: includeLower,
        upper: [upperTitleKana],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaStartsWith(
      String TitleKanaPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleKana',
        lower: [TitleKanaPrefix],
        upper: ['$TitleKanaPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titleKana',
        value: [''],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> titleKanaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titleKana',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titleKana',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titleKana',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titleKana',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> updateAtEqualTo(
      DateTime updateAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updateAt',
        value: [updateAt],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> updateAtNotEqualTo(
      DateTime updateAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateAt',
              lower: [],
              upper: [updateAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateAt',
              lower: [updateAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateAt',
              lower: [updateAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateAt',
              lower: [],
              upper: [updateAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> updateAtGreaterThan(
    DateTime updateAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updateAt',
        lower: [updateAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> updateAtLessThan(
    DateTime updateAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updateAt',
        lower: [],
        upper: [updateAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> updateAtBetween(
    DateTime lowerUpdateAt,
    DateTime upperUpdateAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updateAt',
        lower: [lowerUpdateAt],
        includeLower: includeLower,
        upper: [upperUpdateAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> onAirYearEqualTo(
      int onAirYear) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'onAirYear',
        value: [onAirYear],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> onAirYearNotEqualTo(
      int onAirYear) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onAirYear',
              lower: [],
              upper: [onAirYear],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onAirYear',
              lower: [onAirYear],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onAirYear',
              lower: [onAirYear],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'onAirYear',
              lower: [],
              upper: [onAirYear],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> onAirYearGreaterThan(
    int onAirYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'onAirYear',
        lower: [onAirYear],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> onAirYearLessThan(
    int onAirYear, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'onAirYear',
        lower: [],
        upper: [onAirYear],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> onAirYearBetween(
    int lowerOnAirYear,
    int upperOnAirYear, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'onAirYear',
        lower: [lowerOnAirYear],
        includeLower: includeLower,
        upper: [upperOnAirYear],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> episodeEqualTo(int episode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'episode',
        value: [episode],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> episodeNotEqualTo(int episode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'episode',
              lower: [],
              upper: [episode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'episode',
              lower: [episode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'episode',
              lower: [episode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'episode',
              lower: [],
              upper: [episode],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> episodeGreaterThan(
    int episode, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'episode',
        lower: [episode],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> episodeLessThan(
    int episode, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'episode',
        lower: [],
        upper: [episode],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> episodeBetween(
    int lowerEpisode,
    int upperEpisode, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'episode',
        lower: [lowerEpisode],
        includeLower: includeLower,
        upper: [upperEpisode],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> evaluationEqualTo(
      int evaluation) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'evaluation',
        value: [evaluation],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> evaluationNotEqualTo(
      int evaluation) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'evaluation',
              lower: [],
              upper: [evaluation],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'evaluation',
              lower: [evaluation],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'evaluation',
              lower: [evaluation],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'evaluation',
              lower: [],
              upper: [evaluation],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> evaluationGreaterThan(
    int evaluation, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'evaluation',
        lower: [evaluation],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> evaluationLessThan(
    int evaluation, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'evaluation',
        lower: [],
        upper: [evaluation],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterWhereClause> evaluationBetween(
    int lowerEvaluation,
    int upperEvaluation, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'evaluation',
        lower: [lowerEvaluation],
        includeLower: includeLower,
        upper: [upperEvaluation],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnimeQueryFilter on QueryBuilder<Anime, Anime, QFilterCondition> {
  QueryBuilder<Anime, Anime, QAfterFilterCondition> durationMinutesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> durationMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> durationMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> durationMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episode',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episode',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episode',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> episodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> evaluationEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'evaluation',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> evaluationGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'evaluation',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> evaluationLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'evaluation',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> evaluationBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'evaluation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> onAirYearEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onAirYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> onAirYearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onAirYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> onAirYearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onAirYear',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> onAirYearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onAirYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> seasonEqualTo(
      OnAirSeason value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'season',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> seasonGreaterThan(
    OnAirSeason value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'season',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> seasonLessThan(
    OnAirSeason value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'season',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> seasonBetween(
    OnAirSeason lower,
    OnAirSeason upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'season',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusEqualTo(
      AnimeStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusGreaterThan(
    AnimeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusLessThan(
    AnimeStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> statusBetween(
    AnimeStatus lower,
    AnimeStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleKana',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleKana',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleKana',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleKana',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> titleKanaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleKana',
        value: '',
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> updateAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> updateAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> updateAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> updateAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnimeQueryObject on QueryBuilder<Anime, Anime, QFilterCondition> {}

extension AnimeQueryLinks on QueryBuilder<Anime, Anime, QFilterCondition> {
  QueryBuilder<Anime, Anime, QAfterFilterCondition> genres(
      FilterQuery<Genre> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'genres');
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'genres', length, true, length, true);
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'genres', 0, true, 0, true);
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'genres', 0, false, 999999, true);
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'genres', 0, true, length, include);
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'genres', length, include, 999999, true);
    });
  }

  QueryBuilder<Anime, Anime, QAfterFilterCondition> genresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'genres', lower, includeLower, upper, includeUpper);
    });
  }
}

extension AnimeQuerySortBy on QueryBuilder<Anime, Anime, QSortBy> {
  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByEpisode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episode', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByEpisodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episode', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByEvaluation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluation', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByEvaluationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluation', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByOnAirYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onAirYear', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByOnAirYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onAirYear', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitleKana() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKana', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByTitleKanaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKana', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> sortByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }
}

extension AnimeQuerySortThenBy on QueryBuilder<Anime, Anime, QSortThenBy> {
  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMinutes', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByEpisode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episode', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByEpisodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episode', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByEvaluation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluation', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByEvaluationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluation', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByOnAirYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onAirYear', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByOnAirYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onAirYear', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitleKana() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKana', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByTitleKanaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titleKana', Sort.desc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.asc);
    });
  }

  QueryBuilder<Anime, Anime, QAfterSortBy> thenByUpdateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateAt', Sort.desc);
    });
  }
}

extension AnimeQueryWhereDistinct on QueryBuilder<Anime, Anime, QDistinct> {
  QueryBuilder<Anime, Anime, QDistinct> distinctByDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMinutes');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByEpisode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episode');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByEvaluation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'evaluation');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByOnAirYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onAirYear');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'season');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByTitleKana(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleKana', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Anime, Anime, QDistinct> distinctByUpdateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateAt');
    });
  }
}

extension AnimeQueryProperty on QueryBuilder<Anime, Anime, QQueryProperty> {
  QueryBuilder<Anime, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Anime, int, QQueryOperations> durationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMinutes');
    });
  }

  QueryBuilder<Anime, int, QQueryOperations> episodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episode');
    });
  }

  QueryBuilder<Anime, int, QQueryOperations> evaluationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evaluation');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<Anime, int, QQueryOperations> onAirYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onAirYear');
    });
  }

  QueryBuilder<Anime, OnAirSeason, QQueryOperations> seasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'season');
    });
  }

  QueryBuilder<Anime, AnimeStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Anime, String, QQueryOperations> titleKanaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleKana');
    });
  }

  QueryBuilder<Anime, DateTime, QQueryOperations> updateAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateAt');
    });
  }
}
