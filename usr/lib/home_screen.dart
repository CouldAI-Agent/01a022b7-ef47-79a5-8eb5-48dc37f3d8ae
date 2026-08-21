import 'package:flutter/material.dart';
import '../models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Good Evening', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  CircleAvatar(
                    backgroundImage: NetworkImage(mockUser.avatarUrl),
                    radius: 18,
                  )
                ],
              ),
              const SizedBox(height: 24),
              const Text('Mood Playlists', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildMoodCard('Chill', Colors.blue.shade800),
                    _buildMoodCard('Workout', Colors.orange.shade800),
                    _buildMoodCard('Sad', Colors.indigo.shade800),
                    _buildMoodCard('Party', Colors.purple.shade800),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text('Trending Now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...mockSongs.map((song) => _buildSongRow(song)).toList(),
              const SizedBox(height: 32),
              const Text('Made For You', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: mockPlaylists.map((p) => _buildPlaylistCard(p)).toList(),
                ),
              ),
              const SizedBox(height: 100), // Space for mini player
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodCard(String title, Color color) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildPlaylistCard(Playlist playlist) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(playlist.coverUrl, height: 140, width: 140, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(playlist.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildSongRow(Song song) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(song.coverUrl, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(song.artist, style: TextStyle(color: Colors.grey.shade400)),
      trailing: const Icon(Icons.more_vert, color: Colors.grey),
      onTap: () {
        currentPlayingSong.value = song;
        isPlaying.value = true;
      },
    );
  }
}
