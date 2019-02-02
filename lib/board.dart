import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  final String id;
  final DateTime createdAt;
  final List<String> players;
  final DocumentReference reference;

  Board()
      : id = "",
        createdAt = DateTime.now(),
        players = [],
        reference = null;

  Board.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map["id"] != null),
        assert(map["created_at"] != null),
        assert(map["players"] != null),
        id = map["id"],
        createdAt = map["created_at"],
        players = map["players"];

  Board.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Board<$createdAt>";
}
