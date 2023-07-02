import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:bolso_organizado/models/user_model.dart';
import 'package:bolso_organizado/services/secure_storage.dart';
import 'package:bolso_organizado/services/transaction_service.dart';
import 'package:flutter/foundation.dart';

import 'transaction_state.dart';

class TransactionController extends ChangeNotifier {
  TransactionController({
    required this.transactionService,
    required this.storage,
  });

  final TransactionService transactionService;
  final SecureStorageService storage;

  TransactionState _state = TransactionStateInitial();

  TransactionState get state => _state;

  void _changeState(TransactionState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());

    final data = await storage.readOne(key: 'CURRENT_USER');
    final user = UserModel.fromJson(data ?? '');

    try{
      await transactionService.save(transaction, user.id!,);

      _changeState(TransactionStateSuccess());
    }catch(error){
      _changeState(TransactionStateError(message: error.toString()));
    }
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());

    final data = await storage.readOne(key: 'CURRENT_USER');
    final user = UserModel.fromJson(data ?? '');

    try{
      await transactionService.update(transaction, user.id!,);

      _changeState(TransactionStateSuccess());
    }catch(error){
      _changeState(TransactionStateError(message: error.toString()));
    }
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    _changeState(TransactionStateLoading());

    try{
      await transactionService.delete(transaction.id!);

      _changeState(TransactionStateSuccess());
    }catch(error){
      _changeState(TransactionStateError(message: error.toString()));
    }
  }
}
