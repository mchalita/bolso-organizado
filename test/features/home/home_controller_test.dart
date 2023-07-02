import 'package:bolso_organizado/features/home/home_controller.dart';
import 'package:bolso_organizado/features/home/home_state.dart';
import 'package:bolso_organizado/models/transaction_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late HomeController sut;
  late MockTransactionService mockTransactionService;

  setUp(() {
    mockTransactionService = MockTransactionService();
    sut = HomeController(transactionService: mockTransactionService);
  });

  test('Test getAllTransactions success', () async {
    final transactions = [
      TransactionModel.fromMap({
        'id': '1',
        'title': 'Transaction 1',
        'description': 'Description 1',
        'value': 10.0,
        'date': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
        'status': false,
        'type': 'expense',
        'category': 'category',
        'user_id': '1'
      }),
      TransactionModel.fromMap({
        'id': '2',
        'title': 'Transaction 2',
        'description': 'Description 2',
        'value': 20.0,
        'date': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
        'status': false,
        'type': 'expense',
        'category': 'category',
        'user_id': '2'
      }),
    ];

    when(() => mockTransactionService.getAllByLoggedUser())
        .thenAnswer((_) async => transactions);

    expect(sut.state, isInstanceOf<HomeStateInitial>());
    expect(sut.transactions, isEmpty);

    await sut.getAllTransactions();

    expect(sut.state, isInstanceOf<HomeStateSuccess>());
    expect(sut.transactions, transactions);
  });

  test('Test getAllTransactions failure', () async {
    final errorMessage = 'Error occurred';

    when(() => mockTransactionService.getAllByLoggedUser())
        .thenThrow(Exception(errorMessage));

    expect(sut.state, isInstanceOf<HomeStateInitial>());
    expect(sut.transactions, isEmpty);

    await sut.getAllTransactions();

    expect(sut.state, isInstanceOf<HomeStateError>());
    expect(sut.transactions, isEmpty);
  });
}
