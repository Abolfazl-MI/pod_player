// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubscriptionModelCollection on Isar {
  IsarCollection<SubscriptionModel> get subscriptionModels => this.collection();
}

const SubscriptionModelSchema = CollectionSchema(
  name: r'SubscriptionModel',
  id: 1910962846492805114,
  properties: {
    r'artWorkUrl': PropertySchema(
      id: 0,
      name: r'artWorkUrl',
      type: IsarType.string,
    ),
    r'subscriptionUrl': PropertySchema(
      id: 1,
      name: r'subscriptionUrl',
      type: IsarType.string,
    ),
    r'trackName': PropertySchema(
      id: 2,
      name: r'trackName',
      type: IsarType.string,
    )
  },
  estimateSize: _subscriptionModelEstimateSize,
  serialize: _subscriptionModelSerialize,
  deserialize: _subscriptionModelDeserialize,
  deserializeProp: _subscriptionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _subscriptionModelGetId,
  getLinks: _subscriptionModelGetLinks,
  attach: _subscriptionModelAttach,
  version: '3.1.0+1',
);

int _subscriptionModelEstimateSize(
  SubscriptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.artWorkUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subscriptionUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trackName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _subscriptionModelSerialize(
  SubscriptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.artWorkUrl);
  writer.writeString(offsets[1], object.subscriptionUrl);
  writer.writeString(offsets[2], object.trackName);
}

SubscriptionModel _subscriptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubscriptionModel(
    artWorkUrl: reader.readStringOrNull(offsets[0]),
    subscriptionUrl: reader.readStringOrNull(offsets[1]),
    trackName: reader.readStringOrNull(offsets[2]),
  );
  object.id = id;
  return object;
}

P _subscriptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subscriptionModelGetId(SubscriptionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subscriptionModelGetLinks(
    SubscriptionModel object) {
  return [];
}

void _subscriptionModelAttach(
    IsarCollection<dynamic> col, Id id, SubscriptionModel object) {
  object.id = id;
}

extension SubscriptionModelQueryWhereSort
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QWhere> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SubscriptionModelQueryWhere
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QWhereClause> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idBetween(
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
}

extension SubscriptionModelQueryFilter
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artWorkUrl',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artWorkUrl',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artWorkUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artWorkUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artWorkUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artWorkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      artWorkUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artWorkUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subscriptionUrl',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subscriptionUrl',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subscriptionUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subscriptionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subscriptionUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subscriptionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      subscriptionUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subscriptionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackName',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackName',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackName',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trackNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackName',
        value: '',
      ));
    });
  }
}

extension SubscriptionModelQueryObject
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {}

extension SubscriptionModelQueryLinks
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {}

extension SubscriptionModelQuerySortBy
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QSortBy> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByArtWorkUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artWorkUrl', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByArtWorkUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artWorkUrl', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortBySubscriptionUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUrl', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortBySubscriptionUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUrl', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByTrackName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackName', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByTrackNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackName', Sort.desc);
    });
  }
}

extension SubscriptionModelQuerySortThenBy
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QSortThenBy> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByArtWorkUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artWorkUrl', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByArtWorkUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artWorkUrl', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenBySubscriptionUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUrl', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenBySubscriptionUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subscriptionUrl', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByTrackName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackName', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByTrackNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackName', Sort.desc);
    });
  }
}

extension SubscriptionModelQueryWhereDistinct
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByArtWorkUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artWorkUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctBySubscriptionUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subscriptionUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByTrackName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackName', caseSensitive: caseSensitive);
    });
  }
}

extension SubscriptionModelQueryProperty
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QQueryProperty> {
  QueryBuilder<SubscriptionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      artWorkUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artWorkUrl');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      subscriptionUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subscriptionUrl');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      trackNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackName');
    });
  }
}
