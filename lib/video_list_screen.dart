import 'package:flutter/material.dart';
import 'models/video_model.dart';
import 'video_player_screen.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  // Sample lecture videos - replace with your actual video URLs
  List<VideoModel> get _lectureVideos => [
    VideoModel(
      title: "Introduction to Data Structures",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      duration: "~45 min",
    ),
    VideoModel(
      title: "Algorithms and Complexity",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      duration: "~38 min",
    ),
    VideoModel(
      title: "Object-Oriented Programming",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      duration: "~42 min",
    ),
    VideoModel(
      title: "Database Management Systems",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
      duration: "~35 min",
    ),
    VideoModel(
      title: "Computer Networks Fundamentals",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
      duration: "~50 min",
    ),
    VideoModel(
      title: "Operating Systems Concepts",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      duration: "~33 min",
    ),
    VideoModel(
      title: "Software Engineering Principles",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
      duration: "~40 min",
    ),
    VideoModel(
      title: "Web Development Basics",
      url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      duration: "~28 min",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Lecture Videos',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _lectureVideos.length,
        itemBuilder: (context, index) {
          final video = _lectureVideos[index];
          return _buildVideoItem(context, video);
        },
      ),
    );
  }

  Widget _buildVideoItem(BuildContext context, VideoModel video) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToVideoPlayer(context, video),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Thumbnail placeholder
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Icon(
                  Icons.play_circle_filled,
                  color: Colors.blue[600],
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              // Video details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          video.duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Play indicator
              Icon(
                Icons.chevron_right,
                color: Colors.grey[400],
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToVideoPlayer(BuildContext context, VideoModel video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: video),
      ),
    );
  }
}
