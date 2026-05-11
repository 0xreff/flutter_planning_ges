import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommandRecord extends FirestoreRecord {
  CommandRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "productName" field.
  String? _productName;
  String get productName => _productName ?? '';
  bool hasProductName() => _productName != null;

  // "fullName" field.
  String? _fullName;
  String get fullName => _fullName ?? '';
  bool hasFullName() => _fullName != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  bool hasQuantity() => _quantity != null;

  // "total" field.
  double? _total;
  double get total => _total ?? 0.0;
  bool hasTotal() => _total != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "payMethod" field.
  String? _payMethod;
  String get payMethod => _payMethod ?? '';
  bool hasPayMethod() => _payMethod != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "date_command" field.
  DateTime? _dateCommand;
  DateTime? get dateCommand => _dateCommand;
  bool hasDateCommand() => _dateCommand != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _productName = snapshotData['productName'] as String?;
    _fullName = snapshotData['fullName'] as String?;
    _quantity = castToType<int>(snapshotData['quantity']);
    _total = castToType<double>(snapshotData['total']);
    _notes = snapshotData['notes'] as String?;
    _payMethod = snapshotData['payMethod'] as String?;
    _status = snapshotData['status'] as String?;
    _dateCommand = snapshotData['date_command'] as DateTime?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('command')
          : FirebaseFirestore.instance.collectionGroup('command');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('command').doc(id);

  static Stream<CommandRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommandRecord.fromSnapshot(s));

  static Future<CommandRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommandRecord.fromSnapshot(s));

  static CommandRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommandRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommandRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommandRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommandRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommandRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommandRecordData({
  String? productName,
  String? fullName,
  int? quantity,
  double? total,
  String? notes,
  String? payMethod,
  String? status,
  DateTime? dateCommand,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'productName': productName,
      'fullName': fullName,
      'quantity': quantity,
      'total': total,
      'notes': notes,
      'payMethod': payMethod,
      'status': status,
      'date_command': dateCommand,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommandRecordDocumentEquality implements Equality<CommandRecord> {
  const CommandRecordDocumentEquality();

  @override
  bool equals(CommandRecord? e1, CommandRecord? e2) {
    return e1?.productName == e2?.productName &&
        e1?.fullName == e2?.fullName &&
        e1?.quantity == e2?.quantity &&
        e1?.total == e2?.total &&
        e1?.notes == e2?.notes &&
        e1?.payMethod == e2?.payMethod &&
        e1?.status == e2?.status &&
        e1?.dateCommand == e2?.dateCommand;
  }

  @override
  int hash(CommandRecord? e) => const ListEquality().hash([
        e?.productName,
        e?.fullName,
        e?.quantity,
        e?.total,
        e?.notes,
        e?.payMethod,
        e?.status,
        e?.dateCommand
      ]);

  @override
  bool isValidKey(Object? o) => o is CommandRecord;
}
