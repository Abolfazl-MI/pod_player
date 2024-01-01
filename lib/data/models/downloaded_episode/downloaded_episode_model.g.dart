// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_episode_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDownloadedEpisodeModelCollection on Isar {
  IsarCollection<DownloadedEpisodeModel> get downloadedEpisodeModels =>
      this.collection();
}

const DownloadedEpisodeModelSchema = CollectionSchema(
  name: r'DownloadedEpisodeModel',
  id: -3095293571393116351,
  properties: {
    r'downloadLink': PropertySchema(
      id: 0,
      name: r'downloadLink',
      type: IsarType.string,
    ),
    r'episodeTitle': PropertySchema(
      id: 1,
      name: r'episodeTitle',
      type: IsarType.string,
    ),
    r'fileDir': PropertySchema(
      id: 2,
      name: r'fileDir',
      type: IsarType.string,
    ),
    r'fileName': PropertySchema(
      id: 3,
      name: r'fileName',
      type: IsarType.string,
    )
  },
  estimateSize: _downloadedEpisodeModelEstimateSize,
  serialize: _downloadedEpisodeModelSerialize,
  deserialize: _downloadedEpisodeModelDeserialize,
  deserializeProp: _downloadedEpisodeModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _downloadedEpisodeModelGetId,
  getLinks: _downloadedEpisodeModelGetLinks,
  attach: _downloadedEpisodeModelAttach,
  version: '3.1.0+1',
);

int _downloadedEpisodeModelEstimateSize(
  DownloadedEpisodeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.downloadLink.length * 3;
  bytesCount += 3 + object.episodeTitle.length * 3;
  {
    final value = object.fileDir;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fileName.length * 3;
  return bytesCount;
}

void _downloadedEpisodeModelSerialize(
  DownloadedEpisodeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.downloadLink);
  writer.writeString(offsets[1], object.episodeTitle);
  writer.writeString(offsets[2], object.fileDir);
  writer.writeString(offsets[3], object.fileName);
}

DownloadedEpisodeModel _downloadedEpisodeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DownloadedEpisodeModel(
    downloadLink: reader.readString(offsets[0]),
    fileDir: reader.readStringOrNull(offsets[2]),
    fileName: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _downloadedEpisodeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _downloadedEpisodeModelGetId(DownloadedEpisodeModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _downloadedEpisodeModelGetLinks(
    DownloadedEpisodeModel object) {
  return [];
}

void _downloadedEpisodeModelAttach(
    IsarCollection<dynamic> col, Id id, DownloadedEpisodeModel object) {
  object.id = id;
}

extension DownloadedEpisodeModelQueryWhereSort
    on QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QWhere> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DownloadedEpisodeModelQueryWhere on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QWhereClause> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterWhereClause> idBetween(
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

extension DownloadedEpisodeModelQueryFilter on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QFilterCondition> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downloadLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      downloadLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'downloadLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      downloadLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'downloadLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> downloadLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'downloadLink',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'episodeTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      episodeTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'episodeTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      episodeTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'episodeTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'episodeTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> episodeTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'episodeTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fileDir',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fileDir',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileDir',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      fileDirContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileDir',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      fileDirMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileDir',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileDir',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileDirIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileDir',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fileName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      fileNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fileName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
          QAfterFilterCondition>
      fileNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fileName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> fileNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fileName',
        value: '',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel,
      QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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
}

extension DownloadedEpisodeModelQueryObject on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QFilterCondition> {}

extension DownloadedEpisodeModelQueryLinks on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QFilterCondition> {}

extension DownloadedEpisodeModelQuerySortBy
    on QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QSortBy> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByEpisodeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByEpisodeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByFileDir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDir', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByFileDirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDir', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      sortByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }
}

extension DownloadedEpisodeModelQuerySortThenBy on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QSortThenBy> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByDownloadLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByDownloadLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downloadLink', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByEpisodeTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeTitle', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByEpisodeTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'episodeTitle', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByFileDir() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDir', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByFileDirDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileDir', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByFileName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByFileNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fileName', Sort.desc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension DownloadedEpisodeModelQueryWhereDistinct
    on QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QDistinct> {
  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QDistinct>
      distinctByDownloadLink({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downloadLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QDistinct>
      distinctByEpisodeTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'episodeTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QDistinct>
      distinctByFileDir({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileDir', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DownloadedEpisodeModel, DownloadedEpisodeModel, QDistinct>
      distinctByFileName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fileName', caseSensitive: caseSensitive);
    });
  }
}

extension DownloadedEpisodeModelQueryProperty on QueryBuilder<
    DownloadedEpisodeModel, DownloadedEpisodeModel, QQueryProperty> {
  QueryBuilder<DownloadedEpisodeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DownloadedEpisodeModel, String, QQueryOperations>
      downloadLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downloadLink');
    });
  }

  QueryBuilder<DownloadedEpisodeModel, String, QQueryOperations>
      episodeTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'episodeTitle');
    });
  }

  QueryBuilder<DownloadedEpisodeModel, String?, QQueryOperations>
      fileDirProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileDir');
    });
  }

  QueryBuilder<DownloadedEpisodeModel, String, QQueryOperations>
      fileNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fileName');
    });
  }
}
