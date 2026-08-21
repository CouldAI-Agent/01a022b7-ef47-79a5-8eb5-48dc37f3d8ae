import 'package:flutter/material.dart';

class LyricLine {
  final Duration time;
  final String text;

  const LyricLine({required this.time, required this.text});
}

class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final String audioUrl;
  final Duration duration;
  final List<LyricLine> lyrics;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
    required this.lyrics,
  });
}

class Playlist {
  final String id;
  final String name;
  final String coverUrl;
  final List<String> songIds;

  const Playlist({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.songIds,
  });
}

class User {
  final String id;
  final String name;
  final String avatarUrl;
  final List<String> playlistIds;
  final List<String> likedSongIds;

  const User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.playlistIds,
    required this.likedSongIds,
  });
}

// MOCK DATA
final List<Song> mockSongs = [
  Song(
    id: 's1',
    title: 'Neon Nights',
    artist: 'The Midnight Synth',
    album: 'City Lights',
    coverUrl: 'https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?auto=format&fit=crop&w=300&q=80',
    audioUrl: 'mock_audio_1',
    duration: const Duration(minutes: 3, seconds: 15),
    lyrics: [
      const LyricLine(time: Duration(seconds: 0), text: 'Cruising down the empty street'),
      const LyricLine(time: Duration(seconds: 5), text: 'Neon lights are all I see'),
      const LyricLine(time: Duration(seconds: 10), text: 'Lost inside this digital dream'),
      const LyricLine(time: Duration(seconds: 15), text: 'Where the music sets me free'),
    ],
  ),
  Song(
    id: 's2',
    title: 'Ocean Breeze',
    artist: 'Coastal Waves',
    album: 'Summer Vibes',
    coverUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=300&q=80',
    audioUrl: 'mock_audio_2',
    duration: const Duration(minutes: 2, seconds: 45),
    lyrics: [
      const LyricLine(time: Duration(seconds: 0), text: 'Feel the wind in my hair'),
      const LyricLine(time: Duration(seconds: 6), text: 'Salt water in the air'),
      const LyricLine(time: Duration(seconds: 12), text: 'Nothing else can compare'),
    ],
  ),
  Song(
    id: 's3',
    title: 'Electric Heart',
    artist: 'Cyber Pulse',
    album: 'Future Now',
    coverUrl: 'https://images.unsplash.com/photo-1557672172-298e090bd0f1?auto=format&fit=crop&w=300&q=80',
    audioUrl: 'mock_audio_3',
    duration: const Duration(minutes: 4, seconds: 10),
    lyrics: [
      const LyricLine(time: Duration(seconds: 0), text: 'Wired up to the mainframe'),
      const LyricLine(time: Duration(seconds: 5), text: 'My electric heart beats the same'),
      const LyricLine(time: Duration(seconds: 10), text: 'Running through the data stream'),
    ],
  ),
];

final List<Playlist> mockPlaylists = [
  Playlist(
    id: 'p1',
    name: 'Chill Vibes',
    coverUrl: 'https://images.unsplash.com/photo-1516280440502-869280145229?auto=format&fit=crop&w=300&q=80',
    songIds: ['s2', 's1'],
  ),
  Playlist(
    id: 'p2',
    name: 'Late Night Drive',
    coverUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?auto=format&fit=crop&w=300&q=80',
    songIds: ['s1', 's3'],
  ),
];

final User mockUser = User(
  id: 'u1',
  name: 'Alex Beat',
  avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
  playlistIds: ['p1', 'p2'],
  likedSongIds: ['s1', 's2', 's3'],
);

// Global State Mock (for simple state management in this demo)
final ValueNotifier<Song?> currentPlayingSong = ValueNotifier<Song?>(null);
final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
