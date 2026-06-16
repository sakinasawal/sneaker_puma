import 'package:flutter/material.dart';
import '../../../domain/models/contract.dart';
import '../../../data/services/contract_service.dart';

class ContractViewModel extends ChangeNotifier {
  final ContractService _apiService = ContractService();

  List<Contract> contracts = [];

  bool isLoading = false;
  String? error;

  Future<void> getContracts() async {
    try {
      isLoading = true;
      notifyListeners();

      contracts = await _apiService.fetchContracts();

      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}