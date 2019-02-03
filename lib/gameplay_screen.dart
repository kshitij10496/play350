import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'player.dart';
import 'utils.dart';
import 'gameresult_screen.dart';

class GamePlayScreen extends StatefulWidget {
  final String boardID;
  final int gameID;
  final List<String> players;
  final List<List<int>> scoreboard;

  final String bidder;
  final int bid;
  final String trump;

  const GamePlayScreen({
    this.boardID,
    this.gameID,
    this.players,
    this.scoreboard,
    this.bidder,
    this.bid,
    this.trump,
  })  : assert(boardID != null),
        assert(gameID != null),
        assert(players != null),
        assert(bidder != null),
        assert(bid != null),
        assert(trump != null);

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  List<String> undecidedPlayers = [];
  List<String> biddersTeam = [];
  List<String> opposition = [];
  int oppScore = 0;

  @override
  void initState() {
    super.initState();
    biddersTeam = [widget.bidder];

    for (String p in widget.players) {
      if (p != widget.bidder) {
        undecidedPlayers.add(p);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: buildBody(context),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: _buildNextButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildAppBar(BuildContext context) {
    int gameID = widget.gameID;
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      leading: Icon(CommunityMaterialIcons.cards),
      title: Text("Game $gameID: Play"),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 48),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildGameInfo(context),
          buildDivider(context),
          _buildBidderTeam(context),
          _buildPlayers(context),
          _buildOpposition(context),
          buildDivider(context),
          _buildOppositionScore(context),
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
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        List<PlayerDragBox> membersWidget = [];
        for (int i = 0; i < biddersTeam.length; i++) {
          // if (biddersTeam[i] == widget.bidder) {
          //   membersWidget.add(PlayerBox(biddersTeam[i]));
          // } else {
          membersWidget.add(PlayerDragBox(biddersTeam[i]));
          // }
        }

        return Container(
          height: 80,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.purpleAccent[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: membersWidget,
          ),
        );
      },
      onWillAccept: (String data) {
        print("Hover: $data");
        return !biddersTeam.contains(data);
      },
      onAccept: (String data) {
        setState(
          () {
            biddersTeam.add(data);
            undecidedPlayers.removeWhere((player) => player == data);
            opposition.removeWhere((player) => player == data);
          },
        );
      },
    );
  }

  Widget _buildPlayers(BuildContext context) {
    // _fetchPlayers(context);
    if (undecidedPlayers.length > 0) {
      final List<Widget> playersAvatars = [];
      for (int i = 0; i < undecidedPlayers.length; i++) {
        playersAvatars.add(PlayerDragBox(undecidedPlayers[i]));
      }

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0),
          color: Color(0xFFA9CAE8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: playersAvatars,
        ),
      );
    } else {
      return Container(
        width: 50,
        padding: EdgeInsets.all(8),
        // decoration: BoxDecoration(
        //   border: Border.all(),
        //   borderRadius: BorderRadius.circular(5.0),
        // color: Colors.red,
        // ),
        child: Center(
          child: Text(
            "v",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  Widget _buildOpposition(BuildContext context) {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        List<PlayerDragBox> membersWidget = [];
        for (int i = 0; i < opposition.length; i++) {
          membersWidget.add(PlayerDragBox(opposition[i]));
        }
        return Container(
          height: 80,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.orangeAccent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: membersWidget,
          ),
        );
      },
      onWillAccept: (String data) {
        print("Hover: $data");
        return !opposition.contains(data) && data != widget.bidder;
      },
      onAccept: (String data) {
        setState(
          () {
            opposition.add(data);
            undecidedPlayers.removeWhere((player) => player == data);
            biddersTeam.removeWhere((player) => player == data);
          },
        );
      },
    );
  }

  Widget _buildOppositionScore(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextField(
        style: Theme.of(context).textTheme.display1,
        decoration: InputDecoration(
          fillColor: Colors.yellow,
          labelStyle: Theme.of(context).textTheme.display1,
          labelText: "Opposition Score",
          // errorText: "Invalid number entered",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        keyboardType: TextInputType.number,
        textDirection: TextDirection.rtl,
        onChanged: (score) {
          if (score == null || score.isEmpty) {
            print("No score entered");
          } else {
            int scoreInt;
            try {
              scoreInt = int.parse(score);
              if (scoreInt < 0 || scoreInt > 350) {
                // TODO: Raise exception here
                print("Invalid score");
              }
            } on Exception catch (e) {
              print("Invalid score");
              return;
            }
            setState(
              () {
                print("Updating score state: $scoreInt");
                oppScore = scoreInt;
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return RaisedButton(
      color: Colors.green,
      textColor: Colors.white,
      disabledColor: Colors.white,
      disabledTextColor: Colors.green,
      splashColor: Colors.limeAccent,
      child: Text(
        "Next",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed:
          (undecidedPlayers.length == 0 && oppScore >= 0 && oppScore <= 350)
              ? _pressNextButton
              : null,
    );
  }

  void _pressNextButton() {
    Navigator.pop(context);
    Navigator.pop(context);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameResultScreen(
              boardID: widget.boardID,
              gameID: widget.gameID,
              players: widget.players,
              scoreboard: widget.scoreboard,
              bidder: widget.bidder,
              bid: widget.bid,
              trump: widget.trump,
              biddersTeam: biddersTeam,
              opposition: opposition,
              oppScore: oppScore,
            ),
      ),
    );
  }
}

class PlayerDragBox extends StatefulWidget {
  final String player;

  PlayerDragBox(this.player) : assert(player != null);

  @override
  PlayerDragBoxState createState() => PlayerDragBoxState();
}

class PlayerDragBoxState extends State<PlayerDragBox> {
  @override
  Widget build(BuildContext context) {
    PlayerBox box = PlayerBox(widget.player);
    return Draggable(
      maxSimultaneousDrags: 1,
      axis: Axis.vertical,
      data: widget.player,
      child: box,
      feedback: box,
      childWhenDragging: Container(
        color: Theme.of(context).backgroundColor,
      ),
      onDragCompleted: () {
        print("Drag complete");
      },
    );
  }
}

class TeamDragTargetBox extends StatefulWidget {
  final List<String> members;
  final onAccept;

  TeamDragTargetBox({this.members, this.onAccept});

  @override
  TeamDragTargetState createState() => TeamDragTargetState();
}

class TeamDragTargetState extends State<TeamDragTargetBox> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, List<String> candidateData, rejectedData) {
        print("CD: $candidateData");
        print("RD: $rejectedData");

        List<PlayerDragBox> membersWidget = [];

        for (var i = 0; i < widget.members.length; i++) {
          membersWidget.add(PlayerDragBox(widget.members[i]));
        }

        return Container(
          width: 500,
          height: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: membersWidget,
          ),
        );
      },
      onWillAccept: (String data) {
        print("Hover: $data");
        return true;
      },
      onAccept: (String data) {
        setState(
          () {
            widget.members.add(data);
          },
        );
      },
    );
  }
}
