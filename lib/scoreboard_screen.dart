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
    List<TableRow> rows = [];

    // Add PlayerNames row
    List<Container> namesRow = [];
    for (int i = 0; i < players.length; i++) {
      namesRow.add(Container(child: Text(players[i].toString())));
    }
    rows.add(TableRow(children: namesRow));

    int games = scoreboard[0].length;
    // Add Gamewise score row
    for (int i = 0; i < games; i++) {
      List<Container> cells = [];
      for (int j = 0; j < scoreboard.length; j++) {
        int gamePlayerScore = scoreboard[j][i]; // Player jth score in Game i
        cells.add(Container(child: Text(gamePlayerScore.toString())));
      }
      rows.add(TableRow(children: cells));
    }

    // Add Total sum row
    List<Container> sumRow = [];
    for (int i = 0; i < players.length; i++) {
      List<int> playerScore = scoreboard[i];
      int playerSum = 0;
      for (int j = 0; j < playerScore.length; j++) {
        playerSum = playerSum + playerScore[j];
      }
      sumRow.add(Container(child: Text(playerSum.toString())));
    }
    rows.add(TableRow(children: sumRow));

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 48),
      child: Table(
        children: rows,
      ),
    );
  }
}
