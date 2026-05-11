import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'listerdv_widget.dart' show ListerdvWidget;
import 'package:flutter/material.dart';

class ListerdvModel extends FlutterFlowModel<ListerdvWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  var scannedText = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
