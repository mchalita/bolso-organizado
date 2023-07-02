import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/app_text_styles.dart';
import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/extensions/sizes.dart';
import 'package:bolso_organizado/commons/widgets/app_header.dart';
import 'package:bolso_organizado/commons/widgets/custom_bottom_sheet.dart';
import 'package:bolso_organizado/commons/widgets/custom_circular_progress_indicator.dart';
import 'package:bolso_organizado/commons/widgets/transaction_listview.dart';
import 'package:bolso_organizado/features/balance/balance.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import 'home_controller.dart';
import 'home_state.dart';
import 'widgets/balance_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CustomModalSheetMixin {
  final homeController = locator.get<HomeController>();
  final balanceController = locator.get<BalanceController>();

  @override
  void initState() {
    super.initState();

    homeController.getLatestTransactions();
    balanceController.getBalances();

    homeController.addListener(() {
      if (homeController.state is HomeStateError) {
        if (!mounted) return;

        showCustomModalBottomSheet(
          context: context,
          content: (homeController.state as HomeStateError).message,
          buttonText: 'Go to login',
          isDismissible: false,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.SIGN_IN,
            ModalRoute.withName(NamedRoute.INITIAL),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppHeader(),
          BalanceCardWidget(controller: balanceController),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transaction History',
                        style: AppTextStyles.mediumText18,
                      ),
                      GestureDetector(
                        onTap: () {
                          homeController.pageController.jumpToPage(2);
                        },
                        child: const Text(
                          'See all',
                          style: AppTextStyles.inputLabelText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: homeController,
                    builder: (context, _) {
                      if (homeController.state is HomeStateLoading) {
                        return const CustomCircularProgressIndicator(
                          color: AppColors.green,
                        );
                      }
                      if (homeController.state is HomeStateError) {
                        return const Center(
                          child: Text('An error has occurred'),
                        );
                      }

                      if (homeController.state is HomeStateSuccess &&
                          homeController.transactions.isNotEmpty) {
                        return TransactionListView(
                          transactionList: homeController.transactions,
                          itemCount: homeController.transactions.length,
                          onChange: () {
                            homeController
                                .getLatestTransactions()
                                .then((_) => balanceController.getBalances());
                          },
                        );
                      }

                      return const Center(
                        child: Text('Nenhum registro encontrado.'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}