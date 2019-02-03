import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

class ScoreboardScreen extends StatelessWidget {
  final List<String> players;
  final List<List<int>> scoreboard;

  const ScoreboardScreen({this.players, this.scoreboard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      // leading: Icon(CommunityMaterialIcons.cards),
      title: Text("Scoreboard"),
    );
  }

  Widget buildBody(BuildContext context) {
    List<Row> rows = [];
    // Add PlayerNames row
    List<Container> namesRow = [
      Container(
        width: 50,
        height: 40,
      )
    ];
    for (int i = 0; i < players.length; i++) {
      namesRow.add(
        Container(
          width: 50,
          height: 40,
          child: Text(
            players[i].toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: namesRow));

    int games = scoreboard[0].length;
    // Add Gamewise score row
    for (int i = 0; i < games; i++) {
      List<Container> cells = [Container(child: Text((i + 1).toString()))];
      for (int j = 0; j < scoreboard.length; j++) {
        int gamePlayerScore = scoreboard[j][i]; // Player jth score in Game i
        cells.add(
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.grey),
            //   borderRadius: BorderRadius.circular(5.0),
            // ),
            child: Text(gamePlayerScore.toString()),
          ),
        );
      }
      rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: cells));
    }

    // Add Total sum row
    List<Container> sumRow = [
      Container(
        child: Text(
          "Total",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
    for (int i = 0; i < players.length; i++) {
      List<int> playerScore = scoreboard[i];
      int playerSum = 0;
      for (int j = 0; j < playerScore.length; j++) {
        playerSum = playerSum + playerScore[j];
      }
      sumRow.add(
        Container(
          child: Text(
            playerSum.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sumRow));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: ListView(
        children: rows,
      ),
    );
  }
}
