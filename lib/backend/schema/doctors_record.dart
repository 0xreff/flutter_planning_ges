import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DoctorsRecord extends FirestoreRecord {
  DoctorsRecord._(
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

  // "speciality" field.
  String? _speciality;
  String get speciality => _speciality ?? '';
  bool hasSpeciality() => _speciality != null;

  // "subspeciality" field.
  String? _subspeciality;
  String get subspeciality => _subspeciality ?? '';
  bool hasSubspeciality() => _subspeciality != null;

  // "licenseNumber" field.
  String? _licenseNumber;
  String get licenseNumber => _licenseNumber ?? '';
  bool hasLicenseNumber() => _licenseNumber != null;

  // "YearsOfExperience" field.
  int? _yearsOfExperience;
  int get yearsOfExperience => _yearsOfExperience ?? 0;
  bool hasYearsOfExperience() => _yearsOfExperience != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "doctorId" field.
  String? _doctorId;
  String get doctorId => _doctorId ?? '';
  bool hasDoctorId() => _doctorId != null;

  // "doctorPhoto" field.
  String? _doctorPhoto;
  String get doctorPhoto => _doctorPhoto ?? '';
  bool hasDoctorPhoto() => _doctorPhoto != null;

  // "consultationFee" field.
  double? _consultationFee;
  double get consultationFee => _consultationFee ?? 0.0;
  bool hasConsultationFee() => _consultationFee != null;

  // "consultationTypes" field.
  List<String>? _consultationTypes;
  List<String> get consultationTypes => _consultationTypes ?? const [];
  bool hasConsultationTypes() => _consultationTypes != null;

  // "slotDurationMinutes" field.
  PlanDuration? _slotDurationMinutes;
  PlanDuration? get slotDurationMinutes => _slotDurationMinutes;
  bool hasSlotDurationMinutes() => _slotDurationMinutes != null;

  // "isAvailable" field.
  bool? _isAvailable;
  bool get isAvailable => _isAvailable ?? false;
  bool hasIsAvailable() => _isAvailable != null;

  // "isVerified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "reviewCount" field.
  int? _reviewCount;
  int get reviewCount => _reviewCount ?? 0;
  bool hasReviewCount() => _reviewCount != null;

  // "totalAppointements" field.
  int? _totalAppointements;
  int get totalAppointements => _totalAppointements ?? 0;
  bool hasTotalAppointements() => _totalAppointements != null;

  // "clinicName" field.
  String? _clinicName;
  String get clinicName => _clinicName ?? '';
  bool hasClinicName() => _clinicName != null;

  // "clinicAddress" field.
  String? _clinicAddress;
  String get clinicAddress => _clinicAddress ?? '';
  bool hasClinicAddress() => _clinicAddress != null;

  // "language" field.
  List<String>? _language;
  List<String> get language => _language ?? const [];
  bool hasLanguage() => _language != null;

  void _initializeFields() {
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _title = snapshotData['title'] as String?;
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
    _speciality = snapshotData['speciality'] as String?;
    _subspeciality = snapshotData['subspeciality'] as String?;
    _licenseNumber = snapshotData['licenseNumber'] as String?;
    _yearsOfExperience = castToType<int>(snapshotData['YearsOfExperience']);
    _bio = snapshotData['bio'] as String?;
    _doctorId = snapshotData['doctorId'] as String?;
    _doctorPhoto = snapshotData['doctorPhoto'] as String?;
    _consultationFee = castToType<double>(snapshotData['consultationFee']);
    _consultationTypes = getDataList(snapshotData['consultationTypes']);
    _slotDurationMinutes = snapshotData['slotDurationMinutes'] is PlanDuration
        ? snapshotData['slotDurationMinutes']
        : deserializeEnum<PlanDuration>(snapshotData['slotDurationMinutes']);
    _isAvailable = snapshotData['isAvailable'] as bool?;
    _isVerified = snapshotData['isVerified'] as bool?;
    _rating = castToType<double>(snapshotData['rating']);
    _reviewCount = castToType<int>(snapshotData['reviewCount']);
    _totalAppointements = castToType<int>(snapshotData['totalAppointements']);
    _clinicName = snapshotData['clinicName'] as String?;
    _clinicAddress = snapshotData['clinicAddress'] as String?;
    _language = getDataList(snapshotData['language']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('doctors');

  static Stream<DoctorsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DoctorsRecord.fromSnapshot(s));

  static Future<DoctorsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DoctorsRecord.fromSnapshot(s));

  static DoctorsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DoctorsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DoctorsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DoctorsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DoctorsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DoctorsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDoctorsRecordData({
  DateTime? createdTime,
  String? phoneNumber,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? role,
  String? title,
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
  String? speciality,
  String? subspeciality,
  String? licenseNumber,
  int? yearsOfExperience,
  String? bio,
  String? doctorId,
  String? doctorPhoto,
  double? consultationFee,
  PlanDuration? slotDurationMinutes,
  bool? isAvailable,
  bool? isVerified,
  double? rating,
  int? reviewCount,
  int? totalAppointements,
  String? clinicName,
  String? clinicAddress,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'role': role,
      'title': title,
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
      'speciality': speciality,
      'subspeciality': subspeciality,
      'licenseNumber': licenseNumber,
      'YearsOfExperience': yearsOfExperience,
      'bio': bio,
      'doctorId': doctorId,
      'doctorPhoto': doctorPhoto,
      'consultationFee': consultationFee,
      'slotDurationMinutes': slotDurationMinutes,
      'isAvailable': isAvailable,
      'isVerified': isVerified,
      'rating': rating,
      'reviewCount': reviewCount,
      'totalAppointements': totalAppointements,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
    }.withoutNulls,
  );

  return firestoreData;
}

class DoctorsRecordDocumentEquality implements Equality<DoctorsRecord> {
  const DoctorsRecordDocumentEquality();

  @override
  bool equals(DoctorsRecord? e1, DoctorsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.role == e2?.role &&
        e1?.title == e2?.title &&
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
        e1?.updatedAt == e2?.updatedAt &&
        e1?.speciality == e2?.speciality &&
        e1?.subspeciality == e2?.subspeciality &&
        e1?.licenseNumber == e2?.licenseNumber &&
        e1?.yearsOfExperience == e2?.yearsOfExperience &&
        e1?.bio == e2?.bio &&
        e1?.doctorId == e2?.doctorId &&
        e1?.doctorPhoto == e2?.doctorPhoto &&
        e1?.consultationFee == e2?.consultationFee &&
        listEquality.equals(e1?.consultationTypes, e2?.consultationTypes) &&
        e1?.slotDurationMinutes == e2?.slotDurationMinutes &&
        e1?.isAvailable == e2?.isAvailable &&
        e1?.isVerified == e2?.isVerified &&
        e1?.rating == e2?.rating &&
        e1?.reviewCount == e2?.reviewCount &&
        e1?.totalAppointements == e2?.totalAppointements &&
        e1?.clinicName == e2?.clinicName &&
        e1?.clinicAddress == e2?.clinicAddress &&
        listEquality.equals(e1?.language, e2?.language);
  }

  @override
  int hash(DoctorsRecord? e) => const ListEquality().hash([
        e?.createdTime,
        e?.phoneNumber,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.role,
        e?.title,
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
        e?.updatedAt,
        e?.speciality,
        e?.subspeciality,
        e?.licenseNumber,
        e?.yearsOfExperience,
        e?.bio,
        e?.doctorId,
        e?.doctorPhoto,
        e?.consultationFee,
        e?.consultationTypes,
        e?.slotDurationMinutes,
        e?.isAvailable,
        e?.isVerified,
        e?.rating,
        e?.reviewCount,
        e?.totalAppointements,
        e?.clinicName,
        e?.clinicAddress,
        e?.language
      ]);

  @override
  bool isValidKey(Object? o) => o is DoctorsRecord;
}
