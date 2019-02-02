import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final String name;
  final DocumentReference reference;

  Player.fromName(this.name)
      : assert(name != null),
        id = "dummy",
        reference = null;

  Player(this.id, this.name, this.reference)
      : assert(id != null),
        assert(name != null);

  Player.fromMap(Map<String, dynamic> map, {this.id, this.reference})
      : assert(map["name"] != null),
        name = map["name"];

  Player.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data,
          id: snapshot.documentID,
          reference: snapshot.reference,
        );
}

class PlayerBox extends StatelessWidget {
  final String name;
  final double width = 50;
  final double height = 50;
  final double radius = 20;

  PlayerBox(this.name) : assert(name != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CircleAvatar(
        radius: radius,
        child: Text(name[0] + name[1]),
      ),
    );
  }
}
