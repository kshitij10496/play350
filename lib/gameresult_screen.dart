import 'package:flutter/material.dart';
import 'player.dart';
import 'utils.dart';
import 'gamebidder_screen.dart';
import 'package:community_material_icon/community_material_icon.dart';

class GameResultScreen extends StatelessWidget {
  final String boardID;
  final int gameID;
  final List<String> players;
  final String bidder;
  final int bid;
  final String trump;
  final List<String> biddersTeam;
  final List<String> opposition;
  final int oppScore;

  const GameResultScreen({
    this.boardID,
    this.gameID,
    this.players,
    this.bidder,
    this.bid,
    this.trump,
    this.biddersTeam,
    this.opposition,
    this.oppScore,
  });

  bool hasBidderWon() => ((350 - oppScore) >= bid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      leading: Icon(CommunityMaterialIcons.cards),
      title: Text("Game $gameID: Result"),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildGameInfo(context),
          buildDivider(context),
          _buildBidderTeam(context),
          _buildScores(context),
          _buildOpposition(context),
          buildDivider(context),
          _buildNewGameButton(context),
          // buildScoreboardButton(context),
        ],
      ),
    );
  }

  Widget _buildGameInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Game Info",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFFFFE070),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 25,
                  child: Text(bidder[0] + bidder[1]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  bid.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(child: getTrumpIcon(trump)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBidderTeam(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.0),
        color: hasBidderWon() ? Colors.lightGreen[400] : Colors.red[200],
      ),
      child: _buildBidderMemberLayout(context),
    );
  }

  Widget _buildScores(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                (350 - oppScore).toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _buildVLayout(context),
          Container(
            width: 100,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                oppScore.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVLayout(BuildContext context) {
    return Container(
      width: 50,
      padding: EdgeInsets.all(8),
      // decoration: BoxDecoration(
      //   border: Border.all(),
      //   borderRadius: BorderRadius.circular(5.0),
      //   color: Colors.red,
      // ),
      child: Center(
        child: Text(
          "v",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildBidderMemberLayout(BuildContext context) {
    List<PlayerBox> membersWidget = [];

    for (int i = 0; i < biddersTeam.length; i++) {
      membersWidget.add(PlayerBox(biddersTeam[i]));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: membersWidget,
    );
  }

  Widget _buildOpposition(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5.0),
        color: hasBidderWon() ? Colors.red[200] : Colors.lightGreen[400],
      ),
      child: _buildOppositionLayout(context),
    );
  }

  Widget _buildOppositionLayout(BuildContext context) {
    List<PlayerBox> membersWidget = [];
    for (int i = 0; i < opposition.length; i++) {
      membersWidget.add(PlayerBox(opposition[i]));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: membersWidget,
    );
  }

  Widget _buildNewGameButton(BuildContext context) {
    return RaisedButton(
      color: Colors.green,
      textColor: Colors.white,
      disabledColor: Colors.white,
      disabledTextColor: Colors.green,
      child: Text(
        "Next",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameBidderScreen(
                  boardID: boardID,
                  gameID: gameID + 1,
                  players: players,
                ),
          ),
        );
      },
    );
  }

  // Widget buildScoreboardButton(BuildContext context) {
  //   return Container(
  //     child: _buildScoreboardLayout(context),
  //   );
  // }
}
