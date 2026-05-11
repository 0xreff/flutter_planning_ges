import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PartnersRecord extends FirestoreRecord {
  PartnersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "partnership_date" field.
  DateTime? _partnershipDate;
  DateTime? get partnershipDate => _partnershipDate;
  bool hasPartnershipDate() => _partnershipDate != null;

  // "partnership_type" field.
  String? _partnershipType;
  String get partnershipType => _partnershipType ?? '';
  bool hasPartnershipType() => _partnershipType != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _address = snapshotData['address'] as String?;
    _phone = snapshotData['phone'] as String?;
    _email = snapshotData['email'] as String?;
    _partnershipDate = snapshotData['partnership_date'] as DateTime?;
    _partnershipType = snapshotData['partnership_type'] as String?;
    _status = snapshotData['status'] as String?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('partners');

  static Stream<PartnersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PartnersRecord.fromSnapshot(s));

  static Future<PartnersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PartnersRecord.fromSnapshot(s));

  static PartnersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PartnersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PartnersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PartnersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PartnersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PartnersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPartnersRecordData({
  String? name,
  String? address,
  String? phone,
  String? email,
  DateTime? partnershipDate,
  String? partnershipType,
  String? status,
  DocumentReference? userRef,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'partnership_date': partnershipDate,
      'partnership_type': partnershipType,
      'status': status,
      'user_ref': userRef,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class PartnersRecordDocumentEquality implements Equality<PartnersRecord> {
  const PartnersRecordDocumentEquality();

  @override
  bool equals(PartnersRecord? e1, PartnersRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.address == e2?.address &&
        e1?.phone == e2?.phone &&
        e1?.email == e2?.email &&
        e1?.partnershipDate == e2?.partnershipDate &&
        e1?.partnershipType == e2?.partnershipType &&
        e1?.status == e2?.status &&
        e1?.userRef == e2?.userRef &&
        e1?.image == e2?.image;
  }

  @override
  int hash(PartnersRecord? e) => const ListEquality().hash([
        e?.name,
        e?.address,
        e?.phone,
        e?.email,
        e?.partnershipDate,
        e?.partnershipType,
        e?.status,
        e?.userRef,
        e?.image
      ]);

  @override
  bool isValidKey(Object? o) => o is PartnersRecord;
}
