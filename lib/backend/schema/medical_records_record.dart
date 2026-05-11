import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicalRecordsRecord extends FirestoreRecord {
  MedicalRecordsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "patintid" field.
  DocumentReference? _patintid;
  DocumentReference? get patintid => _patintid;
  bool hasPatintid() => _patintid != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "Ref" field.
  String? _ref;
  String get ref => _ref ?? '';
  bool hasRef() => _ref != null;

  void _initializeFields() {
    _patintid = snapshotData['patintid'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _ref = snapshotData['Ref'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('medical_records');

  static Stream<MedicalRecordsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MedicalRecordsRecord.fromSnapshot(s));

  static Future<MedicalRecordsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MedicalRecordsRecord.fromSnapshot(s));

  static MedicalRecordsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MedicalRecordsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MedicalRecordsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MedicalRecordsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MedicalRecordsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MedicalRecordsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMedicalRecordsRecordData({
  DocumentReference? patintid,
  DateTime? createdAt,
  String? ref,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'patintid': patintid,
      'createdAt': createdAt,
      'Ref': ref,
    }.withoutNulls,
  );

  return firestoreData;
}

class MedicalRecordsRecordDocumentEquality
    implements Equality<MedicalRecordsRecord> {
  const MedicalRecordsRecordDocumentEquality();

  @override
  bool equals(MedicalRecordsRecord? e1, MedicalRecordsRecord? e2) {
    return e1?.patintid == e2?.patintid &&
        e1?.createdAt == e2?.createdAt &&
        e1?.ref == e2?.ref;
  }

  @override
  int hash(MedicalRecordsRecord? e) =>
      const ListEquality().hash([e?.patintid, e?.createdAt, e?.ref]);

  @override
  bool isValidKey(Object? o) => o is MedicalRecordsRecord;
}
