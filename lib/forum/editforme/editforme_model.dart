import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'editforme_widget.dart' show EditformeWidget;
import 'package:flutter/material.dart';

class EditformeModel extends FlutterFlowModel<EditformeWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for titre widget.
  FocusNode? titreFocusNode1;
  TextEditingController? titreTextController1;
  String? Function(BuildContext, String?)? titreTextController1Validator;
  // State field(s) for titre widget.
  FocusNode? titreFocusNode2;
  TextEditingController? titreTextController2;
  String? Function(BuildContext, String?)? titreTextController2Validator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titreFocusNode1?.dispose();
    titreTextController1?.dispose();

    titreFocusNode2?.dispose();
    titreTextController2?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController4?.dispose();
  }
}
