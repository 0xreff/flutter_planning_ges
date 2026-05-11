import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlansTraitementRecord extends FirestoreRecord {
  PlansTraitementRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "patientId" field.
  DocumentReference? _patientId;
  DocumentReference? get patientId => _patientId;
  bool hasPatientId() => _patientId != null;

  // "titre" field.
  String? _titre;
  String get titre => _titre ?? '';
  bool hasTitre() => _titre != null;

  // "diagnostic" field.
  String? _diagnostic;
  String get diagnostic => _diagnostic ?? '';
  bool hasDiagnostic() => _diagnostic != null;

  // "dateDebut" field.
  DateTime? _dateDebut;
  DateTime? get dateDebut => _dateDebut;
  bool hasDateDebut() => _dateDebut != null;

  // "DateFin" field.
  DateTime? _dateFin;
  DateTime? get dateFin => _dateFin;
  bool hasDateFin() => _dateFin != null;

  // "etapes" field.
  List<EtapeStruct>? _etapes;
  List<EtapeStruct> get etapes => _etapes ?? const [];
  bool hasEtapes() => _etapes != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "medicinId" field.
  DocumentReference? _medicinId;
  DocumentReference? get medicinId => _medicinId;
  bool hasMedicinId() => _medicinId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _patientId = snapshotData['patientId'] as DocumentReference?;
    _titre = snapshotData['titre'] as String?;
    _diagnostic = snapshotData['diagnostic'] as String?;
    _dateDebut = snapshotData['dateDebut'] as DateTime?;
    _dateFin = snapshotData['DateFin'] as DateTime?;
    _etapes = getStructList(
      snapshotData['etapes'],
      EtapeStruct.fromMap,
    );
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _medicinId = snapshotData['medicinId'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plansTraitement');

  static Stream<PlansTraitementRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlansTraitementRecord.fromSnapshot(s));

  static Future<PlansTraitementRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlansTraitementRecord.fromSnapshot(s));

  static PlansTraitementRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlansTraitementRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlansTraitementRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlansTraitementRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlansTraitementRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlansTraitementRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlansTraitementRecordData({
  DocumentReference? patientId,
  String? titre,
  String? diagnostic,
  DateTime? dateDebut,
  DateTime? dateFin,
  DateTime? createdAt,
  DocumentReference? medicinId,
  String? status,
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'patientId': patientId,
      'titre': titre,
      'diagnostic': diagnostic,
      'dateDebut': dateDebut,
      'DateFin': dateFin,
      'createdAt': createdAt,
      'medicinId': medicinId,
      'status': status,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlansTraitementRecordDocumentEquality
    implements Equality<PlansTraitementRecord> {
  const PlansTraitementRecordDocumentEquality();

  @override
  bool equals(PlansTraitementRecord? e1, PlansTraitementRecord? e2) {
    const listEquality = ListEquality();
    return e1?.patientId == e2?.patientId &&
        e1?.titre == e2?.titre &&
        e1?.diagnostic == e2?.diagnostic &&
        e1?.dateDebut == e2?.dateDebut &&
        e1?.dateFin == e2?.dateFin &&
        listEquality.equals(e1?.etapes, e2?.etapes) &&
        e1?.createdAt == e2?.createdAt &&
        e1?.medicinId == e2?.medicinId &&
        e1?.status == e2?.status &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(PlansTraitementRecord? e) => const ListEquality().hash([
        e?.patientId,
        e?.titre,
        e?.diagnostic,
        e?.dateDebut,
        e?.dateFin,
        e?.etapes,
        e?.createdAt,
        e?.medicinId,
        e?.status,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is PlansTraitementRecord;
}
