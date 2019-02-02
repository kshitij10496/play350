import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

Widget buildDivider(BuildContext context) {
  return Divider(
    height: 10,
    color: Colors.black,
  );
}

Icon getTrumpIcon(String suit) {
  var icon;
  if (suit == "Clubs") {
    icon = Icon(CommunityMaterialIcons.cards_club, color: Colors.black);
  } else if (suit == "Diamonds") {
    icon = Icon(
      CommunityMaterialIcons.cards_diamond,
      color: Colors.red,
    );
  } else if (suit == "Hearts") {
    icon = Icon(
      CommunityMaterialIcons.cards_heart,
      color: Colors.red,
    );
  } else if (suit == "Spades") {
    icon = Icon(
      CommunityMaterialIcons.cards_spade,
      color: Colors.black,
    );
  } else {
    icon = Icons.error;
  }
  return icon;
}
