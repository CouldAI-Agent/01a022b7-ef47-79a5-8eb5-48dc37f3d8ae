import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'player_screen.dart';
import 'models.dart';

void main() {
  runApp(const BeatlyApp());
}

class BeatlyApp extends StatelessWidget {
  const BeatlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beatly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.tealAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.tealAccent,
          surface: Color(0xFF1E1E1E),
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainLayout(),
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Scaffold(body: Center(child: Text('Search (Coming Soon)'))),
    const Scaffold(body: Center(child: Text('Library (Coming Soon)'))),
    const Scaffold(body: Center(child: Text('Profile (Coming Soon)'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          // Sticky Player Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ValueListenableBuilder<Song?>(
              valueListenable: currentPlayingSong,
              builder: (context, song, child) {
                if (song == null) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    height: 64,
                    margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(song.coverUrl, width: 48, height: 48, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                              Text(song.artist, style: TextStyle(color: Colors.grey.shade400, fontSize: 12), maxLines: 1),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.tealAccent,
                          onPressed: () {},
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isPlaying,
                          builder: (context, playing, _) {
                            return IconButton(
                              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                              onPressed: () => isPlaying.value = !playing,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
