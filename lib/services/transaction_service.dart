import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:bolso_organizado/repositories/transaction_repository.dart';

class TransactionService {
  final TransactionRepository _transactionRepository = TransactionRepository();

  Future<List<TransactionModel>> getAllByLoggedUser() async {
    try {
      final List<TransactionModel> listTransactionModel = [];
      final response = await _transactionRepository.getAllByLoggedUser();
      final docs = response.docs;

      for(var doc in docs){
        listTransactionModel.add(TransactionModel.fromJson(doc.id, doc.data()));
      }
      return listTransactionModel;
    } catch (err) {
      throw Exception("Problema ao buscar a lista.");
    }
  }

  Future<String> save(TransactionModel transactionModel, String userId) async {
    try {
      transactionModel = transactionModel.copyWith(userId: userId);

      final response = await _transactionRepository.save(transactionModel.toJson());

      return response.id;
    } catch (err) {
      throw Exception("Problema ao salvar uma TransactionModel.");
    }
  }

  Future<void> update(TransactionModel transactionModel, String userId) async {
    try {
      transactionModel = transactionModel.copyWith(userId: userId);

      return await _transactionRepository.update(transactionModel);
    } catch (err) {
      throw Exception("Problema ao atualizar uma TransactionModel.");
    }
  }

  Future<void> delete(String id) async {
    try {
      return await _transactionRepository.delete(id);
    } catch (err) {
      throw Exception("Problema ao deletar uma TransactionModel.");
    }
  }
}