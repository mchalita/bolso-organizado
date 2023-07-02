import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Repository {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final String _collection;

  Repository(this._collection);

  Future<QuerySnapshot<Map<String, dynamic>>> getAll() {
    return db.collection(_collection).get();
  }

  //TODO testar
  Future<QuerySnapshot<Map<String, dynamic>>> getAllByLoggedUser() {
    return db.collection(_collection).doc(auth.currentUser?.uid).collection("minhas_tarefas").get();
  }

  Future<DocumentReference<Map<String, dynamic>>> save(Map<String, dynamic> data) {
    return db.collection(_collection).add(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String id) {
    return db.collection(_collection).doc(id).get();
  }

  Future<void> update(TransactionModel transactionModel) {
    return db.collection(_collection).doc(transactionModel.id).set(transactionModel.toJson());
  }

  Future<void> delete(String id) {
    return db.collection(_collection).doc(id).delete();
  }
}