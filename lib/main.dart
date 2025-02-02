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
    setState((){
      _xPos = _random.nextDouble() * (MediaQuery.of(context).size.width - 50);
      _yPos = _random.nextDouble() * (MediaQuery.of(context).size.height - 150);
    });
  }

  void _inceraseScore(){
    setState(() {
      _score++;
    });
    _resetTimer();
    _moveDot();
  }

  void _gameOver() {
    _timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Game Over!'),
        content: Text('Your score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _score = 0;
              });
              Navigator.of(context).pop();
              _startGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Tap the dot'),),
      body: Stack(
        children: [
          Positioned(
            left: _xPos,
            top: _yPos,
            child: GestureDetector(
              onTap: _inceraseScore,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text('Score: $_score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),,),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}