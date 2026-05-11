import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'stat_widget.dart' show StatWidget;
import 'package:flutter/material.dart';

class StatModel extends FlutterFlowModel<StatWidget> {
  ///  Local state fields for this component.

  List<ProductRecord> listProduct = [];
  void addToListProduct(ProductRecord item) => listProduct.add(item);
  void removeFromListProduct(ProductRecord item) => listProduct.remove(item);
  void removeAtIndexFromListProduct(int index) => listProduct.removeAt(index);
  void insertAtIndexInListProduct(int index, ProductRecord item) =>
      listProduct.insert(index, item);
  void updateListProductAtIndex(int index, Function(ProductRecord) updateFn) =>
      listProduct[index] = updateFn(listProduct[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in stat widget.
  List<ProductRecord>? listC;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
