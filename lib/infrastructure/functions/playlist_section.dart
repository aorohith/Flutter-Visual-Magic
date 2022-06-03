// ####################....PLAYLIST SECTION....######################


import 'package:flutter/material.dart';
import '../../db/Models/models.dart';
import '../../main.dart';

ValueNotifier<List<PlayListVideos>> playListVideos = ValueNotifier([]);
bool notifyPlaylistVideo = false;


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

editPlayDB({
  required String oldValue,
  required String newValue,
}) {
  final Map<dynamic, PlayListName> playlistNameMap = playListNameDB.toMap();
  dynamic desiredKey;
  playlistNameMap.forEach((key, value) {
    if (value.playListName == oldValue) desiredKey = key;
  });
  final playlistObj = PlayListName(playListName: newValue);
  playListNameDB.put(desiredKey, playlistObj); //playlist name changed successfully



  final Map<dynamic, PlayListVideos> playlistVideoMap =
      playListVideosDB.toMap();
  playlistVideoMap.forEach((key, value) {
    if (value.playListName == oldValue) {
      PlayListVideos playVideos = PlayListVideos(playListName: newValue, playListVideo: value.playListVideo);
      playListVideosDB.put(key, playVideos);
    }
  });
}


//check playlist exists or not
checkPlaylistExists(value) {
  List<PlayListName> currentList = playListNameDB.values.toList();
  var contains = currentList.where((element) => element.playListName == value);
  //no duplicaate items in the list of objects
  return contains;
}

//Add new palylist to the list of playlists
addNewPlaylist(String value, BuildContext context) {
  final playlist = PlayListName(playListName: value);
  playListNameDB.add(playlist);
  Navigator.pop(context);
}