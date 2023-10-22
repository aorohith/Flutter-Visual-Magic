//Load Folder videos

import 'package:flutter/material.dart';
import 'package:visual_magic/infrastructure/functions/fetch_video_data.dart';

ValueNotifier<List<String>> filteredFolderVideos =
    ValueNotifier([]); //folder click videos
      ValueNotifier<List<String>> tempCount =
    ValueNotifier([]);//for count
    
getFolderVideos(String path) {
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

getFolderVideosCount(String path) {
  tempCount.value.clear();

  List<String> matchedVideoPath = [];

  List<String> splittedMatchedVideoPath = [];

  var splitted = path.split('/');

  for (String singlePath in fetchedVideosPath) {
    if (singlePath.startsWith(path)) {
      matchedVideoPath.add(singlePath);
    }
  }

  for (String newPath in matchedVideoPath) {
    splittedMatchedVideoPath = newPath.split('/');
    if (splittedMatchedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedMatchedVideoPath[splitted.length].endsWith('.mkv')) {
      tempCount.value.add(newPath);
    }
  }
  filteredFolderVideos.notifyListeners();
  // notify listeners if needed\
}