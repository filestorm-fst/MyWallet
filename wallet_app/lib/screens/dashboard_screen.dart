import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/providers/wallet_info.dart';
import 'package:walletapp/widgets/gradient_scaffold.dart';
import 'package:web3dart/credentials.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard_screen';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<EthereumAddress> importWalletInfo() {
    final walletData = Provider.of<WalletInfo>(context);
    return walletData.importWallet();
  }

  TextEditingController sendTo = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final walletData = Provider.of<WalletInfo>(context);

    return GradientScaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          //walletData.balance;
          return;
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(12),
                          height: 200,
                          child: Text(
                            "Public Address: ${walletData.publicAddress.toString()}",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            margin: EdgeInsets.all(12),
                            child: Form(
                              autovalidate: true,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Send Transaction",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: sendTo,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.white70),
                                      labelText:
                                          "Enter address for transaction",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (double.tryParse(value) == null)
                                        return "Not a valid amount";
                                      return null;
                                    },
                                    controller: amount,
                                    textInputAction: TextInputAction.done,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true, signed: true),
                                    decoration: InputDecoration(
                                      labelStyle:
                                          TextStyle(color: Colors.white70),
                                      labelText: "Enter amount to send",
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                future: importWalletInfo(),
              ),
              FutureBuilder(
                builder: (ctx, snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: <Widget>[
                        Text(
                          "Your Balance: ${snapshot.data}",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
                future: walletData.balance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
