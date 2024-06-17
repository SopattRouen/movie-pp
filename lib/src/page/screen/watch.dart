import 'package:flutter/material.dart';
import 'package:movietime/src/model/movie.dart'; // Adjust the path as per your project structure
import 'package:movietime/src/service/tmdb.dart'; // Adjust the path as per your project structure
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<VideoModel> futureVideoModel;

  @override
  void initState() {
    super.initState();
    futureVideoModel = VideoService().getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder<VideoModel>(
        future: futureVideoModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.results == null ||
              snapshot.data!.results!.isEmpty) {
            return Center(child: Text('No videos available'));
          } else {
            List<Results> videos = snapshot.data!.results!; // All videos
            return _buildVideoList(videos);
          }
        },
      ),
    );
  }

  Widget _buildVideoList(List<Results> videos) {
    return Padding(
      padding: EdgeInsetsDirectional.all(10),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          Results video = videos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: YoutubePlayer(
              key: Key(video.id.toString()), // Unique key for each player
              controller: YoutubePlayerController(
                initialVideoId: video.key ?? '',
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  enableCaption: true,
                  controlsVisibleAtStart: true,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          );
        },
      ),
    );
  }
}
