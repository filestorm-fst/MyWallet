import 'package:flutter/material.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:http/http.dart' as http;

class TemRPCTest extends StatefulWidget {
  List<String> parameters = [];
  @override
  _TemRPCTestState createState() => _TemRPCTestState();
}

class _TemRPCTestState extends State<TemRPCTest> {
  TextEditingController command = TextEditingController();
  TextEditingController params = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter RPC command",
                ),
                controller: command,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Parameters",
                ),
                controller: params,
              ),
            ),
          ),
          FlatButton(
            child: Text("Submit"),
            onPressed: () async {
              String apiUrl = "http://127.0.0.1:8545";
              var httpClient = http.Client();
              widget.parameters = [];
              widget.parameters = params.text.split(" ");
              print(widget.parameters);
              final jRPC = JsonRPC(apiUrl, httpClient);
              RPCResponse res;
              if(params.text.isEmpty) res = await jRPC.call(command.text);
              else res = await jRPC.call(command.text, widget.parameters);
              print(res.id);
              print(res.result);
            },
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
