import 'package:flutter/material.dart';
import 'models.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _currentLyricIndex = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _showLyricShareCard(BuildContext context, LyricLine line, Song song) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.tealAccent.shade700, Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.tealAccent.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.format_quote, color: Colors.tealAccent, size: 40),
                const SizedBox(height: 16),
                Text(
                  '"${line.text}"',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(song.coverUrl, width: 40, height: 40, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(song.artist, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.share),
                  label: const Text('Share Lyric Card'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Song?>(
      valueListenable: currentPlayingSong,
      builder: (context, song, _) {
        if (song == null) {
          return const Scaffold(body: Center(child: Text('No song playing')));
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Now Playing', style: TextStyle(fontSize: 14)),
            centerTitle: true,
            actions: [
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_pulseController.value * 0.05),
                      child: child,
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(song.coverUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(song.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Text(song.artist, style: TextStyle(fontSize: 16, color: Colors.grey.shade400)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.tealAccent,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Progress Bar Mock
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    activeTrackColor: Colors.tealAccent,
                    inactiveTrackColor: Colors.grey.shade800,
                    thumbColor: Colors.tealAccent,
                  ),
                  child: Slider(value: 0.3, onChanged: (v) {}),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1:02', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                    Text('-2:13', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                  ],
                ),
                const SizedBox(height: 10),
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.shuffle), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.skip_previous, size: 36), onPressed: () {}),
                    ValueListenableBuilder<bool>(
                      valueListenable: isPlaying,
                      builder: (context, playing, _) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.tealAccent,
                          ),
                          child: IconButton(
                            icon: Icon(playing ? Icons.pause : Icons.play_arrow, size: 40, color: Colors.black),
                            onPressed: () => isPlaying.value = !playing,
                          ),
                        );
                      },
                    ),
                    IconButton(icon: const Icon(Icons.skip_next, size: 36), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.repeat), onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 30),
                // Synced Lyrics View (Mock)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView.builder(
                      itemCount: song.lyrics.length,
                      itemBuilder: (context, index) {
                        final line = song.lyrics[index];
                        final isActive = index == _currentLyricIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _currentLyricIndex = index);
                          },
                          onLongPress: () => _showLyricShareCard(context, line, song),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              line.text,
                              style: TextStyle(
                                fontSize: isActive ? 20 : 16,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                color: isActive ? Colors.tealAccent : Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
