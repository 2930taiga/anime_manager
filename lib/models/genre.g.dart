// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genre.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGenreCollection on Isar {
  IsarCollection<Genre> get genres => this.collection();
}

const GenreSchema = CollectionSchema(
  name: r'Genre',
  id: -453881181692258612,
  properties: {
    r'blueValue': PropertySchema(
      id: 0,
      name: r'blueValue',
      type: IsarType.long,
    ),
    r'greenValue': PropertySchema(
      id: 1,
      name: r'greenValue',
      type: IsarType.long,
    ),
    r'iconShape': PropertySchema(
      id: 2,
      name: r'iconShape',
      type: IsarType.byte,
      enumMap: _GenreiconShapeEnumValueMap,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'redValue': PropertySchema(
      id: 4,
      name: r'redValue',
      type: IsarType.long,
    )
  },
  estimateSize: _genreEstimateSize,
  serialize: _genreSerialize,
  deserialize: _genreDeserialize,
  deserializeProp: _genreDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'animes': LinkSchema(
      id: 7361645375235155789,
      name: r'animes',
      target: r'Anime',
      single: false,
      linkName: r'genres',
    )
  },
  embeddedSchemas: {},
  getId: _genreGetId,
  getLinks: _genreGetLinks,
  attach: _genreAttach,
  version: '3.1.0+1',
);

int _genreEstimateSize(
  Genre object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _genreSerialize(
  Genre object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.blueValue);
  writer.writeLong(offsets[1], object.greenValue);
  writer.writeByte(offsets[2], object.iconShape.index);
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.redValue);
}

Genre _genreDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Genre();
  object.blueValue = reader.readLong(offsets[0]);
  object.greenValue = reader.readLong(offsets[1]);
  object.iconShape =
      _GenreiconShapeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          IconShape.circle;
  object.id = id;
  object.name = reader.readString(offsets[3]);
  object.redValue = reader.readLong(offsets[4]);
  return object;
}

P _genreDeserializeProp<P>(
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
      return (_GenreiconShapeValueEnumMap[reader.readByteOrNull(offset)] ??
          IconShape.circle) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GenreiconShapeEnumValueMap = {
  'circle': 0,
  'square': 1,
  'triangle': 2,
  'star': 3,
  'x': 4,
  'plus': 5,
};
const _GenreiconShapeValueEnumMap = {
  0: IconShape.circle,
  1: IconShape.square,
  2: IconShape.triangle,
  3: IconShape.star,
  4: IconShape.x,
  5: IconShape.plus,
};

Id _genreGetId(Genre object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _genreGetLinks(Genre object) {
  return [object.animes];
}

void _genreAttach(IsarCollection<dynamic> col, Id id, Genre object) {
  object.id = id;
  object.animes.attach(col, col.isar.collection<Anime>(), r'animes', id);
}

extension GenreByIndex on IsarCollection<Genre> {
  Future<Genre?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  Genre? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<Genre?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<Genre?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(Genre object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(Genre object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<Genre> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(List<Genre> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension GenreQueryWhereSort on QueryBuilder<Genre, Genre, QWhere> {
  QueryBuilder<Genre, Genre, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GenreQueryWhere on QueryBuilder<Genre, Genre, QWhereClause> {
  QueryBuilder<Genre, Genre, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Genre, Genre, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> idBetween(
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

  QueryBuilder<Genre, Genre, QAfterWhereClause> nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterWhereClause> nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension GenreQueryFilter on QueryBuilder<Genre, Genre, QFilterCondition> {
  QueryBuilder<Genre, Genre, QAfterFilterCondition> blueValueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blueValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> blueValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'blueValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> blueValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'blueValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> blueValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'blueValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> greenValueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'greenValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> greenValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'greenValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> greenValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'greenValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> greenValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'greenValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> iconShapeEqualTo(
      IconShape value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconShape',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> iconShapeGreaterThan(
    IconShape value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconShape',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> iconShapeLessThan(
    IconShape value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconShape',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> iconShapeBetween(
    IconShape lower,
    IconShape upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconShape',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Genre, Genre, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> redValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> redValueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'redValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> redValueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'redValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> redValueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'redValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GenreQueryObject on QueryBuilder<Genre, Genre, QFilterCondition> {}

extension GenreQueryLinks on QueryBuilder<Genre, Genre, QFilterCondition> {
  QueryBuilder<Genre, Genre, QAfterFilterCondition> animes(
      FilterQuery<Anime> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'animes');
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'animes', length, true, length, true);
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'animes', 0, true, 0, true);
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'animes', 0, false, 999999, true);
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'animes', 0, true, length, include);
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'animes', length, include, 999999, true);
    });
  }

  QueryBuilder<Genre, Genre, QAfterFilterCondition> animesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'animes', lower, includeLower, upper, includeUpper);
    });
  }
}

extension GenreQuerySortBy on QueryBuilder<Genre, Genre, QSortBy> {
  QueryBuilder<Genre, Genre, QAfterSortBy> sortByBlueValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blueValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByBlueValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blueValue', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByGreenValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByGreenValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenValue', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByIconShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconShape', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByIconShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconShape', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByRedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> sortByRedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redValue', Sort.desc);
    });
  }
}

extension GenreQuerySortThenBy on QueryBuilder<Genre, Genre, QSortThenBy> {
  QueryBuilder<Genre, Genre, QAfterSortBy> thenByBlueValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blueValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByBlueValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blueValue', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByGreenValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByGreenValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenValue', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByIconShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconShape', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByIconShapeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconShape', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByRedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redValue', Sort.asc);
    });
  }

  QueryBuilder<Genre, Genre, QAfterSortBy> thenByRedValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redValue', Sort.desc);
    });
  }
}

extension GenreQueryWhereDistinct on QueryBuilder<Genre, Genre, QDistinct> {
  QueryBuilder<Genre, Genre, QDistinct> distinctByBlueValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blueValue');
    });
  }

  QueryBuilder<Genre, Genre, QDistinct> distinctByGreenValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'greenValue');
    });
  }

  QueryBuilder<Genre, Genre, QDistinct> distinctByIconShape() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconShape');
    });
  }

  QueryBuilder<Genre, Genre, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Genre, Genre, QDistinct> distinctByRedValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'redValue');
    });
  }
}

extension GenreQueryProperty on QueryBuilder<Genre, Genre, QQueryProperty> {
  QueryBuilder<Genre, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Genre, int, QQueryOperations> blueValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blueValue');
    });
  }

  QueryBuilder<Genre, int, QQueryOperations> greenValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'greenValue');
    });
  }

  QueryBuilder<Genre, IconShape, QQueryOperations> iconShapeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconShape');
    });
  }

  QueryBuilder<Genre, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Genre, int, QQueryOperations> redValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'redValue');
    });
  }
}
