import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:bolso_organizado/services/transaction_service.dart';
import 'package:flutter/material.dart';

import 'home_state.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required this.transactionService,
  });

  final TransactionService transactionService;

  HomeState _state = HomeStateInitial();

  HomeState get state => _state;

  late PageController _pageController;
  PageController get pageController => _pageController;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    _changeState(HomeStateLoading());

    try{
      _transactions = await transactionService.getAll();

      _changeState(HomeStateSuccess());
    }catch(error){
      _changeState(HomeStateError(message: error.toString()));
    }
  }
}
