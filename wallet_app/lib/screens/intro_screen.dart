import 'package:flutter/material.dart';
import 'package:walletapp/screens/create_wallet_screen.dart';
import 'package:walletapp/widgets/gradient_scaffold.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/json_rpc.dart';

class IntroScreen extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ])),
        child: GradientScaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Create or Import Wallet"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Create new wallet",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CreateWalletScreen.routeName);
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text("Import existing wallet",
                        style: Theme.of(context).textTheme.headline6),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
