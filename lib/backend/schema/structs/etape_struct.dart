// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class EtapeStruct extends FFFirebaseStruct {
  EtapeStruct({
    String? titre,
    String? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _titre = titre,
        _status = status,
        super(firestoreUtilData);

  // "titre" field.
  String? _titre;
  String get titre => _titre ?? '';
  set titre(String? val) => _titre = val;

  bool hasTitre() => _titre != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static EtapeStruct fromMap(Map<String, dynamic> data) => EtapeStruct(
        titre: data['titre'] as String?,
        status: data['status'] as String?,
      );

  static EtapeStruct? maybeFromMap(dynamic data) =>
      data is Map ? EtapeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'titre': _titre,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'titre': serializeParam(
          _titre,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static EtapeStruct fromSerializableMap(Map<String, dynamic> data) =>
      EtapeStruct(
        titre: deserializeParam(
          data['titre'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EtapeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EtapeStruct &&
        titre == other.titre &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([titre, status]);
}

EtapeStruct createEtapeStruct({
  String? titre,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EtapeStruct(
      titre: titre,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EtapeStruct? updateEtapeStruct(
  EtapeStruct? etape, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    etape
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEtapeStructData(
  Map<String, dynamic> firestoreData,
  EtapeStruct? etape,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (etape == null) {
    return;
  }
  if (etape.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && etape.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final etapeData = getEtapeFirestoreData(etape, forFieldValue);
  final nestedData = etapeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = etape.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEtapeFirestoreData(
  EtapeStruct? etape, [
  bool forFieldValue = false,
]) {
  if (etape == null) {
    return {};
  }
  final firestoreData = mapToFirestore(etape.toMap());

  // Add any Firestore field values
  mapToFirestore(etape.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEtapeListFirestoreData(
  List<EtapeStruct>? etapes,
) =>
    etapes?.map((e) => getEtapeFirestoreData(e, true)).toList() ?? [];
