import 'package:flutter/cupertino.dart';
import 'package:sneaker_puma/data/services/operator_service.dart';
import 'package:sneaker_puma/models/operator.dart';

class OperatorViewmodel extends ChangeNotifier {
  final OperatorService apiService = OperatorService();

  List<Operator> operators = [];
  bool isLoading = false;
  String? error;

  Future<void> getOperators() async {
    try {
      isLoading = true;
      notifyListeners();
      operators = await apiService.fetchOperators();
      error = null;
    } catch (e){
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}