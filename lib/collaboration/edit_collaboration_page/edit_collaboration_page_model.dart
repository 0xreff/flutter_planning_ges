import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_collaboration_page_widget.dart' show EditCollaborationPageWidget;
import 'package:flutter/material.dart';

class EditCollaborationPageModel
    extends FlutterFlowModel<EditCollaborationPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  // State field(s) for DropDown_partner widget.
  String? dropDownPartnerValue;
  FormFieldController<String>? dropDownPartnerValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for notes widget.
  FocusNode? notesFocusNode;
  TextEditingController? notesTextController;
  String? Function(BuildContext, String?)? notesTextControllerValidator;
  // State field(s) for DropDown_status widget.
  String? dropDownStatusValue;
  FormFieldController<String>? dropDownStatusValueController;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  bool isDataUploading_uploadDataMvs = false;
  FFUploadedFile uploadedLocalFile_uploadDataMvs =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataMvs = '';

  bool isDataUploading_uploadDataOhh = false;
  FFUploadedFile uploadedLocalFile_uploadDataOhh =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();

    notesFocusNode?.dispose();
    notesTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
