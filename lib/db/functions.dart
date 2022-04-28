import 'package:flutter/foundation.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';
import 'package:visual_magic/db/Models/video_model.dart';

final videoInfo = FlutterVideoInfo(); //creating object of infoclass
List<String> fetchedVideosPath = []; //all videos path loaded first time
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]); //folder list
List<String> temp = []; //temp directory for folder funcion
ValueNotifier<List> fetchedVideosWithInfo =
    ValueNotifier([]); //videos with info
ValueNotifier<List> filteredFolderVideos =
    ValueNotifier([]); //folder click videos

onSuccess(List<String> data) {
  fetchedVideosPath = data;
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    if (fetchedVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      fetchedVideosPath.remove(fetchedVideosPath[i]);
      i--;
    }
  }
  getVideoWithInfo();
}

//first called from splash screen
Future splashFetch() async {
  if (await _requestPermission(Permission.storage)) {
    final videoDB = await Hive.openBox<VideoModel>('video_db');
    if(videoDB.isEmpty){
      SearchFilesInStorage.searchInStorage([
      '.mp4',
      '.mkv',
    ], onSuccess, (p0) {});
    }else{
      fetchedVideosWithInfo.value.addAll(videoDB.values);
      for(VideoModel obj in fetchedVideosWithInfo.value){
        temp.add(obj.path.substring(
        0, obj.path.lastIndexOf('/')));
      }
      fetchedFolders.value = temp.toSet().toList();
      print(fetchedVideosWithInfo.value.length);
    }
  } else {
    print("Error");
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

//load all folders list also called when the app starting time only
Future loadFolderList(paths) async {
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

  for (VideoModel singlePath in fetchedVideosWithInfo.value) {
    if (singlePath.path.startsWith(path)) {
      matchedVideoPath.add(singlePath.path);
    }
  }
  print(fetchedVideosPath.length);

  for (String newPath in matchedVideoPath) {
    splittedMatchedVideoPath = newPath.split('/');
    if (splittedMatchedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedMatchedVideoPath[splitted.length].endsWith('.mkv')) {
      filteredFolderVideos.value.add(newPath);
    }
  }
  // notify listeners if needed
}

//video info collection
Future getVideoWithInfo() async {
  final videoDB = await Hive.openBox<VideoModel>('video_db');
  fetchedVideosWithInfo.value.clear();
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    var info = await videoInfo.getVideoInfo(fetchedVideosPath[i]);
    final videoModel = VideoModel(
      title: info!.title,
      path: info.path,
      height: info.height,
      width: info.width,
      filesize: info.filesize,
      duration: info.duration,
      date: info.date,
      isFavourite: false,
    );
    videoDB.add(videoModel);
    
    fetchedVideosWithInfo.value.add(info);
  }
  fetchedVideosWithInfo.notifyListeners();
}

sortAlphabetical() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.title.toLowerCase().compareTo(
          b.title.toLowerCase(),
        );
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDuration() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.duration.compareTo(b.duration);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortBySize() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.filesize.compareTo(b.filesize);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDate() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.date.compareTo(b.date);
  });
  fetchedVideosWithInfo.notifyListeners();
}
