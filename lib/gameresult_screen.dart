import 'package:flutter/material.dart';
import 'player.dart';
import 'utils.dart';
import 'scoreboard_screen.dart';
import 'gamebidder_screen.dart';
import 'package:community_material_icon/community_material_icon.dart';

class GameResultScreen extends StatefulWidget {
  final String boardID;
  final int gameID;
  final List<String> players;
  final List<List<int>> scoreboard;
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
    this.scoreboard,
    this.bidder,
    this.bid,
    this.trump,
    this.biddersTeam,
    this.opposition,
    this.oppScore,
  });

  bool hasBidderWon() => ((350 - oppScore) >= bid);

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  bool _isScoreboardUpdated = false;
  List<List<int>> _updatedScoreboard = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    int gameID = widget.gameID;
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
          _buildOptions(context),
          // _buildNewGameButton(context),
          // _buildScoreboardButton(context),
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
                  child: Text(widget.bidder[0] + widget.bidder[1]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.bid.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(child: getTrumpIcon(widget.trump)),
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
        color: widget.hasBidderWon() ? Colors.lightGreen[400] : Colors.red[200],
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
                (350 - widget.oppScore).toString(),
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
                widget.oppScore.toString(),
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

    for (int i = 0; i < widget.biddersTeam.length; i++) {
      membersWidget.add(PlayerBox(widget.biddersTeam[i]));
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
        color: widget.hasBidderWon() ? Colors.red[200] : Colors.lightGreen[400],
      ),
      child: _buildOppositionLayout(context),
    );
  }

  Widget _buildOppositionLayout(BuildContext context) {
    List<PlayerBox> membersWidget = [];
    for (int i = 0; i < widget.opposition.length; i++) {
      membersWidget.add(PlayerBox(widget.opposition[i]));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: membersWidget,
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildNewGameButton(context),
        _buildScoreboardButton(context),
      ],
    );
  }

  Widget _buildNewGameButton(BuildContext context) {
    return RaisedButton(
      color: Colors.green,
      textColor: Colors.white,
      disabledColor: Colors.white,
      disabledTextColor: Colors.green,
      child: Text(
        "New Game",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (!_isScoreboardUpdated) {
          _updateScoreboard();
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameBidderScreen(
                  boardID: widget.boardID,
                  gameID: widget.gameID + 1,
                  players: widget.players,
                  scoreboard: _updatedScoreboard,
                ),
          ),
        );
      },
    );
  }

  void _updateScoreboard() {
    if (!_isScoreboardUpdated) {
      print("updating scoreboard");
      int bidderPoints;
      int bidderMemberPoints;
      int oppositionMemberPoints;

      if (widget.oppScore == 0) {
        bidderPoints = 350;
        bidderMemberPoints = 350;
        oppositionMemberPoints = 0;
      } else if (widget.hasBidderWon()) {
        bidderPoints = widget.bid;
        bidderMemberPoints = widget.bid ~/ widget.biddersTeam.length;
        oppositionMemberPoints = 0;
      } else {
        bidderPoints = -widget.bid;
        bidderMemberPoints = -(widget.bid ~/ widget.biddersTeam.length);
        oppositionMemberPoints = widget.oppScore ~/ widget.opposition.length;
      }

      setState(() {
        for (int i = 0; i < widget.players.length; i++) {
          List<int> playerScore = widget.scoreboard[i];
          if (widget.players[i] == widget.bidder) {
            playerScore.add(bidderPoints);
          } else if (widget.biddersTeam.contains(widget.players[i])) {
            playerScore.add(bidderMemberPoints);
          } else {
            playerScore.add(oppositionMemberPoints);
          }
          _updatedScoreboard.add(playerScore);
        }
        _isScoreboardUpdated = true;
      });
    }
  }

  Widget _buildScoreboardButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        color: Colors.green,
        textColor: Colors.white,
        disabledColor: Colors.white,
        disabledTextColor: Colors.green,
        child: Text(
          "Scoreboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (!_isScoreboardUpdated) {
            _updateScoreboard();
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScoreboardScreen(
                    players: widget.players,
                    scoreboard: _updatedScoreboard,
                  ),
            ),
          );
        },
      ),
    );
  }
}
