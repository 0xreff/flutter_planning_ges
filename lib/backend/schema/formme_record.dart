import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FormmeRecord extends FirestoreRecord {
  FormmeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titre" field.
  String? _titre;
  String get titre => _titre ?? '';
  bool hasTitre() => _titre != null;

  // "discription" field.
  String? _discription;
  String get discription => _discription ?? '';
  bool hasDiscription() => _discription != null;

  // "categorie" field.
  String? _categorie;
  String get categorie => _categorie ?? '';
  bool hasCategorie() => _categorie != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  void _initializeFields() {
    _titre = snapshotData['titre'] as String?;
    _discription = snapshotData['discription'] as String?;
    _categorie = snapshotData['categorie'] as String?;
    _name = snapshotData['name'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('formme');

  static Stream<FormmeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FormmeRecord.fromSnapshot(s));

  static Future<FormmeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FormmeRecord.fromSnapshot(s));

  static FormmeRecord fromSnapshot(DocumentSnapshot snapshot) => FormmeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FormmeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FormmeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FormmeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FormmeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFormmeRecordData({
  String? titre,
  String? discription,
  String? categorie,
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titre': titre,
      'discription': discription,
      'categorie': categorie,
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class FormmeRecordDocumentEquality implements Equality<FormmeRecord> {
  const FormmeRecordDocumentEquality();

  @override
  bool equals(FormmeRecord? e1, FormmeRecord? e2) {
    return e1?.titre == e2?.titre &&
        e1?.discription == e2?.discription &&
        e1?.categorie == e2?.categorie &&
        e1?.name == e2?.name;
  }

  @override
  int hash(FormmeRecord? e) => const ListEquality()
      .hash([e?.titre, e?.discription, e?.categorie, e?.name]);

  @override
  bool isValidKey(Object? o) => o is FormmeRecord;
}
