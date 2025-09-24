import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import '../../video_list_screen.dart';
import 'nearby_connections_screen.dart';

class HomeShell extends StatefulWidget {
  final int initialIndex;
  const HomeShell({super.key, this.initialIndex = 0});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const DashboardScreen(),
      const VideoListScreen(),
      const NearbyConnectionsScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.video_library_outlined), label: 'Recorded'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: 'P2P'),
        ],
      ),
    );
  }
}


