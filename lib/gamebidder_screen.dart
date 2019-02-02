import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'gameplay_screen.dart';

class GameBidderScreen extends StatefulWidget {
  final String boardID;
  final int gameID;
  final List<String> players;

  const GameBidderScreen({this.boardID, this.gameID, this.players});

  @override
  State<GameBidderScreen> createState() => _GameBidderScreenState();
}

class _GameBidderScreenState extends State<GameBidderScreen> {
  String bidder;
  int bid;
  String trump;
  List<DropdownMenuItem> _playersItems;

  final List<DropdownMenuItem> suits = [
    DropdownMenuItem(
      value: "Clubs",
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(CommunityMaterialIcons.cards_diamond),
            ),
            Text("Clubs"),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      value: "Diamonds",
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                CommunityMaterialIcons.cards_diamond,
                color: Colors.red,
              ),
            ),
            Text("Diamonds"),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      value: "Hearts",
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(
                CommunityMaterialIcons.cards_heart,
                color: Colors.red,
              ),
            ),
            Text("Hearts"),
          ],
        ),
      ),
    ),
    DropdownMenuItem(
      value: "Spades",
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Icon(CommunityMaterialIcons.cards_spade),
            ),
            Text("Spades"),
          ],
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  void _buildPlayersDropDownItems() {
    List<DropdownMenuItem> playersDropDown = [];

    for (String p in widget.players) {
      playersDropDown.add(
        DropdownMenuItem(
          value: p,
          child: Container(child: Text(p)),
        ),
      );
    }

    setState(() {
      _playersItems = playersDropDown;
    });
  }

  void _setDefaults() {
    setState(() {
      bidder = widget.players[0];
      trump = "Clubs";
    });
  }

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
      title: Text("Game $gameID: Choose Bidder"),
    );
  }

  Widget buildBody(BuildContext context) {
    // Dropdown Menu with players
    // TextField with Bid
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildBidderDropdown(context),
          Divider(height: 20),
          _buildBidInput(context),
          Divider(height: 20),
          _buildTrumpDropdown(context),
          Divider(height: 20),
          _buildPlayButton(context),
        ],
      ),
    );
  }

  Widget _buildBidderDropdown(BuildContext context) {
    _buildPlayersDropDownItems();
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              items: _playersItems,
              value: bidder,
              onChanged: (name) {
                print("Bidder: $name");
                setState(() {
                  bidder = name;
                });
              },
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBidInput(BuildContext context) {
    return Container(
      child: TextField(
        style: Theme.of(context).textTheme.display1,
        decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.display1,
          labelText: "Bid",
          // errorText: "Invalid number entered",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        keyboardType: TextInputType.number,
        textDirection: TextDirection.rtl,
        onChanged: (amount) {
          if (amount == null || amount.isEmpty) {
            print("No bid entered");
          } else {
            int amountInt;
            try {
              amountInt = int.parse(amount);
              if (amountInt < 0 || amountInt > 350) {
                // TODO: Raise exception here
                print("Invalid bid");
              }
            } on Exception catch (e) {
              print("Invalid bid");
              return;
            }
            setState(
              () {
                print("Updating bid state: $amountInt");
                bid = amountInt;
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTrumpDropdown(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              items: suits,
              value: trump,
              onChanged: (choice) {
                print("Trump: $choice");
                setState(() {
                  trump = choice;
                });
              },
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }
// Widget _buildTrumpInput(BuildContext context) {
//     return Container(
//       child: ListView(
//         padding: EdgeInsets.all(4),
//         children: <Widget>[
//           ListTile(
//             leading: Icon(CommunityMaterialIcons.cards_club),
//             title: Text("Clubs"),
//             onTap: () {
//               setState(() {
//                 trump = "Clubs";
//               });
//             },
//           ),
//           ListTile(
//             leading: Icon(CommunityMaterialIcons.cards_diamond),
//             title: Text("Diamonds"),
//             onTap: () {
//               setState(() {
//                 trump = "Diamonds";
//               });
//             },
//           ),
//           ListTile(
//             leading: Icon(CommunityMaterialIcons.cards_heart),
//             title: Text("Hearts"),
//             onTap: () {
//               setState(() {
//                 trump = "Hearts";
//               });
//             },
//           ),
//           ListTile(
//             leading: Icon(CommunityMaterialIcons.cards_spade),
//             title: Text("Spades"),
//             onTap: () {
//               setState(() {
//                 trump = "Spades";
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

// child: Column(
  //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   // crossAxisAlignment: CrossAxisAlignment.center,
  //   children: <Widget>[
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           child: Card(
  //             elevation: 10,
  //             color: trump == "Clubs"
  //                 ? Colors.red
  //                 : Theme.of(context).cardColor,
  //             child: Column(
  //               children: <Widget>[
  //                 ListTile(
  //                   title: Icon(CommunityMaterialIcons.cards_club),
  //                   onTap: () {
  //                     setState(() {
  //                       trump = "Clubs";
  //                     });
  //                   },
  //                 ),
  //                 Center(child: Text("Clubs")),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           child: Card(
  //             elevation: 10,
  //             color: trump == "Diamonds"
  //                 ? Colors.red
  //                 : Theme.of(context).cardColor,
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   title: Icon(CommunityMaterialIcons.cards_diamond),
  //                   onTap: () {
  //                     setState(() {
  //                       trump = "Diamonds";
  //                     });
  //                   },
  //                 ),
  //                 Center(child: Text("Diamonds")),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     Row(
  //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       // crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Container(
  //           child: Card(
  //             elevation: 10,
  //             color: trump == "Hearts"
  //                 ? Colors.red
  //                 : Theme.of(context).cardColor,
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   title: Icon(CommunityMaterialIcons.cards_heart),
  //                   onTap: () {
  //                     setState(() {
  //                       trump = "Hearts";
  //                     });
  //                   },
  //                 ),
  //                 Center(child: Text("Hearts")),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           child: Card(
  //             elevation: 10,
  //             color: trump == "Spades"
  //                 ? Colors.red
  //                 : Theme.of(context).cardColor,
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   title: Icon(CommunityMaterialIcons.cards_spade),
  //                   onTap: () {
  //                     setState(() {
  //                       trump = "Spades";
  //                     });
  //                   },
  //                 ),
  //                 Center(child: Text("Spades")),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   ],
  // ),

  Widget _buildPlayButton(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).buttonColor,
      child: Text("Play"),
      elevation: 5,
      onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                print("Moved to Game Play: $bidder, $bid, $trump");
                return GamePlayScreen(
                  boardID: widget.boardID,
                  gameID: widget.gameID,
                  players: widget.players,
                  bidder: bidder,
                  bid: bid,
                  trump: trump,
                );
              },
            ),
          ),
    );
  }

  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance
  //         .collection("boards")
  //         .document(widget.boardID)
  //         .collection("players")
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return LinearProgressIndicator();
  //       return _buildList(context, snapshot.data.documents);
  //     },
  //   );
  // }

  // Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  //   return ListView(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  //   );
  // }

  // Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //   final player = Player.fromSnapshot(data);
  //   final name = player.name;

  //   return Padding(
  //     key: ValueKey(player.name),
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey),
  //         borderRadius: BorderRadius.circular(5.0),
  //       ),
  //       child: ListTile(
  //         leading: Container(
  //           margin: const EdgeInsets.only(right: 16.0),
  //           child: new CircleAvatar(
  //             child: new Text(player.name[0] + player.name[1]),
  //           ),
  //         ),
  //         title: Text(player.name),
  //         trailing: Container(
  //           width: 50.0,
  //           child: TextField(
  //             style: Theme.of(context).textTheme.display1,
  //             decoration: InputDecoration(
  //               labelStyle: Theme.of(context).textTheme.display1,
  //               labelText: "Bid",
  //               errorText: "Invalid number entered",
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //             ),
  //             keyboardType: TextInputType.number,
  //             textDirection: TextDirection.rtl,
  //             onSubmitted: (amount) {
  //               print("Bid: $amount");
  //               int b = int.parse(amount);
  //               print("Cast bid: $b");
  //               if (b < 0 || b > 350) {
  //                 print("Invalid bid");
  //               } else {
  //                 setState(
  //                   () {
  //                     print("Updating bid state: $b");
  //                     widget.bid = b;
  //                   },
  //                 );
  //               }
  //             },
  //           ),
  //         ),
  //         onTap: () {
  //           int bid = widget.bid;
  //           print("Bidder: $name");
  //           print("bid: $bid");
  //           Navigator.of(context).push(MaterialPageRoute(
  //               builder: (context) => TrumpApp(
  //                     boardID: widget.boardID,
  //                     gameID: widget.gameID,
  //                     bidder: player,
  //                     bid: widget.bid,
  //                   )));
  //         },
  //       ),
  //     ),
  //   );
  // }
}
