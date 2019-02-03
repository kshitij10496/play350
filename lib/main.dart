import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() {
  // debugPaintSizeEnabled = true;
  return runApp(GameApp());
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _gameTheme = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Raleway',
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.grey[600],
          ),
      primaryColor: Colors.grey[500],
      textSelectionColor: Colors.green[500],
      // TODO: Add game icon theme
      // TODO: Add game font
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Play 350",
      theme: _gameTheme,
      home: WelcomeScreen(),
    );
  }
}
