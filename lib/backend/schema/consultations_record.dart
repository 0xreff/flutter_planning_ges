import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConsultationsRecord extends FirestoreRecord {
  ConsultationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "recordRef" field.
  DocumentReference? _recordRef;
  DocumentReference? get recordRef => _recordRef;
  bool hasRecordRef() => _recordRef != null;

  // "doctorRef" field.
  DocumentReference? _doctorRef;
  DocumentReference? get doctorRef => _doctorRef;
  bool hasDoctorRef() => _doctorRef != null;

  // "diagnostic" field.
  String? _diagnostic;
  String get diagnostic => _diagnostic ?? '';
  bool hasDiagnostic() => _diagnostic != null;

  // "treatment" field.
  String? _treatment;
  String get treatment => _treatment ?? '';
  bool hasTreatment() => _treatment != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  void _initializeFields() {
    _recordRef = snapshotData['recordRef'] as DocumentReference?;
    _doctorRef = snapshotData['doctorRef'] as DocumentReference?;
    _diagnostic = snapshotData['diagnostic'] as String?;
    _treatment = snapshotData['treatment'] as String?;
    _notes = snapshotData['notes'] as String?;
    _date = snapshotData['date'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('consultations');

  static Stream<ConsultationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConsultationsRecord.fromSnapshot(s));

  static Future<ConsultationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ConsultationsRecord.fromSnapshot(s));

  static ConsultationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConsultationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConsultationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConsultationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConsultationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConsultationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createConsultationsRecordData({
  DocumentReference? recordRef,
  DocumentReference? doctorRef,
  String? diagnostic,
  String? treatment,
  String? notes,
  DateTime? date,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'recordRef': recordRef,
      'doctorRef': doctorRef,
      'diagnostic': diagnostic,
      'treatment': treatment,
      'notes': notes,
      'date': date,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConsultationsRecordDocumentEquality
    implements Equality<ConsultationsRecord> {
  const ConsultationsRecordDocumentEquality();

  @override
  bool equals(ConsultationsRecord? e1, ConsultationsRecord? e2) {
    return e1?.recordRef == e2?.recordRef &&
        e1?.doctorRef == e2?.doctorRef &&
        e1?.diagnostic == e2?.diagnostic &&
        e1?.treatment == e2?.treatment &&
        e1?.notes == e2?.notes &&
        e1?.date == e2?.date;
  }

  @override
  int hash(ConsultationsRecord? e) => const ListEquality().hash([
        e?.recordRef,
        e?.doctorRef,
        e?.diagnostic,
        e?.treatment,
        e?.notes,
        e?.date
      ]);

  @override
  bool isValidKey(Object? o) => o is ConsultationsRecord;
}
