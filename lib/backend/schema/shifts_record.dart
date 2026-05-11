import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ShiftsRecord extends FirestoreRecord {
  ShiftsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "heureDebut" field.
  String? _heureDebut;
  String get heureDebut => _heureDebut ?? '';
  bool hasHeureDebut() => _heureDebut != null;

  // "heureFin" field.
  String? _heureFin;
  String get heureFin => _heureFin ?? '';
  bool hasHeureFin() => _heureFin != null;

  // "service" field.
  String? _service;
  String get service => _service ?? '';
  bool hasService() => _service != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "staffId" field.
  DocumentReference? _staffId;
  DocumentReference? get staffId => _staffId;
  bool hasStaffId() => _staffId != null;

  void _initializeFields() {
    _date = snapshotData['date'] as DateTime?;
    _heureDebut = snapshotData['heureDebut'] as String?;
    _heureFin = snapshotData['heureFin'] as String?;
    _service = snapshotData['service'] as String?;
    _status = snapshotData['status'] as String?;
    _notes = snapshotData['notes'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _staffId = snapshotData['staffId'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shifts');

  static Stream<ShiftsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ShiftsRecord.fromSnapshot(s));

  static Future<ShiftsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ShiftsRecord.fromSnapshot(s));

  static ShiftsRecord fromSnapshot(DocumentSnapshot snapshot) => ShiftsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ShiftsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ShiftsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ShiftsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ShiftsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createShiftsRecordData({
  DateTime? date,
  String? heureDebut,
  String? heureFin,
  String? service,
  String? status,
  String? notes,
  DateTime? createdAt,
  DocumentReference? staffId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date': date,
      'heureDebut': heureDebut,
      'heureFin': heureFin,
      'service': service,
      'status': status,
      'notes': notes,
      'createdAt': createdAt,
      'staffId': staffId,
    }.withoutNulls,
  );

  return firestoreData;
}

class ShiftsRecordDocumentEquality implements Equality<ShiftsRecord> {
  const ShiftsRecordDocumentEquality();

  @override
  bool equals(ShiftsRecord? e1, ShiftsRecord? e2) {
    return e1?.date == e2?.date &&
        e1?.heureDebut == e2?.heureDebut &&
        e1?.heureFin == e2?.heureFin &&
        e1?.service == e2?.service &&
        e1?.status == e2?.status &&
        e1?.notes == e2?.notes &&
        e1?.createdAt == e2?.createdAt &&
        e1?.staffId == e2?.staffId;
  }

  @override
  int hash(ShiftsRecord? e) => const ListEquality().hash([
        e?.date,
        e?.heureDebut,
        e?.heureFin,
        e?.service,
        e?.status,
        e?.notes,
        e?.createdAt,
        e?.staffId
      ]);

  @override
  bool isValidKey(Object? o) => o is ShiftsRecord;
}
