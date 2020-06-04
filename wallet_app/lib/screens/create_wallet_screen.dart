import 'package:flutter/material.dart';
import 'package:walletapp/screens/confirm_seedphrase_screen.dart';
import 'package:walletapp/widgets/gradient_scaffold.dart';
import 'package:bip39/bip39.dart' as bip39;

class CreateWalletScreen extends StatefulWidget {
  static const routeName = "/create_wallet";

  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  String seedPhrase;

  bool generated = false;

  @override
  Widget build(BuildContext context) {
    void generateKey() {
      setState(() {
        seedPhrase = bip39.generateMnemonic();
        generated = true;
      });
    }

    return GradientScaffold(
      appBar: AppBar(
        title: Text("Create New Wallet"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(12),
            child: Text(
              "Your seed phrase is used to generate and recover your private key",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onPressed: () {
              generateKey();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Generate Seed Phrase",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          generated == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "Your Seed Phrase:",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.white,
                      )),
                      child: SelectableText(
                        seedPhrase,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "Make sure to write down your seed phrase before continuing. Do not lose this seed phrase.",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          showDialog<void>(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  title: Text("Are you sure?"),
                                  content: Text(
                                    "Please make sure you have saved your seed phrase somewhere safe.",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: Colors.red,
                                      child: Text("Go Back"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.green,
                                      child: Text("Continue!"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                ConfirmSeedPhraseScreen
                                                    .routeName,
                                                arguments: seedPhrase);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        color: Colors.lightGreen,
                        child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              : Center()
        ],
      ),
    );
  }
}
