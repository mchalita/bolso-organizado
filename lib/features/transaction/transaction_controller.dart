import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:flutter/foundation.dart';

import '../../../repositories/repositories.dart';
import 'transaction_state.dart';

class TransactionController extends ChangeNotifier {
  TransactionController({
    required this.transactionRepository,
  });

  final TransactionRepository transactionRepository;

  TransactionState _state = TransactionStateInitial();

  TransactionState get state => _state;

  void _changeState(TransactionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());

    // final data = await storage.readOne(key: 'CURRENT_USER');
    // final user = UserModel.fromJson(data ?? '');
    // final result = await transactionRepository.addTransaction(
    //   transaction: transaction,
    //   userId: user.id!,
    // );

    // result.fold(
    //   (error) => _changeState(TransactionStateError(message: error.message)),
    //   (data) => _changeState(TransactionStateSuccess()),
    // );
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());
    final result = await transactionRepository.updateTransaction(transaction);

    result.fold(
      (error) => _changeState(TransactionStateError(message: error.message)),
      (data) => _changeState(TransactionStateSuccess()),
    );
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());
    final result = await transactionRepository.deleteTransaction(transaction);

    result.fold(
      (error) => _changeState(TransactionStateError(message: error.message)),
      (data) => _changeState(TransactionStateSuccess()),
    );
  }
}
