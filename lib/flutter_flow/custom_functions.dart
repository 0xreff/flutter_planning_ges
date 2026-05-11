import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime? add1day() {
  DateTime addOneDay(DateTime date) {
    return date.add(Duration(days: 1));
  }
}

DateTime? substract1day() {
  DateTime subtractOneDay(DateTime date) {
    return date.subtract(Duration(days: 1));
  }
}

String? buildQrData(
  String? doctorId,
  String? speciality,
  String? startTime,
  String? status,
) {
  // Write a Dart function body only (no imports, no function signature) that returns a String combining doctorId, speciality, startTime and status separated by newlines in this format: Doctor: {doctorId} Speciality: {speciality} Date: {startTime} Status: {status} Use null safety with ?? operator. Return only the string, no other code.
  return 'Doctor: ${doctorId ?? 'N/A'}\nSpeciality: ${speciality ?? 'N/A'}\nDate: ${startTime ?? 'N/A'}\nStatus: ${status ?? 'N/A'}';
}

List<String> getLabels(List<ProductRecord> docs) {
  List<String> types = [];
  for (var doc in docs) {
    if (!types.contains(doc.type)) {
      types.add(doc.type);
    }
  }
  return types;
}

List<double> getValues(List<ProductRecord> docs) {
  Map<String, int> counts = {};
  for (var doc in docs) {
    counts[doc.type] = (counts[doc.type] ?? 0) + 1;
  }
  return counts.values.map((e) => e.toDouble()).toList();
}

double calculateTotal(
  double price,
  int quantity,
) {
  return price * quantity;
}

String buildCommandQrPayload(
  double? total,
  String? paymentMethod,
  String? clientName,
  DateTime? desiredDate,
) {
  String formatDate(DateTime? d) {
    if (d == null) return '';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }

  final data = {
    'client': clientName ?? 'N/A',
    'total': (total ?? 0.0).toStringAsFixed(2),
    'payment': paymentMethod ?? 'N/A',
    'date': formatDate(desiredDate),
    'v': 1,
  };

  return jsonEncode(data);
}
