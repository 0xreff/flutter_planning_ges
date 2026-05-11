import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'aaddd_widget.dart' show AadddWidget;
import 'package:flutter/material.dart';

class AadddModel extends FlutterFlowModel<AadddWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for stock widget.
  FocusNode? stockFocusNode;
  TextEditingController? stockTextController;
  String? Function(BuildContext, String?)? stockTextControllerValidator;
  // State field(s) for descr widget.
  FocusNode? descrFocusNode;
  TextEditingController? descrTextController;
  String? Function(BuildContext, String?)? descrTextControllerValidator;
  bool isDataUploading_uploadData863 = false;
  FFUploadedFile uploadedLocalFile_uploadData863 =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Backend Call - API (Upload to Imgbb)] action in Container widget.
  ApiCallResponse? apiResultnz7;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    stockFocusNode?.dispose();
    stockTextController?.dispose();

    descrFocusNode?.dispose();
    descrTextController?.dispose();
  }
}
