import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TachesRecord extends FirestoreRecord {
  TachesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "titre" field.
  String? _titre;
  String get titre => _titre ?? '';
  bool hasTitre() => _titre != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "assigneA" field.
  DocumentReference? _assigneA;
  DocumentReference? get assigneA => _assigneA;
  bool hasAssigneA() => _assigneA != null;

  // "echeance" field.
  DateTime? _echeance;
  DateTime? get echeance => _echeance;
  bool hasEcheance() => _echeance != null;

  // "priorite" field.
  String? _priorite;
  String get priorite => _priorite ?? '';
  bool hasPriorite() => _priorite != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "creePar" field.
  DocumentReference? _creePar;
  DocumentReference? get creePar => _creePar;
  bool hasCreePar() => _creePar != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _titre = snapshotData['titre'] as String?;
    _description = snapshotData['description'] as String?;
    _assigneA = snapshotData['assigneA'] as DocumentReference?;
    _echeance = snapshotData['echeance'] as DateTime?;
    _priorite = snapshotData['priorite'] as String?;
    _status = snapshotData['status'] as String?;
    _creePar = snapshotData['creePar'] as DocumentReference?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('taches');

  static Stream<TachesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TachesRecord.fromSnapshot(s));

  static Future<TachesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TachesRecord.fromSnapshot(s));

  static TachesRecord fromSnapshot(DocumentSnapshot snapshot) => TachesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TachesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TachesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TachesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TachesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTachesRecordData({
  String? titre,
  String? description,
  DocumentReference? assigneA,
  DateTime? echeance,
  String? priorite,
  String? status,
  DocumentReference? creePar,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'titre': titre,
      'description': description,
      'assigneA': assigneA,
      'echeance': echeance,
      'priorite': priorite,
      'status': status,
      'creePar': creePar,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class TachesRecordDocumentEquality implements Equality<TachesRecord> {
  const TachesRecordDocumentEquality();

  @override
  bool equals(TachesRecord? e1, TachesRecord? e2) {
    return e1?.titre == e2?.titre &&
        e1?.description == e2?.description &&
        e1?.assigneA == e2?.assigneA &&
        e1?.echeance == e2?.echeance &&
        e1?.priorite == e2?.priorite &&
        e1?.status == e2?.status &&
        e1?.creePar == e2?.creePar &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(TachesRecord? e) => const ListEquality().hash([
        e?.titre,
        e?.description,
        e?.assigneA,
        e?.echeance,
        e?.priorite,
        e?.status,
        e?.creePar,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is TachesRecord;
}
