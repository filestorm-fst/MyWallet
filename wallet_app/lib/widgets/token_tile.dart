import 'package:flutter/material.dart';

class TokenTile extends StatelessWidget {
  final String token;
  final double tokenAmount;
  final double dollarAmount;
  final double percentage;

  TokenTile({this.token, this.tokenAmount, this.dollarAmount, this.percentage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.monetization_on,
          color: Colors.white,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            token,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            "\$${dollarAmount.toStringAsFixed(2)}",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${tokenAmount.toStringAsFixed(5)}",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            "${percentage.toStringAsFixed(2)}%",
            style: TextStyle(color: Colors.greenAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
