// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class RendezVousStruct extends FFFirebaseStruct {
  RendezVousStruct({
    String? nomPatient,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _nomPatient = nomPatient,
        super(firestoreUtilData);

  // "nom_patient" field.
  String? _nomPatient;
  String get nomPatient => _nomPatient ?? '';
  set nomPatient(String? val) => _nomPatient = val;

  bool hasNomPatient() => _nomPatient != null;

  static RendezVousStruct fromMap(Map<String, dynamic> data) =>
      RendezVousStruct(
        nomPatient: data['nom_patient'] as String?,
      );

  static RendezVousStruct? maybeFromMap(dynamic data) => data is Map
      ? RendezVousStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'nom_patient': _nomPatient,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'nom_patient': serializeParam(
          _nomPatient,
          ParamType.String,
        ),
      }.withoutNulls;

  static RendezVousStruct fromSerializableMap(Map<String, dynamic> data) =>
      RendezVousStruct(
        nomPatient: deserializeParam(
          data['nom_patient'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RendezVousStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RendezVousStruct && nomPatient == other.nomPatient;
  }

  @override
  int get hashCode => const ListEquality().hash([nomPatient]);
}

RendezVousStruct createRendezVousStruct({
  String? nomPatient,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RendezVousStruct(
      nomPatient: nomPatient,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RendezVousStruct? updateRendezVousStruct(
  RendezVousStruct? rendezVous, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    rendezVous
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRendezVousStructData(
  Map<String, dynamic> firestoreData,
  RendezVousStruct? rendezVous,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (rendezVous == null) {
    return;
  }
  if (rendezVous.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && rendezVous.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final rendezVousData = getRendezVousFirestoreData(rendezVous, forFieldValue);
  final nestedData = rendezVousData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = rendezVous.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRendezVousFirestoreData(
  RendezVousStruct? rendezVous, [
  bool forFieldValue = false,
]) {
  if (rendezVous == null) {
    return {};
  }
  final firestoreData = mapToFirestore(rendezVous.toMap());

  // Add any Firestore field values
  mapToFirestore(rendezVous.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRendezVousListFirestoreData(
  List<RendezVousStruct>? rendezVouss,
) =>
    rendezVouss?.map((e) => getRendezVousFirestoreData(e, true)).toList() ?? [];
