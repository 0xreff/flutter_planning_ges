import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_command_widget.dart' show AddCommandWidget;
import 'package:flutter/material.dart';

class AddCommandModel extends FlutterFlowModel<AddCommandWidget> {
  ///  Local state fields for this component.

  double total = 1500.0;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for FullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter your full name is required';
    }

    return null;
  }

  // State field(s) for Quantity widget.
  FocusNode? quantityFocusNode;
  TextEditingController? quantityTextController;
  String? Function(BuildContext, String?)? quantityTextControllerValidator;
  String? _quantityTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter quantity is required';
    }

    return null;
  }

  // State field(s) for notes widget.
  FocusNode? notesFocusNode;
  TextEditingController? notesTextController;
  String? Function(BuildContext, String?)? notesTextControllerValidator;
  DateTime? datePicked;
  // State field(s) for card widget.
  FocusNode? cardFocusNode;
  TextEditingController? cardTextController;
  String? Function(BuildContext, String?)? cardTextControllerValidator;
  // State field(s) for exp widget.
  FocusNode? expFocusNode;
  TextEditingController? expTextController;
  String? Function(BuildContext, String?)? expTextControllerValidator;
  // State field(s) for cvv widget.
  FocusNode? cvvFocusNode;
  TextEditingController? cvvTextController;
  String? Function(BuildContext, String?)? cvvTextControllerValidator;
  // State field(s) for payMeth widget.
  FormFieldController<List<String>>? payMethValueController;
  String? get payMethValue => payMethValueController?.value?.firstOrNull;
  set payMethValue(String? val) =>
      payMethValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    quantityTextControllerValidator = _quantityTextControllerValidator;
  }

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    quantityFocusNode?.dispose();
    quantityTextController?.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();

    cardFocusNode?.dispose();
    cardTextController?.dispose();

    expFocusNode?.dispose();
    expTextController?.dispose();

    cvvFocusNode?.dispose();
    cvvTextController?.dispose();
  }
}
