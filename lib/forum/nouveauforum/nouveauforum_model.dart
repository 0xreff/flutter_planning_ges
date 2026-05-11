import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'nouveauforum_widget.dart' show NouveauforumWidget;
import 'package:flutter/material.dart';

class NouveauforumModel extends FlutterFlowModel<NouveauforumWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for titre widget.
  FocusNode? titreFocusNode1;
  TextEditingController? titreTextController1;
  String? Function(BuildContext, String?)? titreTextController1Validator;
  String? _titreTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ex: Cardiologie & Maladies cardiovasculaires is required';
    }

    if (val.length < 2) {
      return 'au moin 2';
    }
    if (val.length > 60) {
      return 'max 60';
    }

    return null;
  }

  // State field(s) for titre widget.
  FocusNode? titreFocusNode2;
  TextEditingController? titreTextController2;
  String? Function(BuildContext, String?)? titreTextController2Validator;
  String? _titreTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'calorie is required';
    }

    if (val.length < 5) {
      return 'au moin 5';
    }
    if (val.length > 20) {
      return 'max 20';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Décrivez l\'objectif et le contenu de ce forum médical... is required';
    }

    if (val.length < 10) {
      return 'au moin 10';
    }
    if (val.length > 150) {
      return 'max 150';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  String? _textController4Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'name is required';
    }

    if (val.length < 3) {
      return 'au moin 3';
    }
    if (val.length > 30) {
      return 'max 30';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    titreTextController1Validator = _titreTextController1Validator;
    titreTextController2Validator = _titreTextController2Validator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    textController4Validator = _textController4Validator;
  }

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
