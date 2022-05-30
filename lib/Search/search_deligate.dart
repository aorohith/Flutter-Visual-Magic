import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:visual_magic/VideoPlayer/video_player.dart';
import 'package:visual_magic/db/functions.dart';

class SearchVideos extends SearchDelegate<VideoData> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: const TextTheme(displayMedium: TextStyle(color: Colors.white)),
      hintColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.blue,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
        ? fetchedVideosWithInfo.value
        : fetchedVideosWithInfo.value
            .where((vide) =>
                vide.title!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: myList.isEmpty
          ? const Text("No matching found")
          : ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: myList.length,
              itemBuilder: (context, index) {
                final VideoData video = myList[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => VideoPlay(videoLink: video.path),
                    ),
                  ),
                  leading: Image.asset("assets/images/download.jpeg"),
                  title: Text(
                    video.title!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
