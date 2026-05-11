import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ForumsRecord extends FirestoreRecord {
  ForumsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "members_count" field.
  int? _membersCount;
  int get membersCount => _membersCount ?? 0;
  bool hasMembersCount() => _membersCount != null;

  // "posts_count" field.
  int? _postsCount;
  int get postsCount => _postsCount ?? 0;
  bool hasPostsCount() => _postsCount != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _category = snapshotData['category'] as String?;
    _description = snapshotData['description'] as String?;
    _status = snapshotData['status'] as String?;
    _membersCount = castToType<int>(snapshotData['members_count']);
    _postsCount = castToType<int>(snapshotData['posts_count']);
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('forums');

  static Stream<ForumsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ForumsRecord.fromSnapshot(s));

  static Future<ForumsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ForumsRecord.fromSnapshot(s));

  static ForumsRecord fromSnapshot(DocumentSnapshot snapshot) => ForumsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ForumsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ForumsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ForumsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ForumsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createForumsRecordData({
  String? title,
  String? category,
  String? description,
  String? status,
  int? membersCount,
  int? postsCount,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'category': category,
      'description': description,
      'status': status,
      'members_count': membersCount,
      'posts_count': postsCount,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ForumsRecordDocumentEquality implements Equality<ForumsRecord> {
  const ForumsRecordDocumentEquality();

  @override
  bool equals(ForumsRecord? e1, ForumsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.category == e2?.category &&
        e1?.description == e2?.description &&
        e1?.status == e2?.status &&
        e1?.membersCount == e2?.membersCount &&
        e1?.postsCount == e2?.postsCount &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ForumsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.category,
        e?.description,
        e?.status,
        e?.membersCount,
        e?.postsCount,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is ForumsRecord;
}
