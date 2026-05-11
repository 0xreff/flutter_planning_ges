import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_product_widget.dart' show AddProductWidget;
import 'package:flutter/material.dart';

class AddProductModel extends FlutterFlowModel<AddProductWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'product canno\'t be empty';
    }

    if (val.length < 3) {
      return 'min 3 caracters';
    }

    return null;
  }

  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  String? _priceTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'price is required';
    }

    if (!RegExp('^\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'price digit and (+)';
    }
    return null;
  }

  // State field(s) for qnt widget.
  FocusNode? qntFocusNode;
  TextEditingController? qntTextController;
  String? Function(BuildContext, String?)? qntTextControllerValidator;
  String? _qntTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter quantity is required';
    }

    if (!RegExp('^\\d+(\\.\\d+)?\$').hasMatch(val)) {
      return 'quanity must be positif';
    }
    return null;
  }

  // State field(s) for descr widget.
  FocusNode? descrFocusNode;
  TextEditingController? descrTextController;
  String? Function(BuildContext, String?)? descrTextControllerValidator;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    priceTextControllerValidator = _priceTextControllerValidator;
    qntTextControllerValidator = _qntTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    qntFocusNode?.dispose();
    qntTextController?.dispose();

    descrFocusNode?.dispose();
    descrTextController?.dispose();
  }
}
