import 'package:bolso_organizado/models/balances_model.dart';
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

    // final result = await transactionRepository.getBalances();
    //
    // result.fold(
    //   (error) => _changeState(BalanceStateError()),
    //   (data) {
    //     _balances = data;
    //
    //     _changeState(BalanceStateSuccess());
    //   },
    // );
  }
}
