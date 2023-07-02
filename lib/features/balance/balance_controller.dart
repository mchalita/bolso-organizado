import 'package:bolso_organizado/models/balances_model.dart';
import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';
import 'package:bolso_organizado_calculator/bolso_organizado_calculator.dart';
import 'package:flutter/foundation.dart';

import 'balance_state.dart';

class BalanceController extends ChangeNotifier {
  BalanceController({
    required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  BalanceState _state = BalanceStateInitial();

  BalanceState get state => _state;

  BalancesModel _balances = BalancesModel(
    totalIncome: 0,
    totalOutcome: 0,
    totalBalance: 0,
  );
  BalancesModel get balances => _balances;

  void _changeState(BalanceState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getBalances() async {
    _changeState(BalanceStateLoading());

    try{
      final List<TransactionModel> listTransactionModel = [];
      final List<double> listValue = [];
      final response = await transactionRepository.getAllByLoggedUser();
      final docs = response.docs;

      for(var doc in docs){
        listTransactionModel.add(TransactionModel.fromJson(doc.id, doc.data()));
      }

      for(var transactionModel in listTransactionModel){
        listValue.add(transactionModel.value);
      }

      Calculator calculator = Calculator();
      double totalIncome = calculator.calcularRenda(listValue);
      double totalOutcome = calculator.calcularDespesa(listValue);
      double totalBalance = calculator.calcularTotal(listValue);

      _balances = BalancesModel.fromValues(totalIncome, totalOutcome, totalBalance);
      _changeState(BalanceStateSuccess());
    }catch(error){
      _changeState(BalanceStateError());
    }
  }
}
