import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletapp/providers/wallet_info.dart';
import 'package:walletapp/screens/confirm_seedphrase_screen.dart';
import 'package:walletapp/screens/create_wallet_screen.dart';
import 'package:walletapp/screens/dashboard_screen.dart';
import 'package:walletapp/screens/portfolio_screen.dart';
import 'package:walletapp/screens/intro_screen.dart';
import 'package:walletapp/screens/tempRPCTest_screen.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

//import 'dart:js';
import 'providers/eth_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sp = await SharedPreferences.getInstance();
  bool dashboard = false;
  if (sp.getString('wallet') != null) {
    dashboard = true;
  }
  runApp(MyApp(dashboard));
}

class MyApp extends StatelessWidget {
  String apiUrl = "http://127.0.0.1:8545";
  bool dashboard;

  MyApp(this.dashboard);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => WalletInfo(apiUrl)),
      ],
      child: MaterialApp(
        title: 'Wallet',
        theme: ThemeData(
          primaryColor: Color(0xff485563),
          accentColor: Color(0xff29323c),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: dashboard ? DashboardScreen() : IntroScreen(),
        routes: {
          CreateWalletScreen.routeName: (ctx) => CreateWalletScreen(),
          ConfirmSeedPhraseScreen.routeName: (ctx) => ConfirmSeedPhraseScreen(),
          PortfolioScreen.routeName: (ctx) => PortfolioScreen(),
          DashboardScreen.routeName: (ctx) => DashboardScreen(),
        },
      ),
    );
  }
}
