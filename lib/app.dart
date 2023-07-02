import 'package:bolso_organizado/commons/constants/named_routes.dart';
import 'package:bolso_organizado/commons/themes/default_theme.dart';
import 'package:bolso_organizado/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme().defaultTheme,
      initialRoute: NamedRoute.SPLASH,
      routes: {
        //NamedRoute.INITIAL: (context) => const OnboardingPage(),
        NamedRoute.SPLASH: (context) => const SplashPage(),
        // NamedRoute.SIGN_UP: (context) => const SignUpPage(),
        // NamedRoute.SIGN_IN: (context) => const SignInPage(),
        // NamedRoute.HOME: (context) => const HomePageView(),
        // NamedRoute.STATS: (context) => const StatsPage(),
        // NamedRoute.WALLET: (context) => const WalletPage(),
        // NamedRoute.PROFILE: (context) => const ProfilePage(),
        // NamedRoute.TRANSACTION: (context) {
        //   final args = ModalRoute.of(context)?.settings.arguments;
        //   return TransactionPage(
        //     transaction: args != null ? args as TransactionModel : null,
        //   );
        //},
      },
    );
  }
}