import 'package:bolso_organizado/commons/constants/app_colors.dart';
import 'package:bolso_organizado/commons/constants/keys.dart';
import 'package:bolso_organizado/commons/widgets/custom_bottom_app_bar.dart';
import 'package:bolso_organizado/features/balance/balance.dart';
import 'package:bolso_organizado/features/profile/profile_page.dart';
import 'package:bolso_organizado/features/transaction/transaction.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final homeController = locator.get<HomeController>();
  //final walletController = locator.get<WalletController>();
  final balanceController = locator.get<BalanceController>();

  @override
  void initState() {
    super.initState();
    homeController.setPageController = PageController();
  }

  @override
  void dispose() {
    locator.resetLazySingleton<HomeController>();
    locator.resetLazySingleton<BalanceController>();
    //locator.resetLazySingleton<WalletController>();
    locator.resetLazySingleton<TransactionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: homeController.pageController,
        children: const [
          HomePage(),
          // StatsPage(),
          // WalletPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/transaction');
          if (result != null) {
            if (homeController.pageController.page == 0) {
              homeController.getAllTransactions();
            }
            if (homeController.pageController.page == 2) {
              //walletController.getAllTransactions();
            }
            balanceController.getBalances();
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        controller: homeController.pageController,
        selectedItemColor: AppColors.blue,
        children: [
          CustomBottomAppBarItem.empty(),
          CustomBottomAppBarItem(
            key: Keys.homePageBottomAppBarItem,
            label: 'home',
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => homeController.pageController.jumpToPage(
              0,
            ),
          ),
          CustomBottomAppBarItem.empty(),
          CustomBottomAppBarItem(
            key: Keys.profilePageBottomAppBarItem,
            label: 'profile',
            primaryIcon: Icons.person,
            secondaryIcon: Icons.person_outline,
            onPressed: () => homeController.pageController.jumpToPage(
              1,
            ),
          ),
          CustomBottomAppBarItem.empty(),
        ],
      ),
    );
  }
}
