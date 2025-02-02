import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(TapTheDotGame());

class TapTheDotGame extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap the Dot',
      theme: ThemeData.dark(),
      home: GameScreen(), 
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();
  double _xPos = 100;
  double _yPos = 100;
  int _score = 0;
  int _timeLeft = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame(){
    _resetTimer();
    _moveDot();
  }

  void _resetTimer(){
    _timer?.cancel();
    _timeLeft = max(2, 5 - (_score ~/ 5 )); // decrease time as score increases
    _timer = Timer.periodic(Duration(seconds: _timeLeft), (timer) {
      _gameOver();
    });
  }

  void _moveDot(){
    setState(){
      
    }
  }
}