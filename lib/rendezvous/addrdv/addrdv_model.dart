import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'addrdv_widget.dart' show AddrdvWidget;
import 'package:flutter/material.dart';

class AddrdvModel extends FlutterFlowModel<AddrdvWidget> {
  ///  Local state fields for this page.

  String selectedTime = '';

  DateTime? selectedDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDownspecialite widget.
  String? dropDownspecialiteValue;
  FormFieldController<String>? dropDownspecialiteValueController;
  // State field(s) for DropDownmedecin widget.
  String? dropDownmedecinValue;
  FormFieldController<String>? dropDownmedecinValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
