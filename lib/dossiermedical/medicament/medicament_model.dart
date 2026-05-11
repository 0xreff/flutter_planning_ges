import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'medicament_widget.dart' show MedicamentWidget;
import 'package:flutter/material.dart';

class MedicamentModel extends FlutterFlowModel<MedicamentWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Le nom est obligatoire';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (medicament)] action in Button widget.
  ApiCallResponse? apiResultenu;

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
