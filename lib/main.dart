import 'package:flutter/material.dart';
import 'video_list_screen.dart'; // from your LectureStreaming module
import 'src/app.dart';          // from Abeja module

void main() {
  runApp(const CombinedApp());
}

class CombinedApp extends StatelessWidget {
  const CombinedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stud App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stud App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Lecture Streaming"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoListScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Abeja Module"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AbejaApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
