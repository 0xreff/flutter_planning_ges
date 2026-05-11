import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'user_products_widget.dart' show UserProductsWidget;
import 'package:flutter/material.dart';

class UserProductsModel extends FlutterFlowModel<UserProductsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for searctxt widget.
  FocusNode? searctxtFocusNode;
  TextEditingController? searctxtTextController;
  String? Function(BuildContext, String?)? searctxtTextControllerValidator;
  List<ProductRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searctxtFocusNode?.dispose();
    searctxtTextController?.dispose();
  }
}
