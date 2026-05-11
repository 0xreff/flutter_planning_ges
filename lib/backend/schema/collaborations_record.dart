import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CollaborationsRecord extends FirestoreRecord {
  CollaborationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "partner_ref" field.
  DocumentReference? _partnerRef;
  DocumentReference? get partnerRef => _partnerRef;
  bool hasPartnerRef() => _partnerRef != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "end_date" field.
  DateTime? _endDate;
  DateTime? get endDate => _endDate;
  bool hasEndDate() => _endDate != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _partnerRef = snapshotData['partner_ref'] as DocumentReference?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _startDate = snapshotData['start_date'] as DateTime?;
    _endDate = snapshotData['end_date'] as DateTime?;
    _status = snapshotData['status'] as String?;
    _notes = snapshotData['notes'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('collaborations');

  static Stream<CollaborationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CollaborationsRecord.fromSnapshot(s));

  static Future<CollaborationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CollaborationsRecord.fromSnapshot(s));

  static CollaborationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CollaborationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CollaborationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CollaborationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CollaborationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CollaborationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCollaborationsRecordData({
  DocumentReference? partnerRef,
  DocumentReference? userRef,
  DateTime? startDate,
  DateTime? endDate,
  String? status,
  String? notes,
  String? title,
  String? description,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'partner_ref': partnerRef,
      'user_ref': userRef,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'notes': notes,
      'title': title,
      'description': description,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class CollaborationsRecordDocumentEquality
    implements Equality<CollaborationsRecord> {
  const CollaborationsRecordDocumentEquality();

  @override
  bool equals(CollaborationsRecord? e1, CollaborationsRecord? e2) {
    return e1?.partnerRef == e2?.partnerRef &&
        e1?.userRef == e2?.userRef &&
        e1?.startDate == e2?.startDate &&
        e1?.endDate == e2?.endDate &&
        e1?.status == e2?.status &&
        e1?.notes == e2?.notes &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image;
  }

  @override
  int hash(CollaborationsRecord? e) => const ListEquality().hash([
        e?.partnerRef,
        e?.userRef,
        e?.startDate,
        e?.endDate,
        e?.status,
        e?.notes,
        e?.title,
        e?.description,
        e?.image
      ]);

  @override
  bool isValidKey(Object? o) => o is CollaborationsRecord;
}
