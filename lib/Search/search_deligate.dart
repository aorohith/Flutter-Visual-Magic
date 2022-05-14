import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:visual_magic/db/functions.dart';

class searchVideos extends SearchDelegate<VideoData> {
  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return Theme.of(context).copyWith(
      
  //     textTheme: Theme.of(context).textTheme.copyWith(
  //       headline6: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(displayMedium: TextStyle(color: Colors.white)),
      hintColor: Colors.white,
      appBarTheme: AppBarTheme(
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
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
        ? fetchedVideosWithInfo.value
        : fetchedVideosWithInfo.value
            .where((video) =>
                video.title!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return Scaffold(
      backgroundColor: Colors.red,
      body: myList.isEmpty
          ? Text("No matching found")
          : ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, index) {
                final VideoData video = myList[index];
                return ListTile(
                  title: Text(video.title!),
                );
              },
            ),
    );
  }
}
