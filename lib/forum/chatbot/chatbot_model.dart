import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'chatbot_widget.dart' show ChatbotWidget;
import 'package:flutter/material.dart';

class ChatbotModel extends FlutterFlowModel<ChatbotWidget> {
  ///  Local state fields for this page.

  String textreponse = 'unset';

  ///  State fields for stateful widgets in this page.

  // State field(s) for PromptField widget.
  FocusNode? promptFieldFocusNode;
  TextEditingController? promptFieldTextController;
  String? Function(BuildContext, String?)? promptFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (Chatbot)] action in Container widget.
  ApiCallResponse? apiResultoku;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    promptFieldFocusNode?.dispose();
    promptFieldTextController?.dispose();
  }
}
