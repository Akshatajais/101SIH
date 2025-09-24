import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'recorded_screen.dart';
import 'p2p_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const DashboardScreen(),
      RecordedScreen(),
      const P2PScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Recorded'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'P2P'),
        ],
      ),
    );
  }
}


