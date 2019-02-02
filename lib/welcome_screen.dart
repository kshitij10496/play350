import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'players_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      // iconTheme: Theme.of(context).iconTheme,
      backgroundColor: Theme.of(context).accentColor,
      leading: Icon(CommunityMaterialIcons.cards),
      title: Text("Play 350"),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            //decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: Text(
                "LET'S",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: Text(
                "PLAY",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Center(
              child: Text(
                "350",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(CommunityMaterialIcons.cards_club),
                Icon(CommunityMaterialIcons.cards_diamond, color: Colors.red),
                Icon(CommunityMaterialIcons.cards_heart, color: Colors.red),
                Icon(CommunityMaterialIcons.cards_spade),
              ],
            ),
          ),
          RaisedButton(
            color: Theme.of(context).buttonColor,
            splashColor: Theme.of(context).splashColor,
            onPressed: () {
              // Create a new document and move to new route
              print("Creating new table!");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlayersScreen()));
            },
            child: const Text(
              "New Table",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
