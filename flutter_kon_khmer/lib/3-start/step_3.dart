import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ColorTapApp()),
    ),
  );
}

enum CardType { red, blue }

class ColorTapApp extends StatefulWidget {
  const ColorTapApp({super.key});

  @override
  State<ColorTapApp> createState() => _ColorTapAppState();
}

class _ColorTapAppState extends State<ColorTapApp> {
  int _currentIndex = 0;
  int redTapCount = 0;
  int blueTapCount = 0;

  void _incrementRedTapCount() {
    setState(() {
      redTapCount++;
    });
  }

  void _incrementBlueTapCount() {
    setState(() {
      blueTapCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? TapCounterScreen(
              redTapCount: redTapCount,
              blueTapCount: blueTapCount,
              onRedTap: _incrementRedTapCount,
              onBlueTap: _incrementBlueTapCount,
            )
          : TapStatisticsScreen(
              redTapCount: redTapCount,
              blueTapCount: blueTapCount,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class TapCounterScreen extends StatefulWidget {
  final int redTapCount;
  final int blueTapCount;
  final VoidCallback onRedTap;
  final VoidCallback onBlueTap;

  const TapCounterScreen({
    super.key,
    required this.redTapCount,
    required this.blueTapCount,
    required this.onRedTap,
    required this.onBlueTap,
  });

  @override
  TapCounterScreenState createState() => TapCounterScreenState();
}

class TapCounterScreenState extends State<TapCounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [
          ColoredCard(
            type: CardType.red,
            tapCount: widget.redTapCount,
            onTap: widget.onRedTap,
          ),
          ColoredCard(
            type: CardType.blue,
            tapCount: widget.blueTapCount,
            onTap: widget.onBlueTap,
          ),
        ],
      ),
    );
  }
}

class ColoredCard extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColoredCard({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TapStatisticsScreen extends StatelessWidget {
  final int redTapCount;
  final int blueTapCount;

  const TapStatisticsScreen({
    super.key,
    required this.redTapCount,
    required this.blueTapCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Red Taps: $redTapCount', style: TextStyle(fontSize: 24)),
            Text('Blue Taps: $blueTapCount', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
