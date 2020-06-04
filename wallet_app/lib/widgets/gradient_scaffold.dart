import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  AppBar appBar;
  Widget body;
  FloatingActionButton floatingButton;
  FloatingActionButtonLocation floatingButtonLocation;

  GradientScaffold({this.appBar, this.body, this.floatingButton, this.floatingButtonLocation});

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
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButtonLocation: floatingButtonLocation,
        floatingActionButton: floatingButton,
      ),
    );
  }
}
