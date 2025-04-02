import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w5_observer_pattern_state_management/EXERCISE-2/counter_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CounterProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  ));
}

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("Home rebuilt");
    return Scaffold(
      body: _currentIndex == 0
          ? ColorTapsScreen()
          : StatisticsScreen(),
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

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counter, child) {
        return  Scaffold(
          appBar: AppBar(title: Text('Color Taps')),
          body: Column(
            children: [
              ColorTap(
                type: CardType.red,
                tapCount: counter.redTapCount,
                onTap: counter.incrementRedTapCount,
              ),
              ColorTap(
                type: CardType.blue,
                tapCount: counter.blueTapCount,
                onTap: counter.incrementBlueTapCount,
              ),
            ],
          ),
        );
      },
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    print("ColorTap rebuilt");
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

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print("StatisticsScreen rebuilt");
    return Consumer<CounterProvider>(builder: (context, counter, child) {
      return  Scaffold(
        appBar: AppBar(title: Text('Statistics')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Red Taps: ${counter.redTapCount}', style: TextStyle(fontSize: 24)),
              Text('Blue Taps: ${counter.blueTapCount}', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      );
    },
    );
  }
}