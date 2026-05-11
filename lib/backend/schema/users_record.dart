import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "Gender" field.
  Gender? _gender;
  Gender? get gender => _gender;
  bool hasGender() => _gender != null;

  // "BirthDate" field.
  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;
  bool hasBirthDate() => _birthDate != null;

  // "BloodType" field.
  Blood? _bloodType;
  Blood? get bloodType => _bloodType;
  bool hasBloodType() => _bloodType != null;

  // "Allergies" field.
  List<String>? _allergies;
  List<String> get allergies => _allergies ?? const [];
  bool hasAllergies() => _allergies != null;

  // "ChronicConditions" field.
  List<String>? _chronicConditions;
  List<String> get chronicConditions => _chronicConditions ?? const [];
  bool hasChronicConditions() => _chronicConditions != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "PreferedLanguage" field.
  Language? _preferedLanguage;
  Language? get preferedLanguage => _preferedLanguage;
  bool hasPreferedLanguage() => _preferedLanguage != null;

  // "fcmToken" field.
  String? _fcmToken;
  String get fcmToken => _fcmToken ?? '';
  bool hasFcmToken() => _fcmToken != null;

  // "notificationsEnabled" field.
  bool? _notificationsEnabled;
  bool get notificationsEnabled => _notificationsEnabled ?? false;
  bool hasNotificationsEnabled() => _notificationsEnabled != null;

  // "UserRole" field.
  Role? _userRole;
  Role? get userRole => _userRole;
  bool hasUserRole() => _userRole != null;

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "UpdatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _title = snapshotData['title'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _email = snapshotData['email'] as String?;
    _gender = snapshotData['Gender'] is Gender
        ? snapshotData['Gender']
        : deserializeEnum<Gender>(snapshotData['Gender']);
    _birthDate = snapshotData['BirthDate'] as DateTime?;
    _bloodType = snapshotData['BloodType'] is Blood
        ? snapshotData['BloodType']
        : deserializeEnum<Blood>(snapshotData['BloodType']);
    _allergies = getDataList(snapshotData['Allergies']);
    _chronicConditions = getDataList(snapshotData['ChronicConditions']);
    _city = snapshotData['city'] as String?;
    _preferedLanguage = snapshotData['PreferedLanguage'] is Language
        ? snapshotData['PreferedLanguage']
        : deserializeEnum<Language>(snapshotData['PreferedLanguage']);
    _fcmToken = snapshotData['fcmToken'] as String?;
    _notificationsEnabled = snapshotData['notificationsEnabled'] as bool?;
    _userRole = snapshotData['UserRole'] is Role
        ? snapshotData['UserRole']
        : deserializeEnum<Role>(snapshotData['UserRole']);
    _isActive = snapshotData['isActive'] as bool?;
    _updatedAt = snapshotData['UpdatedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  DateTime? createdTime,
  String? phoneNumber,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? role,
  String? title,
  String? photoUrl,
  String? uid,
  String? displayName,
  String? email,
  Gender? gender,
  DateTime? birthDate,
  Blood? bloodType,
  String? city,
  Language? preferedLanguage,
  String? fcmToken,
  bool? notificationsEnabled,
  Role? userRole,
  bool? isActive,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'role': role,
      'title': title,
      'photo_url': photoUrl,
      'uid': uid,
      'display_name': displayName,
      'email': email,
      'Gender': gender,
      'BirthDate': birthDate,
      'BloodType': bloodType,
      'city': city,
      'PreferedLanguage': preferedLanguage,
      'fcmToken': fcmToken,
      'notificationsEnabled': notificationsEnabled,
      'UserRole': userRole,
      'isActive': isActive,
      'UpdatedAt': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.role == e2?.role &&
        e1?.title == e2?.title &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.displayName == e2?.displayName &&
        e1?.email == e2?.email &&
        e1?.gender == e2?.gender &&
        e1?.birthDate == e2?.birthDate &&
        e1?.bloodType == e2?.bloodType &&
        listEquality.equals(e1?.allergies, e2?.allergies) &&
        listEquality.equals(e1?.chronicConditions, e2?.chronicConditions) &&
        e1?.city == e2?.city &&
        e1?.preferedLanguage == e2?.preferedLanguage &&
        e1?.fcmToken == e2?.fcmToken &&
        e1?.notificationsEnabled == e2?.notificationsEnabled &&
        e1?.userRole == e2?.userRole &&
        e1?.isActive == e2?.isActive &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.createdTime,
        e?.phoneNumber,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.role,
        e?.title,
        e?.photoUrl,
        e?.uid,
        e?.displayName,
        e?.email,
        e?.gender,
        e?.birthDate,
        e?.bloodType,
        e?.allergies,
        e?.chronicConditions,
        e?.city,
        e?.preferedLanguage,
        e?.fcmToken,
        e?.notificationsEnabled,
        e?.userRole,
        e?.isActive,
        e?.updatedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
