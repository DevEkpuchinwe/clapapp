import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const LuckyBox());
}

class LuckyBox extends StatelessWidget {
  const LuckyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('LUCKY BOX',style: TextStyle(color: Colors.white)),
                     centerTitle: true,backgroundColor: Colors.deepOrangeAccent,
                     leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),),
        body: const PrizeBoxScreen(),
      ),
    );
  }
}

class PrizeBoxScreen extends StatefulWidget {
  const PrizeBoxScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrizeBoxScreenState createState() => _PrizeBoxScreenState();
}

class _PrizeBoxScreenState extends State<PrizeBoxScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _prizeDropAnimation;
  late Animation<double> _prizeRiseAnimation;
  late Animation<double> _shakeAnimation;
  bool _isBoxOpened = true;
  bool _showPrize = false;
  bool _showRevealButton = false;
  bool _showStartButton = true;
  bool _showPlayAgainButton = false;
  bool _prizesDropping = false;
  bool _boxClosed = false;
  String _rewardMessage = '';
  final List<int> _prizes = [0, 50, 100, 200, 500];
  int _selectedPrize = 0; // Initialize _selectedPrize
  // ignore: unused_field
  int _currentPrize = 0;
  int _currentPrizeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _prizeDropAnimation = Tween<double>(begin: -200.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _prizeRiseAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );
  }

  void _handleStart() {
    setState(() {
      _showStartButton = false;
      _prizesDropping = true;
      _boxClosed = false;
      _currentPrizeIndex = 0;
    });

    _controller.forward().then((_) {
      _dropNextPrize();
    });
  }

  void _dropNextPrize() {
    if (_currentPrizeIndex >= _prizes.length) {
      setState(() {
        _prizesDropping = false;
        _isBoxOpened = false;
        _boxClosed = true;
      });

      _controller.reverse().then((_) {
        _startShakeAnimation();
      });
      return;
    }

    setState(() {
      _currentPrize = _prizes[_currentPrizeIndex];
    });

    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        _currentPrizeIndex++;
        _dropNextPrize();
      });
    });
  }

  void _startShakeAnimation() {
    _controller.duration = const Duration(seconds: 1);
    _controller.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 5), () {
      _controller.stop();
      setState(() {
        _showRevealButton = true;
        _boxClosed = false; // Ensure the closed box is hidden after shaking
      });
    });
  }

  void _handleReveal() {
    setState(() {
      _selectedPrize = _prizes[Random().nextInt(_prizes.length)];
      _showRevealButton = false;
      _showPlayAgainButton = true;
    });

    _controller.forward().then((_) {
      setState(() {
        _rewardMessage = 'Congratulations, you won ₦$_selectedPrize!';
        _showPrize = true;
        _isBoxOpened = true; // Show the open box again
      });
      print('You won ₦$_selectedPrize!');
    });
  }

  void _handlePlayAgain() {
    setState(() {
      _isBoxOpened = true;
      _showPrize = false;
      _showRevealButton = false;
      _showStartButton = true;
      _showPlayAgainButton = false;
      _prizesDropping = false;
      _boxClosed = false;
      _rewardMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_showPrize) ...[
            Text(_rewardMessage, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Open box image
                  Visibility(
                    visible: _isBoxOpened && !_boxClosed,
                    child: Opacity(
                      opacity: 1.0,
                      child: Image.asset('assets/images/openbox.png', width: 200, height: 200),
                    ),
                  ),
                  // Closed box image
                  Visibility(
                    visible: !_isBoxOpened && _boxClosed,
                    child: Opacity(
                      opacity: 1.0,
                      child: Transform.translate(
                        offset: Offset(_shakeAnimation.value * (Random().nextBool() ? 1 : -1), 0),
                        child: Image.asset('assets/images/closebox.png', width: 200, height: 200),
                      ),
                    ),
                  ),
                  // Prize drop animation
                  if (_prizesDropping) ...[
                    ..._prizes.mapIndexed((index, prize) {
                      return Visibility(
                        visible: index == _currentPrizeIndex,
                        child: Transform.translate(
                          offset: Offset(-1, _prizeDropAnimation.value),
                          child: Text('₦${prize.toString()}', style: const TextStyle(fontSize: 18)),
                        ),
                      );
                    // ignore: unnecessary_to_list_in_spreads
                    }).toList(),
                  ],
                  // Prize reveal animation
                  if (!_isBoxOpened && !_showStartButton && !_prizesDropping && _showPrize) ...[
                    Transform.translate(
                      offset: Offset(-1, _prizeRiseAnimation.value),
                      child: Container(
                        width: 200,
                        height: 50,
                        color: Colors.transparent,
                        child: Center(child: Text('₦$_selectedPrize', style: const TextStyle(fontSize: 24, color: Colors.black))),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          if (_showStartButton) ...[
            ElevatedButton(
              onPressed: _handleStart,
              child: const Text('Start Game',style: TextStyle(color: Colors.deepOrangeAccent),),
            ),
          ],
          const SizedBox(height: 20),
          if (_showRevealButton) ...[
            ElevatedButton(
              onPressed: _handleReveal,
              child: const Text('Reveal Prize',style: TextStyle(color: Colors.deepOrangeAccent),),
            ),
          ],
          const SizedBox(height: 20),
          if (_showPlayAgainButton) ...[
            ElevatedButton(
              onPressed: _handlePlayAgain,
              child: const Text('Play Again',style: TextStyle(color: Colors.deepOrangeAccent),),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Helper method for indexed iteration
extension ListIndex<T> on List<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) f) sync* {
    for (var i = 0; i < length; i++) {
      yield f(i, this[i]);
    }
  }
}
