import 'package:bolso_organizado/models/balances_model.dart';
import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';
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
      final response = await transactionRepository.getAll();
      final docs = response.docs;

      for(var doc in docs){
        listTransactionModel.add(TransactionModel.fromJson(doc.id, doc.data()));
      }

      double totalIncome = 0;
      double totalOutcome = 0;
      double totalBalance = 0;

      for(var transactionModel in listTransactionModel){
        if(transactionModel.value > 0){
          totalIncome += transactionModel.value;
        }else{
          totalOutcome += transactionModel.value;
        }

        totalBalance += transactionModel.value;
      }

      _balances = BalancesModel.fromValues(totalIncome, totalOutcome, totalBalance);
      _changeState(BalanceStateSuccess());
    }catch(error){
      _changeState(BalanceStateError());
    }
  }
}
