import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AppointementsRecord extends FirestoreRecord {
  AppointementsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "patientId" field.
  String? _patientId;
  String get patientId => _patientId ?? '';
  bool hasPatientId() => _patientId != null;

  // "doctorId" field.
  String? _doctorId;
  String get doctorId => _doctorId ?? '';
  bool hasDoctorId() => _doctorId != null;

  // "slotId" field.
  String? _slotId;
  String get slotId => _slotId ?? '';
  bool hasSlotId() => _slotId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "startTime" field.
  String? _startTime;
  String get startTime => _startTime ?? '';
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  String? _endTime;
  String get endTime => _endTime ?? '';
  bool hasEndTime() => _endTime != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  bool hasReason() => _reason != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "cancelledBy" field.
  String? _cancelledBy;
  String get cancelledBy => _cancelledBy ?? '';
  bool hasCancelledBy() => _cancelledBy != null;

  // "cancelReason" field.
  String? _cancelReason;
  String get cancelReason => _cancelReason ?? '';
  bool hasCancelReason() => _cancelReason != null;

  // "videoCallUrl" field.
  String? _videoCallUrl;
  String get videoCallUrl => _videoCallUrl ?? '';
  bool hasVideoCallUrl() => _videoCallUrl != null;

  // "reminderSent" field.
  bool? _reminderSent;
  bool get reminderSent => _reminderSent ?? false;
  bool hasReminderSent() => _reminderSent != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

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
    _patientId = snapshotData['patientId'] as String?;
    _doctorId = snapshotData['doctorId'] as String?;
    _slotId = snapshotData['slotId'] as String?;
    _status = snapshotData['status'] as String?;
    _type = snapshotData['type'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['startTime'] as String?;
    _endTime = snapshotData['endTime'] as String?;
    _reason = snapshotData['reason'] as String?;
    _notes = snapshotData['notes'] as String?;
    _cancelledBy = snapshotData['cancelledBy'] as String?;
    _cancelReason = snapshotData['cancelReason'] as String?;
    _videoCallUrl = snapshotData['videoCallUrl'] as String?;
    _reminderSent = snapshotData['reminderSent'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _updatedAt = snapshotData['updatedAt'] as DateTime?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('appointements');

  static Stream<AppointementsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AppointementsRecord.fromSnapshot(s));

  static Future<AppointementsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AppointementsRecord.fromSnapshot(s));

  static AppointementsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AppointementsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AppointementsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AppointementsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AppointementsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AppointementsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAppointementsRecordData({
  String? patientId,
  String? doctorId,
  String? slotId,
  String? status,
  String? type,
  DateTime? date,
  String? startTime,
  String? endTime,
  String? reason,
  String? notes,
  String? cancelledBy,
  String? cancelReason,
  String? videoCallUrl,
  bool? reminderSent,
  DateTime? createdAt,
  DateTime? updatedAt,
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
      'doctorId': doctorId,
      'slotId': slotId,
      'status': status,
      'type': type,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
      'notes': notes,
      'cancelledBy': cancelledBy,
      'cancelReason': cancelReason,
      'videoCallUrl': videoCallUrl,
      'reminderSent': reminderSent,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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

class AppointementsRecordDocumentEquality
    implements Equality<AppointementsRecord> {
  const AppointementsRecordDocumentEquality();

  @override
  bool equals(AppointementsRecord? e1, AppointementsRecord? e2) {
    return e1?.patientId == e2?.patientId &&
        e1?.doctorId == e2?.doctorId &&
        e1?.slotId == e2?.slotId &&
        e1?.status == e2?.status &&
        e1?.type == e2?.type &&
        e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.reason == e2?.reason &&
        e1?.notes == e2?.notes &&
        e1?.cancelledBy == e2?.cancelledBy &&
        e1?.cancelReason == e2?.cancelReason &&
        e1?.videoCallUrl == e2?.videoCallUrl &&
        e1?.reminderSent == e2?.reminderSent &&
        e1?.createdAt == e2?.createdAt &&
        e1?.updatedAt == e2?.updatedAt &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(AppointementsRecord? e) => const ListEquality().hash([
        e?.patientId,
        e?.doctorId,
        e?.slotId,
        e?.status,
        e?.type,
        e?.date,
        e?.startTime,
        e?.endTime,
        e?.reason,
        e?.notes,
        e?.cancelledBy,
        e?.cancelReason,
        e?.videoCallUrl,
        e?.reminderSent,
        e?.createdAt,
        e?.updatedAt,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is AppointementsRecord;
}
