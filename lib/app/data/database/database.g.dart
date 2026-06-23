// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RecordingsTable extends Recordings
    with TableInfo<$RecordingsTable, Recording> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clientCodeMeta =
      const VerificationMeta('clientCode');
  @override
  late final GeneratedColumn<String> clientCode = GeneratedColumn<String>(
      'client_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _totalDurationMsMeta =
      const VerificationMeta('totalDurationMs');
  @override
  late final GeneratedColumn<int> totalDurationMs = GeneratedColumn<int>(
      'total_duration_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalPartsMeta =
      const VerificationMeta('totalParts');
  @override
  late final GeneratedColumn<int> totalParts = GeneratedColumn<int>(
      'total_parts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _computedHashKeyMeta =
      const VerificationMeta('computedHashKey');
  @override
  late final GeneratedColumn<String> computedHashKey = GeneratedColumn<String>(
      'computed_hash_key', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _metadataJsonMeta =
      const VerificationMeta('metadataJson');
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
      'metadata_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        mode,
        status,
        clientCode,
        createdAt,
        updatedAt,
        totalDurationMs,
        totalParts,
        computedHashKey,
        metadataJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recordings';
  @override
  VerificationContext validateIntegrity(Insertable<Recording> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('client_code')) {
      context.handle(
          _clientCodeMeta,
          clientCode.isAcceptableOrUnknown(
              data['client_code']!, _clientCodeMeta));
    } else if (isInserting) {
      context.missing(_clientCodeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('total_duration_ms')) {
      context.handle(
          _totalDurationMsMeta,
          totalDurationMs.isAcceptableOrUnknown(
              data['total_duration_ms']!, _totalDurationMsMeta));
    }
    if (data.containsKey('total_parts')) {
      context.handle(
          _totalPartsMeta,
          totalParts.isAcceptableOrUnknown(
              data['total_parts']!, _totalPartsMeta));
    }
    if (data.containsKey('computed_hash_key')) {
      context.handle(
          _computedHashKeyMeta,
          computedHashKey.isAcceptableOrUnknown(
              data['computed_hash_key']!, _computedHashKeyMeta));
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
          _metadataJsonMeta,
          metadataJson.isAcceptableOrUnknown(
              data['metadata_json']!, _metadataJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recording map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recording(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      clientCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_code'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      totalDurationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_duration_ms'])!,
      totalParts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_parts'])!,
      computedHashKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}computed_hash_key']),
      metadataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_json']),
    );
  }

  @override
  $RecordingsTable createAlias(String alias) {
    return $RecordingsTable(attachedDatabase, alias);
  }
}

class Recording extends DataClass implements Insertable<Recording> {
  final String id;
  final String title;
  final String mode;
  final String status;
  final String clientCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalDurationMs;
  final int totalParts;
  final String? computedHashKey;
  final String? metadataJson;
  const Recording(
      {required this.id,
      required this.title,
      required this.mode,
      required this.status,
      required this.clientCode,
      required this.createdAt,
      required this.updatedAt,
      required this.totalDurationMs,
      required this.totalParts,
      this.computedHashKey,
      this.metadataJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['mode'] = Variable<String>(mode);
    map['status'] = Variable<String>(status);
    map['client_code'] = Variable<String>(clientCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['total_duration_ms'] = Variable<int>(totalDurationMs);
    map['total_parts'] = Variable<int>(totalParts);
    if (!nullToAbsent || computedHashKey != null) {
      map['computed_hash_key'] = Variable<String>(computedHashKey);
    }
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  RecordingsCompanion toCompanion(bool nullToAbsent) {
    return RecordingsCompanion(
      id: Value(id),
      title: Value(title),
      mode: Value(mode),
      status: Value(status),
      clientCode: Value(clientCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      totalDurationMs: Value(totalDurationMs),
      totalParts: Value(totalParts),
      computedHashKey: computedHashKey == null && nullToAbsent
          ? const Value.absent()
          : Value(computedHashKey),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory Recording.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recording(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      mode: serializer.fromJson<String>(json['mode']),
      status: serializer.fromJson<String>(json['status']),
      clientCode: serializer.fromJson<String>(json['clientCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      totalDurationMs: serializer.fromJson<int>(json['totalDurationMs']),
      totalParts: serializer.fromJson<int>(json['totalParts']),
      computedHashKey: serializer.fromJson<String?>(json['computedHashKey']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'mode': serializer.toJson<String>(mode),
      'status': serializer.toJson<String>(status),
      'clientCode': serializer.toJson<String>(clientCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'totalDurationMs': serializer.toJson<int>(totalDurationMs),
      'totalParts': serializer.toJson<int>(totalParts),
      'computedHashKey': serializer.toJson<String?>(computedHashKey),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  Recording copyWith(
          {String? id,
          String? title,
          String? mode,
          String? status,
          String? clientCode,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? totalDurationMs,
          int? totalParts,
          Value<String?> computedHashKey = const Value.absent(),
          Value<String?> metadataJson = const Value.absent()}) =>
      Recording(
        id: id ?? this.id,
        title: title ?? this.title,
        mode: mode ?? this.mode,
        status: status ?? this.status,
        clientCode: clientCode ?? this.clientCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalDurationMs: totalDurationMs ?? this.totalDurationMs,
        totalParts: totalParts ?? this.totalParts,
        computedHashKey: computedHashKey.present
            ? computedHashKey.value
            : this.computedHashKey,
        metadataJson:
            metadataJson.present ? metadataJson.value : this.metadataJson,
      );
  Recording copyWithCompanion(RecordingsCompanion data) {
    return Recording(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      mode: data.mode.present ? data.mode.value : this.mode,
      status: data.status.present ? data.status.value : this.status,
      clientCode:
          data.clientCode.present ? data.clientCode.value : this.clientCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      totalDurationMs: data.totalDurationMs.present
          ? data.totalDurationMs.value
          : this.totalDurationMs,
      totalParts:
          data.totalParts.present ? data.totalParts.value : this.totalParts,
      computedHashKey: data.computedHashKey.present
          ? data.computedHashKey.value
          : this.computedHashKey,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recording(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('mode: $mode, ')
          ..write('status: $status, ')
          ..write('clientCode: $clientCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('totalDurationMs: $totalDurationMs, ')
          ..write('totalParts: $totalParts, ')
          ..write('computedHashKey: $computedHashKey, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      mode,
      status,
      clientCode,
      createdAt,
      updatedAt,
      totalDurationMs,
      totalParts,
      computedHashKey,
      metadataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recording &&
          other.id == this.id &&
          other.title == this.title &&
          other.mode == this.mode &&
          other.status == this.status &&
          other.clientCode == this.clientCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.totalDurationMs == this.totalDurationMs &&
          other.totalParts == this.totalParts &&
          other.computedHashKey == this.computedHashKey &&
          other.metadataJson == this.metadataJson);
}

class RecordingsCompanion extends UpdateCompanion<Recording> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> mode;
  final Value<String> status;
  final Value<String> clientCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> totalDurationMs;
  final Value<int> totalParts;
  final Value<String?> computedHashKey;
  final Value<String?> metadataJson;
  final Value<int> rowid;
  const RecordingsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.mode = const Value.absent(),
    this.status = const Value.absent(),
    this.clientCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.totalDurationMs = const Value.absent(),
    this.totalParts = const Value.absent(),
    this.computedHashKey = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordingsCompanion.insert({
    required String id,
    required String title,
    required String mode,
    required String status,
    required String clientCode,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.totalDurationMs = const Value.absent(),
    this.totalParts = const Value.absent(),
    this.computedHashKey = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        mode = Value(mode),
        status = Value(status),
        clientCode = Value(clientCode),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Recording> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? mode,
    Expression<String>? status,
    Expression<String>? clientCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? totalDurationMs,
    Expression<int>? totalParts,
    Expression<String>? computedHashKey,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (mode != null) 'mode': mode,
      if (status != null) 'status': status,
      if (clientCode != null) 'client_code': clientCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (totalDurationMs != null) 'total_duration_ms': totalDurationMs,
      if (totalParts != null) 'total_parts': totalParts,
      if (computedHashKey != null) 'computed_hash_key': computedHashKey,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? mode,
      Value<String>? status,
      Value<String>? clientCode,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? totalDurationMs,
      Value<int>? totalParts,
      Value<String?>? computedHashKey,
      Value<String?>? metadataJson,
      Value<int>? rowid}) {
    return RecordingsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      clientCode: clientCode ?? this.clientCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      totalDurationMs: totalDurationMs ?? this.totalDurationMs,
      totalParts: totalParts ?? this.totalParts,
      computedHashKey: computedHashKey ?? this.computedHashKey,
      metadataJson: metadataJson ?? this.metadataJson,
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
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (clientCode.present) {
      map['client_code'] = Variable<String>(clientCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (totalDurationMs.present) {
      map['total_duration_ms'] = Variable<int>(totalDurationMs.value);
    }
    if (totalParts.present) {
      map['total_parts'] = Variable<int>(totalParts.value);
    }
    if (computedHashKey.present) {
      map['computed_hash_key'] = Variable<String>(computedHashKey.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordingsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('mode: $mode, ')
          ..write('status: $status, ')
          ..write('clientCode: $clientCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('totalDurationMs: $totalDurationMs, ')
          ..write('totalParts: $totalParts, ')
          ..write('computedHashKey: $computedHashKey, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SegmentsTable extends Segments with TableInfo<$SegmentsTable, Segment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordingIdMeta =
      const VerificationMeta('recordingId');
  @override
  late final GeneratedColumn<String> recordingId = GeneratedColumn<String>(
      'recording_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recordings (id) ON DELETE CASCADE'));
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _pausedAtMeta =
      const VerificationMeta('pausedAt');
  @override
  late final GeneratedColumn<DateTime> pausedAt = GeneratedColumn<DateTime>(
      'paused_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _resumedAtMeta =
      const VerificationMeta('resumedAt');
  @override
  late final GeneratedColumn<DateTime> resumedAt = GeneratedColumn<DateTime>(
      'resumed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _stoppedAtMeta =
      const VerificationMeta('stoppedAt');
  @override
  late final GeneratedColumn<DateTime> stoppedAt = GeneratedColumn<DateTime>(
      'stopped_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        recordingId,
        index,
        startedAt,
        pausedAt,
        resumedAt,
        stoppedAt,
        filePath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'segments';
  @override
  VerificationContext validateIntegrity(Insertable<Segment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recording_id')) {
      context.handle(
          _recordingIdMeta,
          recordingId.isAcceptableOrUnknown(
              data['recording_id']!, _recordingIdMeta));
    } else if (isInserting) {
      context.missing(_recordingIdMeta);
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('paused_at')) {
      context.handle(_pausedAtMeta,
          pausedAt.isAcceptableOrUnknown(data['paused_at']!, _pausedAtMeta));
    }
    if (data.containsKey('resumed_at')) {
      context.handle(_resumedAtMeta,
          resumedAt.isAcceptableOrUnknown(data['resumed_at']!, _resumedAtMeta));
    }
    if (data.containsKey('stopped_at')) {
      context.handle(_stoppedAtMeta,
          stoppedAt.isAcceptableOrUnknown(data['stopped_at']!, _stoppedAtMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Segment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Segment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      recordingId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_id'])!,
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      pausedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paused_at']),
      resumedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}resumed_at']),
      stoppedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}stopped_at']),
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path']),
    );
  }

  @override
  $SegmentsTable createAlias(String alias) {
    return $SegmentsTable(attachedDatabase, alias);
  }
}

class Segment extends DataClass implements Insertable<Segment> {
  final String id;
  final String recordingId;
  final int index;
  final DateTime startedAt;
  final DateTime? pausedAt;
  final DateTime? resumedAt;
  final DateTime? stoppedAt;
  final String? filePath;
  const Segment(
      {required this.id,
      required this.recordingId,
      required this.index,
      required this.startedAt,
      this.pausedAt,
      this.resumedAt,
      this.stoppedAt,
      this.filePath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recording_id'] = Variable<String>(recordingId);
    map['index'] = Variable<int>(index);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || pausedAt != null) {
      map['paused_at'] = Variable<DateTime>(pausedAt);
    }
    if (!nullToAbsent || resumedAt != null) {
      map['resumed_at'] = Variable<DateTime>(resumedAt);
    }
    if (!nullToAbsent || stoppedAt != null) {
      map['stopped_at'] = Variable<DateTime>(stoppedAt);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    return map;
  }

  SegmentsCompanion toCompanion(bool nullToAbsent) {
    return SegmentsCompanion(
      id: Value(id),
      recordingId: Value(recordingId),
      index: Value(index),
      startedAt: Value(startedAt),
      pausedAt: pausedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedAt),
      resumedAt: resumedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resumedAt),
      stoppedAt: stoppedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(stoppedAt),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
    );
  }

  factory Segment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Segment(
      id: serializer.fromJson<String>(json['id']),
      recordingId: serializer.fromJson<String>(json['recordingId']),
      index: serializer.fromJson<int>(json['index']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      pausedAt: serializer.fromJson<DateTime?>(json['pausedAt']),
      resumedAt: serializer.fromJson<DateTime?>(json['resumedAt']),
      stoppedAt: serializer.fromJson<DateTime?>(json['stoppedAt']),
      filePath: serializer.fromJson<String?>(json['filePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordingId': serializer.toJson<String>(recordingId),
      'index': serializer.toJson<int>(index),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'pausedAt': serializer.toJson<DateTime?>(pausedAt),
      'resumedAt': serializer.toJson<DateTime?>(resumedAt),
      'stoppedAt': serializer.toJson<DateTime?>(stoppedAt),
      'filePath': serializer.toJson<String?>(filePath),
    };
  }

  Segment copyWith(
          {String? id,
          String? recordingId,
          int? index,
          DateTime? startedAt,
          Value<DateTime?> pausedAt = const Value.absent(),
          Value<DateTime?> resumedAt = const Value.absent(),
          Value<DateTime?> stoppedAt = const Value.absent(),
          Value<String?> filePath = const Value.absent()}) =>
      Segment(
        id: id ?? this.id,
        recordingId: recordingId ?? this.recordingId,
        index: index ?? this.index,
        startedAt: startedAt ?? this.startedAt,
        pausedAt: pausedAt.present ? pausedAt.value : this.pausedAt,
        resumedAt: resumedAt.present ? resumedAt.value : this.resumedAt,
        stoppedAt: stoppedAt.present ? stoppedAt.value : this.stoppedAt,
        filePath: filePath.present ? filePath.value : this.filePath,
      );
  Segment copyWithCompanion(SegmentsCompanion data) {
    return Segment(
      id: data.id.present ? data.id.value : this.id,
      recordingId:
          data.recordingId.present ? data.recordingId.value : this.recordingId,
      index: data.index.present ? data.index.value : this.index,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      pausedAt: data.pausedAt.present ? data.pausedAt.value : this.pausedAt,
      resumedAt: data.resumedAt.present ? data.resumedAt.value : this.resumedAt,
      stoppedAt: data.stoppedAt.present ? data.stoppedAt.value : this.stoppedAt,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Segment(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('index: $index, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('resumedAt: $resumedAt, ')
          ..write('stoppedAt: $stoppedAt, ')
          ..write('filePath: $filePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recordingId, index, startedAt, pausedAt,
      resumedAt, stoppedAt, filePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Segment &&
          other.id == this.id &&
          other.recordingId == this.recordingId &&
          other.index == this.index &&
          other.startedAt == this.startedAt &&
          other.pausedAt == this.pausedAt &&
          other.resumedAt == this.resumedAt &&
          other.stoppedAt == this.stoppedAt &&
          other.filePath == this.filePath);
}

class SegmentsCompanion extends UpdateCompanion<Segment> {
  final Value<String> id;
  final Value<String> recordingId;
  final Value<int> index;
  final Value<DateTime> startedAt;
  final Value<DateTime?> pausedAt;
  final Value<DateTime?> resumedAt;
  final Value<DateTime?> stoppedAt;
  final Value<String?> filePath;
  final Value<int> rowid;
  const SegmentsCompanion({
    this.id = const Value.absent(),
    this.recordingId = const Value.absent(),
    this.index = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.pausedAt = const Value.absent(),
    this.resumedAt = const Value.absent(),
    this.stoppedAt = const Value.absent(),
    this.filePath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SegmentsCompanion.insert({
    required String id,
    required String recordingId,
    required int index,
    required DateTime startedAt,
    this.pausedAt = const Value.absent(),
    this.resumedAt = const Value.absent(),
    this.stoppedAt = const Value.absent(),
    this.filePath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        recordingId = Value(recordingId),
        index = Value(index),
        startedAt = Value(startedAt);
  static Insertable<Segment> custom({
    Expression<String>? id,
    Expression<String>? recordingId,
    Expression<int>? index,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? pausedAt,
    Expression<DateTime>? resumedAt,
    Expression<DateTime>? stoppedAt,
    Expression<String>? filePath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordingId != null) 'recording_id': recordingId,
      if (index != null) 'index': index,
      if (startedAt != null) 'started_at': startedAt,
      if (pausedAt != null) 'paused_at': pausedAt,
      if (resumedAt != null) 'resumed_at': resumedAt,
      if (stoppedAt != null) 'stopped_at': stoppedAt,
      if (filePath != null) 'file_path': filePath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SegmentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? recordingId,
      Value<int>? index,
      Value<DateTime>? startedAt,
      Value<DateTime?>? pausedAt,
      Value<DateTime?>? resumedAt,
      Value<DateTime?>? stoppedAt,
      Value<String?>? filePath,
      Value<int>? rowid}) {
    return SegmentsCompanion(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      index: index ?? this.index,
      startedAt: startedAt ?? this.startedAt,
      pausedAt: pausedAt ?? this.pausedAt,
      resumedAt: resumedAt ?? this.resumedAt,
      stoppedAt: stoppedAt ?? this.stoppedAt,
      filePath: filePath ?? this.filePath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordingId.present) {
      map['recording_id'] = Variable<String>(recordingId.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (pausedAt.present) {
      map['paused_at'] = Variable<DateTime>(pausedAt.value);
    }
    if (resumedAt.present) {
      map['resumed_at'] = Variable<DateTime>(resumedAt.value);
    }
    if (stoppedAt.present) {
      map['stopped_at'] = Variable<DateTime>(stoppedAt.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsCompanion(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('index: $index, ')
          ..write('startedAt: $startedAt, ')
          ..write('pausedAt: $pausedAt, ')
          ..write('resumedAt: $resumedAt, ')
          ..write('stoppedAt: $stoppedAt, ')
          ..write('filePath: $filePath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UploadChunksTable extends UploadChunks
    with TableInfo<$UploadChunksTable, UploadChunk> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UploadChunksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordingIdMeta =
      const VerificationMeta('recordingId');
  @override
  late final GeneratedColumn<String> recordingId = GeneratedColumn<String>(
      'recording_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recordings (id) ON DELETE CASCADE'));
  static const VerificationMeta _segmentIdMeta =
      const VerificationMeta('segmentId');
  @override
  late final GeneratedColumn<String> segmentId = GeneratedColumn<String>(
      'segment_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES segments (id) ON DELETE CASCADE'));
  static const VerificationMeta _sequenceMeta =
      const VerificationMeta('sequence');
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
      'sequence', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startCipherIndexMeta =
      const VerificationMeta('startCipherIndex');
  @override
  late final GeneratedColumn<int> startCipherIndex = GeneratedColumn<int>(
      'start_cipher_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endCipherIndexMeta =
      const VerificationMeta('endCipherIndex');
  @override
  late final GeneratedColumn<int> endCipherIndex = GeneratedColumn<int>(
      'end_cipher_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _encryptedFilePathMeta =
      const VerificationMeta('encryptedFilePath');
  @override
  late final GeneratedColumn<String> encryptedFilePath =
      GeneratedColumn<String>('encrypted_file_path', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeBytesMeta =
      const VerificationMeta('sizeBytes');
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
      'size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
      'hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        recordingId,
        segmentId,
        sequence,
        startCipherIndex,
        endCipherIndex,
        status,
        retryCount,
        encryptedFilePath,
        sizeBytes,
        hash,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'upload_chunks';
  @override
  VerificationContext validateIntegrity(Insertable<UploadChunk> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recording_id')) {
      context.handle(
          _recordingIdMeta,
          recordingId.isAcceptableOrUnknown(
              data['recording_id']!, _recordingIdMeta));
    } else if (isInserting) {
      context.missing(_recordingIdMeta);
    }
    if (data.containsKey('segment_id')) {
      context.handle(_segmentIdMeta,
          segmentId.isAcceptableOrUnknown(data['segment_id']!, _segmentIdMeta));
    }
    if (data.containsKey('sequence')) {
      context.handle(_sequenceMeta,
          sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta));
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('start_cipher_index')) {
      context.handle(
          _startCipherIndexMeta,
          startCipherIndex.isAcceptableOrUnknown(
              data['start_cipher_index']!, _startCipherIndexMeta));
    } else if (isInserting) {
      context.missing(_startCipherIndexMeta);
    }
    if (data.containsKey('end_cipher_index')) {
      context.handle(
          _endCipherIndexMeta,
          endCipherIndex.isAcceptableOrUnknown(
              data['end_cipher_index']!, _endCipherIndexMeta));
    } else if (isInserting) {
      context.missing(_endCipherIndexMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('encrypted_file_path')) {
      context.handle(
          _encryptedFilePathMeta,
          encryptedFilePath.isAcceptableOrUnknown(
              data['encrypted_file_path']!, _encryptedFilePathMeta));
    }
    if (data.containsKey('size_bytes')) {
      context.handle(_sizeBytesMeta,
          sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta));
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('hash')) {
      context.handle(
          _hashMeta, hash.isAcceptableOrUnknown(data['hash']!, _hashMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {recordingId, sequence},
      ];
  @override
  UploadChunk map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UploadChunk(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      recordingId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_id'])!,
      segmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}segment_id']),
      sequence: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence'])!,
      startCipherIndex: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}start_cipher_index'])!,
      endCipherIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_cipher_index'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      encryptedFilePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}encrypted_file_path']),
      sizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size_bytes'])!,
      hash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hash']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UploadChunksTable createAlias(String alias) {
    return $UploadChunksTable(attachedDatabase, alias);
  }
}

class UploadChunk extends DataClass implements Insertable<UploadChunk> {
  final String id;
  final String recordingId;
  final String? segmentId;
  final int sequence;
  final int startCipherIndex;
  final int endCipherIndex;
  final String status;
  final int retryCount;
  final String? encryptedFilePath;
  final int sizeBytes;
  final String? hash;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UploadChunk(
      {required this.id,
      required this.recordingId,
      this.segmentId,
      required this.sequence,
      required this.startCipherIndex,
      required this.endCipherIndex,
      required this.status,
      required this.retryCount,
      this.encryptedFilePath,
      required this.sizeBytes,
      this.hash,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recording_id'] = Variable<String>(recordingId);
    if (!nullToAbsent || segmentId != null) {
      map['segment_id'] = Variable<String>(segmentId);
    }
    map['sequence'] = Variable<int>(sequence);
    map['start_cipher_index'] = Variable<int>(startCipherIndex);
    map['end_cipher_index'] = Variable<int>(endCipherIndex);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || encryptedFilePath != null) {
      map['encrypted_file_path'] = Variable<String>(encryptedFilePath);
    }
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || hash != null) {
      map['hash'] = Variable<String>(hash);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UploadChunksCompanion toCompanion(bool nullToAbsent) {
    return UploadChunksCompanion(
      id: Value(id),
      recordingId: Value(recordingId),
      segmentId: segmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(segmentId),
      sequence: Value(sequence),
      startCipherIndex: Value(startCipherIndex),
      endCipherIndex: Value(endCipherIndex),
      status: Value(status),
      retryCount: Value(retryCount),
      encryptedFilePath: encryptedFilePath == null && nullToAbsent
          ? const Value.absent()
          : Value(encryptedFilePath),
      sizeBytes: Value(sizeBytes),
      hash: hash == null && nullToAbsent ? const Value.absent() : Value(hash),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UploadChunk.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UploadChunk(
      id: serializer.fromJson<String>(json['id']),
      recordingId: serializer.fromJson<String>(json['recordingId']),
      segmentId: serializer.fromJson<String?>(json['segmentId']),
      sequence: serializer.fromJson<int>(json['sequence']),
      startCipherIndex: serializer.fromJson<int>(json['startCipherIndex']),
      endCipherIndex: serializer.fromJson<int>(json['endCipherIndex']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      encryptedFilePath:
          serializer.fromJson<String?>(json['encryptedFilePath']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      hash: serializer.fromJson<String?>(json['hash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordingId': serializer.toJson<String>(recordingId),
      'segmentId': serializer.toJson<String?>(segmentId),
      'sequence': serializer.toJson<int>(sequence),
      'startCipherIndex': serializer.toJson<int>(startCipherIndex),
      'endCipherIndex': serializer.toJson<int>(endCipherIndex),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'encryptedFilePath': serializer.toJson<String?>(encryptedFilePath),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'hash': serializer.toJson<String?>(hash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UploadChunk copyWith(
          {String? id,
          String? recordingId,
          Value<String?> segmentId = const Value.absent(),
          int? sequence,
          int? startCipherIndex,
          int? endCipherIndex,
          String? status,
          int? retryCount,
          Value<String?> encryptedFilePath = const Value.absent(),
          int? sizeBytes,
          Value<String?> hash = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UploadChunk(
        id: id ?? this.id,
        recordingId: recordingId ?? this.recordingId,
        segmentId: segmentId.present ? segmentId.value : this.segmentId,
        sequence: sequence ?? this.sequence,
        startCipherIndex: startCipherIndex ?? this.startCipherIndex,
        endCipherIndex: endCipherIndex ?? this.endCipherIndex,
        status: status ?? this.status,
        retryCount: retryCount ?? this.retryCount,
        encryptedFilePath: encryptedFilePath.present
            ? encryptedFilePath.value
            : this.encryptedFilePath,
        sizeBytes: sizeBytes ?? this.sizeBytes,
        hash: hash.present ? hash.value : this.hash,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UploadChunk copyWithCompanion(UploadChunksCompanion data) {
    return UploadChunk(
      id: data.id.present ? data.id.value : this.id,
      recordingId:
          data.recordingId.present ? data.recordingId.value : this.recordingId,
      segmentId: data.segmentId.present ? data.segmentId.value : this.segmentId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      startCipherIndex: data.startCipherIndex.present
          ? data.startCipherIndex.value
          : this.startCipherIndex,
      endCipherIndex: data.endCipherIndex.present
          ? data.endCipherIndex.value
          : this.endCipherIndex,
      status: data.status.present ? data.status.value : this.status,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      encryptedFilePath: data.encryptedFilePath.present
          ? data.encryptedFilePath.value
          : this.encryptedFilePath,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      hash: data.hash.present ? data.hash.value : this.hash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UploadChunk(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('segmentId: $segmentId, ')
          ..write('sequence: $sequence, ')
          ..write('startCipherIndex: $startCipherIndex, ')
          ..write('endCipherIndex: $endCipherIndex, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('encryptedFilePath: $encryptedFilePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('hash: $hash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      recordingId,
      segmentId,
      sequence,
      startCipherIndex,
      endCipherIndex,
      status,
      retryCount,
      encryptedFilePath,
      sizeBytes,
      hash,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UploadChunk &&
          other.id == this.id &&
          other.recordingId == this.recordingId &&
          other.segmentId == this.segmentId &&
          other.sequence == this.sequence &&
          other.startCipherIndex == this.startCipherIndex &&
          other.endCipherIndex == this.endCipherIndex &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.encryptedFilePath == this.encryptedFilePath &&
          other.sizeBytes == this.sizeBytes &&
          other.hash == this.hash &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UploadChunksCompanion extends UpdateCompanion<UploadChunk> {
  final Value<String> id;
  final Value<String> recordingId;
  final Value<String?> segmentId;
  final Value<int> sequence;
  final Value<int> startCipherIndex;
  final Value<int> endCipherIndex;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> encryptedFilePath;
  final Value<int> sizeBytes;
  final Value<String?> hash;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UploadChunksCompanion({
    this.id = const Value.absent(),
    this.recordingId = const Value.absent(),
    this.segmentId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.startCipherIndex = const Value.absent(),
    this.endCipherIndex = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.encryptedFilePath = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.hash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UploadChunksCompanion.insert({
    required String id,
    required String recordingId,
    this.segmentId = const Value.absent(),
    required int sequence,
    required int startCipherIndex,
    required int endCipherIndex,
    required String status,
    this.retryCount = const Value.absent(),
    this.encryptedFilePath = const Value.absent(),
    required int sizeBytes,
    this.hash = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        recordingId = Value(recordingId),
        sequence = Value(sequence),
        startCipherIndex = Value(startCipherIndex),
        endCipherIndex = Value(endCipherIndex),
        status = Value(status),
        sizeBytes = Value(sizeBytes),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UploadChunk> custom({
    Expression<String>? id,
    Expression<String>? recordingId,
    Expression<String>? segmentId,
    Expression<int>? sequence,
    Expression<int>? startCipherIndex,
    Expression<int>? endCipherIndex,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? encryptedFilePath,
    Expression<int>? sizeBytes,
    Expression<String>? hash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordingId != null) 'recording_id': recordingId,
      if (segmentId != null) 'segment_id': segmentId,
      if (sequence != null) 'sequence': sequence,
      if (startCipherIndex != null) 'start_cipher_index': startCipherIndex,
      if (endCipherIndex != null) 'end_cipher_index': endCipherIndex,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (encryptedFilePath != null) 'encrypted_file_path': encryptedFilePath,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (hash != null) 'hash': hash,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UploadChunksCompanion copyWith(
      {Value<String>? id,
      Value<String>? recordingId,
      Value<String?>? segmentId,
      Value<int>? sequence,
      Value<int>? startCipherIndex,
      Value<int>? endCipherIndex,
      Value<String>? status,
      Value<int>? retryCount,
      Value<String?>? encryptedFilePath,
      Value<int>? sizeBytes,
      Value<String?>? hash,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UploadChunksCompanion(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      segmentId: segmentId ?? this.segmentId,
      sequence: sequence ?? this.sequence,
      startCipherIndex: startCipherIndex ?? this.startCipherIndex,
      endCipherIndex: endCipherIndex ?? this.endCipherIndex,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      encryptedFilePath: encryptedFilePath ?? this.encryptedFilePath,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      hash: hash ?? this.hash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordingId.present) {
      map['recording_id'] = Variable<String>(recordingId.value);
    }
    if (segmentId.present) {
      map['segment_id'] = Variable<String>(segmentId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (startCipherIndex.present) {
      map['start_cipher_index'] = Variable<int>(startCipherIndex.value);
    }
    if (endCipherIndex.present) {
      map['end_cipher_index'] = Variable<int>(endCipherIndex.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (encryptedFilePath.present) {
      map['encrypted_file_path'] = Variable<String>(encryptedFilePath.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UploadChunksCompanion(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('segmentId: $segmentId, ')
          ..write('sequence: $sequence, ')
          ..write('startCipherIndex: $startCipherIndex, ')
          ..write('endCipherIndex: $endCipherIndex, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('encryptedFilePath: $encryptedFilePath, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('hash: $hash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UploadJobsTable extends UploadJobs
    with TableInfo<$UploadJobsTable, UploadJob> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UploadJobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordingIdMeta =
      const VerificationMeta('recordingId');
  @override
  late final GeneratedColumn<String> recordingId = GeneratedColumn<String>(
      'recording_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES recordings (id) ON DELETE CASCADE'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalChunksMeta =
      const VerificationMeta('totalChunks');
  @override
  late final GeneratedColumn<int> totalChunks = GeneratedColumn<int>(
      'total_chunks', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _uploadedChunksMeta =
      const VerificationMeta('uploadedChunks');
  @override
  late final GeneratedColumn<int> uploadedChunks = GeneratedColumn<int>(
      'uploaded_chunks', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastAttemptAtMeta =
      const VerificationMeta('lastAttemptAt');
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>('last_attempt_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        recordingId,
        status,
        totalChunks,
        uploadedChunks,
        lastAttemptAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'upload_jobs';
  @override
  VerificationContext validateIntegrity(Insertable<UploadJob> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recording_id')) {
      context.handle(
          _recordingIdMeta,
          recordingId.isAcceptableOrUnknown(
              data['recording_id']!, _recordingIdMeta));
    } else if (isInserting) {
      context.missing(_recordingIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('total_chunks')) {
      context.handle(
          _totalChunksMeta,
          totalChunks.isAcceptableOrUnknown(
              data['total_chunks']!, _totalChunksMeta));
    } else if (isInserting) {
      context.missing(_totalChunksMeta);
    }
    if (data.containsKey('uploaded_chunks')) {
      context.handle(
          _uploadedChunksMeta,
          uploadedChunks.isAcceptableOrUnknown(
              data['uploaded_chunks']!, _uploadedChunksMeta));
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
          _lastAttemptAtMeta,
          lastAttemptAt.isAcceptableOrUnknown(
              data['last_attempt_at']!, _lastAttemptAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UploadJob map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UploadJob(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      recordingId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      totalChunks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_chunks'])!,
      uploadedChunks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uploaded_chunks'])!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_attempt_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UploadJobsTable createAlias(String alias) {
    return $UploadJobsTable(attachedDatabase, alias);
  }
}

class UploadJob extends DataClass implements Insertable<UploadJob> {
  final String id;
  final String recordingId;
  final String status;
  final int totalChunks;
  final int uploadedChunks;
  final DateTime? lastAttemptAt;
  final DateTime createdAt;
  const UploadJob(
      {required this.id,
      required this.recordingId,
      required this.status,
      required this.totalChunks,
      required this.uploadedChunks,
      this.lastAttemptAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recording_id'] = Variable<String>(recordingId);
    map['status'] = Variable<String>(status);
    map['total_chunks'] = Variable<int>(totalChunks);
    map['uploaded_chunks'] = Variable<int>(uploadedChunks);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UploadJobsCompanion toCompanion(bool nullToAbsent) {
    return UploadJobsCompanion(
      id: Value(id),
      recordingId: Value(recordingId),
      status: Value(status),
      totalChunks: Value(totalChunks),
      uploadedChunks: Value(uploadedChunks),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      createdAt: Value(createdAt),
    );
  }

  factory UploadJob.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UploadJob(
      id: serializer.fromJson<String>(json['id']),
      recordingId: serializer.fromJson<String>(json['recordingId']),
      status: serializer.fromJson<String>(json['status']),
      totalChunks: serializer.fromJson<int>(json['totalChunks']),
      uploadedChunks: serializer.fromJson<int>(json['uploadedChunks']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordingId': serializer.toJson<String>(recordingId),
      'status': serializer.toJson<String>(status),
      'totalChunks': serializer.toJson<int>(totalChunks),
      'uploadedChunks': serializer.toJson<int>(uploadedChunks),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UploadJob copyWith(
          {String? id,
          String? recordingId,
          String? status,
          int? totalChunks,
          int? uploadedChunks,
          Value<DateTime?> lastAttemptAt = const Value.absent(),
          DateTime? createdAt}) =>
      UploadJob(
        id: id ?? this.id,
        recordingId: recordingId ?? this.recordingId,
        status: status ?? this.status,
        totalChunks: totalChunks ?? this.totalChunks,
        uploadedChunks: uploadedChunks ?? this.uploadedChunks,
        lastAttemptAt:
            lastAttemptAt.present ? lastAttemptAt.value : this.lastAttemptAt,
        createdAt: createdAt ?? this.createdAt,
      );
  UploadJob copyWithCompanion(UploadJobsCompanion data) {
    return UploadJob(
      id: data.id.present ? data.id.value : this.id,
      recordingId:
          data.recordingId.present ? data.recordingId.value : this.recordingId,
      status: data.status.present ? data.status.value : this.status,
      totalChunks:
          data.totalChunks.present ? data.totalChunks.value : this.totalChunks,
      uploadedChunks: data.uploadedChunks.present
          ? data.uploadedChunks.value
          : this.uploadedChunks,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UploadJob(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('status: $status, ')
          ..write('totalChunks: $totalChunks, ')
          ..write('uploadedChunks: $uploadedChunks, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recordingId, status, totalChunks,
      uploadedChunks, lastAttemptAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UploadJob &&
          other.id == this.id &&
          other.recordingId == this.recordingId &&
          other.status == this.status &&
          other.totalChunks == this.totalChunks &&
          other.uploadedChunks == this.uploadedChunks &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.createdAt == this.createdAt);
}

class UploadJobsCompanion extends UpdateCompanion<UploadJob> {
  final Value<String> id;
  final Value<String> recordingId;
  final Value<String> status;
  final Value<int> totalChunks;
  final Value<int> uploadedChunks;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UploadJobsCompanion({
    this.id = const Value.absent(),
    this.recordingId = const Value.absent(),
    this.status = const Value.absent(),
    this.totalChunks = const Value.absent(),
    this.uploadedChunks = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UploadJobsCompanion.insert({
    required String id,
    required String recordingId,
    required String status,
    required int totalChunks,
    this.uploadedChunks = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        recordingId = Value(recordingId),
        status = Value(status),
        totalChunks = Value(totalChunks),
        createdAt = Value(createdAt);
  static Insertable<UploadJob> custom({
    Expression<String>? id,
    Expression<String>? recordingId,
    Expression<String>? status,
    Expression<int>? totalChunks,
    Expression<int>? uploadedChunks,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordingId != null) 'recording_id': recordingId,
      if (status != null) 'status': status,
      if (totalChunks != null) 'total_chunks': totalChunks,
      if (uploadedChunks != null) 'uploaded_chunks': uploadedChunks,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UploadJobsCompanion copyWith(
      {Value<String>? id,
      Value<String>? recordingId,
      Value<String>? status,
      Value<int>? totalChunks,
      Value<int>? uploadedChunks,
      Value<DateTime?>? lastAttemptAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return UploadJobsCompanion(
      id: id ?? this.id,
      recordingId: recordingId ?? this.recordingId,
      status: status ?? this.status,
      totalChunks: totalChunks ?? this.totalChunks,
      uploadedChunks: uploadedChunks ?? this.uploadedChunks,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordingId.present) {
      map['recording_id'] = Variable<String>(recordingId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalChunks.present) {
      map['total_chunks'] = Variable<int>(totalChunks.value);
    }
    if (uploadedChunks.present) {
      map['uploaded_chunks'] = Variable<int>(uploadedChunks.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UploadJobsCompanion(')
          ..write('id: $id, ')
          ..write('recordingId: $recordingId, ')
          ..write('status: $status, ')
          ..write('totalChunks: $totalChunks, ')
          ..write('uploadedChunks: $uploadedChunks, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecordingsTable recordings = $RecordingsTable(this);
  late final $SegmentsTable segments = $SegmentsTable(this);
  late final $UploadChunksTable uploadChunks = $UploadChunksTable(this);
  late final $UploadJobsTable uploadJobs = $UploadJobsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [recordings, segments, uploadChunks, uploadJobs];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('recordings',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('segments', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('recordings',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('upload_chunks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('segments',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('upload_chunks', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('recordings',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('upload_jobs', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$RecordingsTableCreateCompanionBuilder = RecordingsCompanion Function({
  required String id,
  required String title,
  required String mode,
  required String status,
  required String clientCode,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> totalDurationMs,
  Value<int> totalParts,
  Value<String?> computedHashKey,
  Value<String?> metadataJson,
  Value<int> rowid,
});
typedef $$RecordingsTableUpdateCompanionBuilder = RecordingsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> mode,
  Value<String> status,
  Value<String> clientCode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> totalDurationMs,
  Value<int> totalParts,
  Value<String?> computedHashKey,
  Value<String?> metadataJson,
  Value<int> rowid,
});

class $$RecordingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecordingsTable,
    Recording,
    $$RecordingsTableFilterComposer,
    $$RecordingsTableOrderingComposer,
    $$RecordingsTableCreateCompanionBuilder,
    $$RecordingsTableUpdateCompanionBuilder> {
  $$RecordingsTableTableManager(_$AppDatabase db, $RecordingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RecordingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RecordingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> clientCode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> totalDurationMs = const Value.absent(),
            Value<int> totalParts = const Value.absent(),
            Value<String?> computedHashKey = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecordingsCompanion(
            id: id,
            title: title,
            mode: mode,
            status: status,
            clientCode: clientCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
            totalDurationMs: totalDurationMs,
            totalParts: totalParts,
            computedHashKey: computedHashKey,
            metadataJson: metadataJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String mode,
            required String status,
            required String clientCode,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> totalDurationMs = const Value.absent(),
            Value<int> totalParts = const Value.absent(),
            Value<String?> computedHashKey = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecordingsCompanion.insert(
            id: id,
            title: title,
            mode: mode,
            status: status,
            clientCode: clientCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
            totalDurationMs: totalDurationMs,
            totalParts: totalParts,
            computedHashKey: computedHashKey,
            metadataJson: metadataJson,
            rowid: rowid,
          ),
        ));
}

class $$RecordingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RecordingsTable> {
  $$RecordingsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get clientCode => $state.composableBuilder(
      column: $state.table.clientCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalDurationMs => $state.composableBuilder(
      column: $state.table.totalDurationMs,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalParts => $state.composableBuilder(
      column: $state.table.totalParts,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get computedHashKey => $state.composableBuilder(
      column: $state.table.computedHashKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get metadataJson => $state.composableBuilder(
      column: $state.table.metadataJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter segmentsRefs(
      ComposableFilter Function($$SegmentsTableFilterComposer f) f) {
    final $$SegmentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.segments,
        getReferencedColumn: (t) => t.recordingId,
        builder: (joinBuilder, parentComposers) =>
            $$SegmentsTableFilterComposer(ComposerState(
                $state.db, $state.db.segments, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter uploadChunksRefs(
      ComposableFilter Function($$UploadChunksTableFilterComposer f) f) {
    final $$UploadChunksTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.uploadChunks,
        getReferencedColumn: (t) => t.recordingId,
        builder: (joinBuilder, parentComposers) =>
            $$UploadChunksTableFilterComposer(ComposerState($state.db,
                $state.db.uploadChunks, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter uploadJobsRefs(
      ComposableFilter Function($$UploadJobsTableFilterComposer f) f) {
    final $$UploadJobsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.uploadJobs,
        getReferencedColumn: (t) => t.recordingId,
        builder: (joinBuilder, parentComposers) =>
            $$UploadJobsTableFilterComposer(ComposerState($state.db,
                $state.db.uploadJobs, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$RecordingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RecordingsTable> {
  $$RecordingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get clientCode => $state.composableBuilder(
      column: $state.table.clientCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalDurationMs => $state.composableBuilder(
      column: $state.table.totalDurationMs,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalParts => $state.composableBuilder(
      column: $state.table.totalParts,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get computedHashKey => $state.composableBuilder(
      column: $state.table.computedHashKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get metadataJson => $state.composableBuilder(
      column: $state.table.metadataJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SegmentsTableCreateCompanionBuilder = SegmentsCompanion Function({
  required String id,
  required String recordingId,
  required int index,
  required DateTime startedAt,
  Value<DateTime?> pausedAt,
  Value<DateTime?> resumedAt,
  Value<DateTime?> stoppedAt,
  Value<String?> filePath,
  Value<int> rowid,
});
typedef $$SegmentsTableUpdateCompanionBuilder = SegmentsCompanion Function({
  Value<String> id,
  Value<String> recordingId,
  Value<int> index,
  Value<DateTime> startedAt,
  Value<DateTime?> pausedAt,
  Value<DateTime?> resumedAt,
  Value<DateTime?> stoppedAt,
  Value<String?> filePath,
  Value<int> rowid,
});

class $$SegmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SegmentsTable,
    Segment,
    $$SegmentsTableFilterComposer,
    $$SegmentsTableOrderingComposer,
    $$SegmentsTableCreateCompanionBuilder,
    $$SegmentsTableUpdateCompanionBuilder> {
  $$SegmentsTableTableManager(_$AppDatabase db, $SegmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SegmentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SegmentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> recordingId = const Value.absent(),
            Value<int> index = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime?> pausedAt = const Value.absent(),
            Value<DateTime?> resumedAt = const Value.absent(),
            Value<DateTime?> stoppedAt = const Value.absent(),
            Value<String?> filePath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SegmentsCompanion(
            id: id,
            recordingId: recordingId,
            index: index,
            startedAt: startedAt,
            pausedAt: pausedAt,
            resumedAt: resumedAt,
            stoppedAt: stoppedAt,
            filePath: filePath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String recordingId,
            required int index,
            required DateTime startedAt,
            Value<DateTime?> pausedAt = const Value.absent(),
            Value<DateTime?> resumedAt = const Value.absent(),
            Value<DateTime?> stoppedAt = const Value.absent(),
            Value<String?> filePath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SegmentsCompanion.insert(
            id: id,
            recordingId: recordingId,
            index: index,
            startedAt: startedAt,
            pausedAt: pausedAt,
            resumedAt: resumedAt,
            stoppedAt: stoppedAt,
            filePath: filePath,
            rowid: rowid,
          ),
        ));
}

class $$SegmentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get pausedAt => $state.composableBuilder(
      column: $state.table.pausedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get resumedAt => $state.composableBuilder(
      column: $state.table.resumedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get stoppedAt => $state.composableBuilder(
      column: $state.table.stoppedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RecordingsTableFilterComposer get recordingId {
    final $$RecordingsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableFilterComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter uploadChunksRefs(
      ComposableFilter Function($$UploadChunksTableFilterComposer f) f) {
    final $$UploadChunksTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.uploadChunks,
        getReferencedColumn: (t) => t.segmentId,
        builder: (joinBuilder, parentComposers) =>
            $$UploadChunksTableFilterComposer(ComposerState($state.db,
                $state.db.uploadChunks, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$SegmentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get startedAt => $state.composableBuilder(
      column: $state.table.startedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get pausedAt => $state.composableBuilder(
      column: $state.table.pausedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get resumedAt => $state.composableBuilder(
      column: $state.table.resumedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get stoppedAt => $state.composableBuilder(
      column: $state.table.stoppedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get filePath => $state.composableBuilder(
      column: $state.table.filePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RecordingsTableOrderingComposer get recordingId {
    final $$RecordingsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableOrderingComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$UploadChunksTableCreateCompanionBuilder = UploadChunksCompanion
    Function({
  required String id,
  required String recordingId,
  Value<String?> segmentId,
  required int sequence,
  required int startCipherIndex,
  required int endCipherIndex,
  required String status,
  Value<int> retryCount,
  Value<String?> encryptedFilePath,
  required int sizeBytes,
  Value<String?> hash,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$UploadChunksTableUpdateCompanionBuilder = UploadChunksCompanion
    Function({
  Value<String> id,
  Value<String> recordingId,
  Value<String?> segmentId,
  Value<int> sequence,
  Value<int> startCipherIndex,
  Value<int> endCipherIndex,
  Value<String> status,
  Value<int> retryCount,
  Value<String?> encryptedFilePath,
  Value<int> sizeBytes,
  Value<String?> hash,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UploadChunksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UploadChunksTable,
    UploadChunk,
    $$UploadChunksTableFilterComposer,
    $$UploadChunksTableOrderingComposer,
    $$UploadChunksTableCreateCompanionBuilder,
    $$UploadChunksTableUpdateCompanionBuilder> {
  $$UploadChunksTableTableManager(_$AppDatabase db, $UploadChunksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UploadChunksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UploadChunksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> recordingId = const Value.absent(),
            Value<String?> segmentId = const Value.absent(),
            Value<int> sequence = const Value.absent(),
            Value<int> startCipherIndex = const Value.absent(),
            Value<int> endCipherIndex = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> encryptedFilePath = const Value.absent(),
            Value<int> sizeBytes = const Value.absent(),
            Value<String?> hash = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UploadChunksCompanion(
            id: id,
            recordingId: recordingId,
            segmentId: segmentId,
            sequence: sequence,
            startCipherIndex: startCipherIndex,
            endCipherIndex: endCipherIndex,
            status: status,
            retryCount: retryCount,
            encryptedFilePath: encryptedFilePath,
            sizeBytes: sizeBytes,
            hash: hash,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String recordingId,
            Value<String?> segmentId = const Value.absent(),
            required int sequence,
            required int startCipherIndex,
            required int endCipherIndex,
            required String status,
            Value<int> retryCount = const Value.absent(),
            Value<String?> encryptedFilePath = const Value.absent(),
            required int sizeBytes,
            Value<String?> hash = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UploadChunksCompanion.insert(
            id: id,
            recordingId: recordingId,
            segmentId: segmentId,
            sequence: sequence,
            startCipherIndex: startCipherIndex,
            endCipherIndex: endCipherIndex,
            status: status,
            retryCount: retryCount,
            encryptedFilePath: encryptedFilePath,
            sizeBytes: sizeBytes,
            hash: hash,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$UploadChunksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UploadChunksTable> {
  $$UploadChunksTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sequence => $state.composableBuilder(
      column: $state.table.sequence,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get startCipherIndex => $state.composableBuilder(
      column: $state.table.startCipherIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get endCipherIndex => $state.composableBuilder(
      column: $state.table.endCipherIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get retryCount => $state.composableBuilder(
      column: $state.table.retryCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get encryptedFilePath => $state.composableBuilder(
      column: $state.table.encryptedFilePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get hash => $state.composableBuilder(
      column: $state.table.hash,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RecordingsTableFilterComposer get recordingId {
    final $$RecordingsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableFilterComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }

  $$SegmentsTableFilterComposer get segmentId {
    final $$SegmentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentId,
        referencedTable: $state.db.segments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SegmentsTableFilterComposer(ComposerState(
                $state.db, $state.db.segments, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UploadChunksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UploadChunksTable> {
  $$UploadChunksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sequence => $state.composableBuilder(
      column: $state.table.sequence,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get startCipherIndex => $state.composableBuilder(
      column: $state.table.startCipherIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get endCipherIndex => $state.composableBuilder(
      column: $state.table.endCipherIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get retryCount => $state.composableBuilder(
      column: $state.table.retryCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get encryptedFilePath => $state.composableBuilder(
      column: $state.table.encryptedFilePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get sizeBytes => $state.composableBuilder(
      column: $state.table.sizeBytes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get hash => $state.composableBuilder(
      column: $state.table.hash,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RecordingsTableOrderingComposer get recordingId {
    final $$RecordingsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableOrderingComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }

  $$SegmentsTableOrderingComposer get segmentId {
    final $$SegmentsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentId,
        referencedTable: $state.db.segments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$SegmentsTableOrderingComposer(ComposerState(
                $state.db, $state.db.segments, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$UploadJobsTableCreateCompanionBuilder = UploadJobsCompanion Function({
  required String id,
  required String recordingId,
  required String status,
  required int totalChunks,
  Value<int> uploadedChunks,
  Value<DateTime?> lastAttemptAt,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UploadJobsTableUpdateCompanionBuilder = UploadJobsCompanion Function({
  Value<String> id,
  Value<String> recordingId,
  Value<String> status,
  Value<int> totalChunks,
  Value<int> uploadedChunks,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UploadJobsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UploadJobsTable,
    UploadJob,
    $$UploadJobsTableFilterComposer,
    $$UploadJobsTableOrderingComposer,
    $$UploadJobsTableCreateCompanionBuilder,
    $$UploadJobsTableUpdateCompanionBuilder> {
  $$UploadJobsTableTableManager(_$AppDatabase db, $UploadJobsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UploadJobsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UploadJobsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> recordingId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> totalChunks = const Value.absent(),
            Value<int> uploadedChunks = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UploadJobsCompanion(
            id: id,
            recordingId: recordingId,
            status: status,
            totalChunks: totalChunks,
            uploadedChunks: uploadedChunks,
            lastAttemptAt: lastAttemptAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String recordingId,
            required String status,
            required int totalChunks,
            Value<int> uploadedChunks = const Value.absent(),
            Value<DateTime?> lastAttemptAt = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UploadJobsCompanion.insert(
            id: id,
            recordingId: recordingId,
            status: status,
            totalChunks: totalChunks,
            uploadedChunks: uploadedChunks,
            lastAttemptAt: lastAttemptAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$UploadJobsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UploadJobsTable> {
  $$UploadJobsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get totalChunks => $state.composableBuilder(
      column: $state.table.totalChunks,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get uploadedChunks => $state.composableBuilder(
      column: $state.table.uploadedChunks,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastAttemptAt => $state.composableBuilder(
      column: $state.table.lastAttemptAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$RecordingsTableFilterComposer get recordingId {
    final $$RecordingsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableFilterComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$UploadJobsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UploadJobsTable> {
  $$UploadJobsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get totalChunks => $state.composableBuilder(
      column: $state.table.totalChunks,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get uploadedChunks => $state.composableBuilder(
      column: $state.table.uploadedChunks,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastAttemptAt => $state.composableBuilder(
      column: $state.table.lastAttemptAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$RecordingsTableOrderingComposer get recordingId {
    final $$RecordingsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.recordingId,
        referencedTable: $state.db.recordings,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$RecordingsTableOrderingComposer(ComposerState($state.db,
                $state.db.recordings, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecordingsTableTableManager get recordings =>
      $$RecordingsTableTableManager(_db, _db.recordings);
  $$SegmentsTableTableManager get segments =>
      $$SegmentsTableTableManager(_db, _db.segments);
  $$UploadChunksTableTableManager get uploadChunks =>
      $$UploadChunksTableTableManager(_db, _db.uploadChunks);
  $$UploadJobsTableTableManager get uploadJobs =>
      $$UploadJobsTableTableManager(_db, _db.uploadJobs);
}
