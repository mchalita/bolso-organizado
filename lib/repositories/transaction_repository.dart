import 'dart:async';

import 'package:bolso_organizado/commons/data/data.dart';
import 'package:bolso_organizado/models/balances_model.dart';
import 'package:bolso_organizado/models/transaction_model.dart';


/// {@template transaction_repository}
/// Communicates Transactions CRUD operations between Controllers and Data Sources
/// {@endtemplate}
abstract class TransactionRepository {
  static const transactionsPath = 'transactions';
  static const balancesPath = 'balances';
  static const localChanges = 'local_changes';

  Future<DataResult<bool>> addTransaction({
    required TransactionModel transaction,
    required String userId,
  });

  Future<DataResult<bool>> updateTransaction(TransactionModel transaction);

  Future<DataResult<List<TransactionModel>>> getTransactions({
    int? limit,
    int? offset,
    bool latest = false,
  });

  Future<DataResult<bool>> deleteTransaction(TransactionModel transaction);

  Future<DataResult<BalancesModel>> getBalances();

  Future<void> updateBalance(TransactionModel newtTansaction);
}
