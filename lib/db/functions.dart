import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';
import 'package:visual_magic/db/Models/models.dart';
import 'package:visual_magic/main.dart';

final videoInfo = FlutterVideoInfo(); //creating object of infoclass
List<String> fetchedVideosPath = []; //all videos path loaded first time
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]); //folder list
List<String> temp = []; //temp directory for folder funcion
ValueNotifier<List<VideoData>> fetchedVideosWithInfo =
    ValueNotifier([]); //videos with info
ValueNotifier<List> filteredFolderVideos =
    ValueNotifier([]); //folder click videos
ValueNotifier<List<String>> favVideos = ValueNotifier([]);

ValueNotifier<List<RecentModel>> recentVideos = ValueNotifier([]);
ValueNotifier<List<PlayListName>> playLists = ValueNotifier([]);
ValueNotifier<List<PlayListVideos>> playListVideos = ValueNotifier([]);

onSuccess(List<String> data) {
  fetchedVideosPath = data;
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    if (fetchedVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      fetchedVideosPath.remove(fetchedVideosPath[i]);
      i--;
    }
  }
  // getVideoWithInfo();
}

//first called from splash screen
Future splashFetch() async {
  if (await _requestPermission(Permission.storage)) {
    SearchFilesInStorage.searchInStorage([
      '.mp4',
      '.mkv',
    ], onSuccess, (p0) {});
  }else{
    splashFetch();
  }
}

//request for the permission
Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

//load all folders list
Future loadFolderList() async {
  fetchedFolders.value.clear();
  for (String path in fetchedVideosPath) {
    temp.add(path.substring(
        0, path.lastIndexOf('/'))); //removed video name and add to temp

  }
  fetchedFolders.value = temp.toSet().toList();
}

//Load Folder videos
getFolderVideos(String path) {
  filteredFolderVideos.value.clear();
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
      filteredFolderVideos.value.add(newPath);
    }
  }
  // notify listeners if needed\
}

//video info collection

String formatTime(double time) {
  Duration duration = Duration(milliseconds: time.round());
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

Future getVideoWithInfo() async {
  fetchedVideosWithInfo.value.clear();
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    var info = await videoInfo.getVideoInfo(fetchedVideosPath[i]);
    fetchedVideosWithInfo.value.add(info!);
  }
  fetchedVideosWithInfo.notifyListeners();
}

sortAlphabetical() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.title!.toLowerCase().compareTo(
          b.title!.toLowerCase(),
        );
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDuration() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.duration!.compareTo(b.duration!);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortBySize() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.filesize!.compareTo(b.filesize!);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDate() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.date!.compareTo(b.date!);
  });
  fetchedVideosWithInfo.notifyListeners();
}

//###################...recent section...####################

getRecentList() async {
  recentVideos.value.clear();
  if (recentDB.values.isNotEmpty) {
    List<RecentModel> dbRecent = recentDB.values.toList();
    recentVideos.value.addAll(dbRecent.reversed);
  }
}

addToRecent(RecentModel value) async {
  if (recentDB.values.isNotEmpty) {
    final keys = recentDB.keys.toList();
    final values = recentDB.values.toList();
    for (int i = 0; i < keys.length; i++) {
      if (values[i].recentPath == value.recentPath) {
        recentDB.delete(keys[i]);
        break;
      }
    }
  }
  recentDB.add(value);
  getRecentList();
}

length() {
  print(recentDB.length);
}

// ####################....PLAYLIST SECTION....######################

editPlayList() {
  //
}

//playlist  video add
addPlayListVideos(PlayListVideos playListVideo) {
  List<PlayListVideos> currentList = playListVideosDB.values.toList();
  var contains = currentList.where((element) =>
      element.playListName == playListVideo.playListName &&
      element.playListVideo == playListVideo.playListVideo);
  if (contains.isNotEmpty) {
    return false;
  } else {
    playListVideosDB.add(playListVideo);
    return true;
  }
  // playListVideos.value.add(playListVideo);
}

removePlayListVideos(PlayListVideos playListVideo) {
  playListVideos.value.remove(playListVideo);
  // for(String video in )
}

//#################...Watch later...#####################

deleteWatchlater(WatchlaterModel watchlater) {
  // final tempDB = watchlaterDB.values.toList();
  // for(int i=0; i<tempDB.length; i++){
  //   if(tempDB[i].laterPath == value.laterPath){

  //   }
  // }

  final Map<dynamic, WatchlaterModel> watchlaterMap = watchlaterDB.toMap();
  dynamic desiredKey;
  watchlaterMap.forEach((key, value) {
    if (value.laterPath == watchlater.laterPath) {
      desiredKey = key;
    }
  });
  watchlaterDB.delete(desiredKey);
}

