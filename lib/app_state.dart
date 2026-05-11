import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int value) {
    _pageIndex = value;
  }

  String _pdfPath = '';
  String get pdfPath => _pdfPath;
  set pdfPath(String value) {
    _pdfPath = value;
  }

  String _sheet1 = '';
  String get sheet1 => _sheet1;
  set sheet1(String value) {
    _sheet1 = value;
  }

  bool _search = false;
  bool get search => _search;
  set search(bool value) {
    _search = value;
  }

  bool _date = false;
  bool get date => _date;
  set date(bool value) {
    _date = value;
  }

  DocumentReference? _user;
  DocumentReference? get user => _user;
  set user(DocumentReference? value) {
    _user = value;
  }

  bool _result = false;
  bool get result => _result;
  set result(bool value) {
    _result = value;
  }

  List<String> _img = [];
  List<String> get img => _img;
  set img(List<String> value) {
    _img = value;
  }

  void addToImg(String value) {
    img.add(value);
  }

  void removeFromImg(String value) {
    img.remove(value);
  }

  void removeAtIndexFromImg(int index) {
    img.removeAt(index);
  }

  void updateImgAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    img[index] = updateFn(_img[index]);
  }

  void insertAtIndexInImg(int index, String value) {
    img.insert(index, value);
  }

  String _qrPayload = '';
  String get qrPayload => _qrPayload;
  set qrPayload(String value) {
    _qrPayload = value;
  }
}
