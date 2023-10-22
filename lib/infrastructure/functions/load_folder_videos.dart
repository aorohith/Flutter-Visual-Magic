//Load Folder videos

import 'package:flutter/material.dart';
import 'package:visual_magic/infrastructure/functions/fetch_video_data.dart';

class GetVideos extends ChangeNotifier {
  static ValueNotifier<List<String>> filteredFolderVideos =
      ValueNotifier([]); //folder click videos
  static ValueNotifier<List<String>> tempCount = ValueNotifier([]); //for count

  static getFolderVideos(String path) {
    filteredFolderVideos.value.clear();
    List<String> matchedVideoPath = [];

    List<String> spitedMatchedVideoPath = [];

    var spitted = path.split('/');

    for (String singlePath in fetchedVideosPath) {
      if (singlePath.startsWith(path)) {
        matchedVideoPath.add(singlePath);
      }
    }

    for (String newPath in matchedVideoPath) {
      spitedMatchedVideoPath = newPath.split('/');
      if (spitedMatchedVideoPath[spitted.length].endsWith('.mp4') ||
          spitedMatchedVideoPath[spitted.length].endsWith('.mkv')) {
        filteredFolderVideos.value.add(newPath);
      }
    }
    filteredFolderVideos.notifyListeners();
    // notify listeners if needed\
  }

  static getFolderVideosCount(String path) {
    tempCount.value.clear();

    List<String> matchedVideoPath = [];

    List<String> splitMatchedVideoPath = [];

    List<String> split = path.split('/');

    for (String singlePath in fetchedVideosPath) {
      if (singlePath.startsWith(path)) {
        matchedVideoPath.add(singlePath);
      }
    }

    for (String newPath in matchedVideoPath) {
      splitMatchedVideoPath = newPath.split('/');
      if (splitMatchedVideoPath[split.length].endsWith('.mp4') ||
          splitMatchedVideoPath[split.length].endsWith('.mkv')) {
        tempCount.value.add(newPath);
      }
    }
    filteredFolderVideos.notifyListeners();
    // notify listeners if needed\
  }
}
