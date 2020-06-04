import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walletapp/providers/wallet_info.dart';
import 'package:walletapp/widgets/gradient_scaffold.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:walletapp/widgets/token_tile.dart';

class PortfolioScreen extends StatelessWidget {

  static const routeName = "/portfolio";

  final List<String> tokens = ["Bitcoin", "Ether", "Ripple"];

  @override
  Widget build(BuildContext context) {

    final walletData = Provider.of<WalletInfo>(context);

    return GradientScaffold(
      appBar: AppBar(
        //leading: Container(),
        title: Text("Portfolio"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GraphCard(),
            Divider(color: Colors.white,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Tokens", style: TextStyle(color: Colors.white, fontSize: 20),),
                  Icon(Icons.add_circle_outline, color: Colors.white, size: 28,),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemBuilder: (ctx, index) => TokenTile(
                  dollarAmount: 123.56,
                  percentage: 10.47,
                  token: tokens[index],
                  tokenAmount: 0.003354,
                ),
              itemCount: tokens.length,
            ),

          ],
        ),
      ),
      floatingButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

class GraphCard extends StatefulWidget {
  @override
  _GraphCardState createState() => _GraphCardState();
}

class _GraphCardState extends State<GraphCard> {
  var balance = "2,367.34";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(
              offset: Offset(12, 12),
              color: Colors.black12,
              blurRadius: 15,
            )]
        ),
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: GradientCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff11998e), Color(0xff38ef7d)]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Hi Alex",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        Consumer<WalletInfo>(
                          builder: (ctx, data, child) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                balance,
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                              FlatButton(
                                child: Text("Get Balance"),
                                onPressed: () {
                                  final s = data.balance.then((result)
                                  {
                                    setState(() {
                                      balance = "${result} ether";
                                    });
                                  });

                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: BezierChart(

                        bezierChartScale: BezierChartScale.CUSTOM,
                        xAxisCustomValues: [0, 5, 10, 15, 20, 25, 30, 35],
                        series: const [
                          BezierLine(
                            data: const [
                              DataPoint<double>(value: 10, xAxis: 0),
                              DataPoint<double>(value: 130, xAxis: 5),
                              DataPoint<double>(value: 50, xAxis: 10),
                              DataPoint<double>(value: 150, xAxis: 15),
                              DataPoint<double>(value: 75, xAxis: 20),
                              DataPoint<double>(value: 0, xAxis: 25),
                              DataPoint<double>(value: 5, xAxis: 30),
                              DataPoint<double>(value: 45, xAxis: 35),
                            ],
                          ),
                        ],
                        config: BezierChartConfig(
                            verticalIndicatorStrokeWidth: 1.0,
                            verticalIndicatorColor: Colors.black26,
                            showVerticalIndicator: false,
                            backgroundColor: Colors.transparent,
                            snap: false,
                            pinchZoom: true,
                            showDataPoints: false

                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
