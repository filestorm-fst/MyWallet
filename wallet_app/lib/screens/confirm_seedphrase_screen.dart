import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/providers/wallet_info.dart';
import 'package:walletapp/screens/dashboard_screen.dart';
import 'package:walletapp/screens/portfolio_screen.dart';
import 'package:walletapp/widgets/gradient_scaffold.dart';
import 'package:bip39/bip39.dart' as bip39;

class ConfirmSeedPhraseScreen extends StatefulWidget {
  static const routeName = "/confirm_seedphrase";

  @override
  _ConfirmSeedPhraseScreenState createState() =>
      _ConfirmSeedPhraseScreenState();
}

class _ConfirmSeedPhraseScreenState extends State<ConfirmSeedPhraseScreen> {
  TextEditingController seed = TextEditingController();
  bool creatingWallet = false;

  @override
  Widget build(BuildContext context) {
    final walletData = Provider.of<WalletInfo>(context, listen: false);
    final _formKey = GlobalKey<FormState>();
    final seedPhrase = ModalRoute.of(context).settings.arguments;

    bool validateMnemonic(String mnem) {
      String mnemHex = bip39.mnemonicToSeedHex(mnem);
      String seedHex = bip39.mnemonicToSeedHex(seedPhrase);
      return mnemHex == seedHex;
    }

    Future<void> createWallet() {
      return walletData.createWallet(seedPhrase).then((res) {
        print(walletData.publicAddress);
        print(walletData.balance);
      });
    }

    return GradientScaffold(
      appBar: AppBar(
        title: Text("Confirm Seed Phrase"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            creatingWallet == true
                ? Center(
                  child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                )
                : Container(),
            Container(
              margin: EdgeInsets.all(12),
              child: Text(
                "Please confirm your seed phrase below",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                maxLines: 3,
                minLines: 3,
                controller: seed,
                style: TextStyle(fontSize: 24, color: Colors.white70),
                decoration: InputDecoration(
                    labelText: "Enter seed phrase",
                    labelStyle: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                if (validateMnemonic(seed.text) == false) {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: Text("Incorrect Seed Phrase"),
                          content: Text(
                              "The seed phrase you entered is incorrect, please try again."),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              child: Text("Try Again"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                  return;
                }
                setState(() {
                  creatingWallet = true;
                });
                createWallet().then((res) {
                  setState(() {
                    creatingWallet = false;
                  });
                  Navigator.of(context)
                      .pushReplacementNamed(DashboardScreen.routeName);
                });
              },
              color: Colors.lightGreen,
              child: Text(
                "Create Wallet",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
