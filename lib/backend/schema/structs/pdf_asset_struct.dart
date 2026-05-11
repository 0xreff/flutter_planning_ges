// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PdfAssetStruct extends FFFirebaseStruct {
  PdfAssetStruct({
    String? id,
    String? link,
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _link = link,
        _name = name,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "link" field.
  String? _link;
  String get link => _link ?? '';
  set link(String? val) => _link = val;

  bool hasLink() => _link != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static PdfAssetStruct fromMap(Map<String, dynamic> data) => PdfAssetStruct(
        id: data['id'] as String?,
        link: data['link'] as String?,
        name: data['name'] as String?,
      );

  static PdfAssetStruct? maybeFromMap(dynamic data) =>
      data is Map ? PdfAssetStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'link': _link,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'link': serializeParam(
          _link,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static PdfAssetStruct fromSerializableMap(Map<String, dynamic> data) =>
      PdfAssetStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        link: deserializeParam(
          data['link'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PdfAssetStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PdfAssetStruct &&
        id == other.id &&
        link == other.link &&
        name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([id, link, name]);
}

PdfAssetStruct createPdfAssetStruct({
  String? id,
  String? link,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PdfAssetStruct(
      id: id,
      link: link,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PdfAssetStruct? updatePdfAssetStruct(
  PdfAssetStruct? pdfAsset, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pdfAsset
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPdfAssetStructData(
  Map<String, dynamic> firestoreData,
  PdfAssetStruct? pdfAsset,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pdfAsset == null) {
    return;
  }
  if (pdfAsset.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pdfAsset.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pdfAssetData = getPdfAssetFirestoreData(pdfAsset, forFieldValue);
  final nestedData = pdfAssetData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pdfAsset.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPdfAssetFirestoreData(
  PdfAssetStruct? pdfAsset, [
  bool forFieldValue = false,
]) {
  if (pdfAsset == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pdfAsset.toMap());

  // Add any Firestore field values
  mapToFirestore(pdfAsset.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPdfAssetListFirestoreData(
  List<PdfAssetStruct>? pdfAssets,
) =>
    pdfAssets?.map((e) => getPdfAssetFirestoreData(e, true)).toList() ?? [];
