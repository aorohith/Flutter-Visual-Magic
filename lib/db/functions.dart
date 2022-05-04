import 'package:flutter/foundation.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';
import 'package:visual_magic/db/Models/Favourites/favourites_model.dart';
import 'package:visual_magic/db/Models/Recent/recent_model.dart';
import 'package:visual_magic/main.dart';

final videoInfo = FlutterVideoInfo(); //creating object of infoclass
List<String> fetchedVideosPath = []; //all videos path loaded first time
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]); //folder list
List<String> temp = []; //temp directory for folder funcion
ValueNotifier<List> fetchedVideosWithInfo =
    ValueNotifier([]); //videos with info
ValueNotifier<List> filteredFolderVideos =
    ValueNotifier([]); //folder click videos
ValueNotifier<List<String>> favVideos = ValueNotifier([]);

ValueNotifier<List<RecentModel>> recentVideos = ValueNotifier([]);

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

  print(splitted);

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
  // notify listeners if needed
}

//video info collection

String formatTime(double time) {
    Duration duration = Duration(milliseconds: time.round());
    return [duration.inHours, duration.inMinutes, duration.inSeconds].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
}


Future getVideoWithInfo() async {
  fetchedVideosWithInfo.value.clear();
  for (int i = 0; i < fetchedVideosPath.length; i++) {
    var info = await videoInfo.getVideoInfo(fetchedVideosPath[i]);
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

//######################....Favourite section....########################

fetchFav() async {
  // if (box.get('favList') != null) {//first case there is no fav list then hive.get is an error
    favVideos.value.clear();
    // List temp = await box.get('favList');
    // for (int i = 0; i < temp.length; i++) {
    //   //delete video from fav if the user delete/change directory of the video in storage
    //   if (!fetchedVideosPath.contains(temp[i])) {
    //     print("found");
    //     temp.remove(temp[i]);
    //   }
    // }
    // favVideos.value.addAll(temp);
    // favVideos.notifyListeners();
    // await box.put('favList', temp);
    List<String> temp = await favDB.get('favList').favVideo;
    favVideos.value.addAll(temp);
    print(favDB.get('favList').favVideo);

  }
// }

addToFavList(String value) async{
  favVideos.value.add(value);
  favVideos.notifyListeners();
  var fav = Favourites(favVideo: favVideos.value);
  await favDB.put('favList', fav);
  print(favVideos.value);
}

removeFromFav(String value) {
  favVideos.value.remove(value);
  favVideos.notifyListeners();
  favDB.put('favList', favVideos.value);
  // print(favVideos.value);
}

//###################...recent section...####################

getRecentList() async{
  
  
  // values.addAll(await recentDB.values);
  // List keys = recentDB.keys;
  // recentDB.delete(6);
  // print(values.toList());
  // print(keys);
  // recentVideos.value.clear();
  // if(recentDB.values != null){
  //   recentVideos.value.addAll(recentDB.values);
  //   recentVideos.value.reversed;
  //   recentVideos.notifyListeners();
  //   print(recentVideos.value);
  // }
}

addToRecent(RecentModel value) async{
  final keys = await recentDB.keys.toList();
  final values = await recentDB.values.toList();
  for(int i=0; i<keys.length; i++){
    if(values[i].recentPath == value.recentPath){
      await recentDB.delete(keys[i]);
      break;
    }
  }  
  await recentDB.add(value);
  print(recentDB.length);
  // await recentDB.add(value);
  // recentVideos.value.clear();
  // recentVideos.value.addAll(await recentDB.values.toList());
  // recentVideos.value.reversed;
  // print(recentVideos.value);
  // if(recentDB.values != null){
  // final didRemove = recentVideos.value.removeWhere((element) => element.recentPath == value.recentPath);//remove the path received form current recent list
  // deleteItem(value.recentPath);
  // }
  // // recentVideos.value.
  // // var existingItem = items.firstWhere((itemToCheck) => itemToCheck.link == favoriteitem.link, orElse: () => null);
  // recentVideos.value.add(value);
  // getRecentList();
  // // print(recentVideos.value);
  // // recentDB.addAll();

}

deleteItem(String currentPath) {
    // final Map<dynamic, RecentModel> deliveriesMap = recentDB.toMap();
    // dynamic desiredKey;
    // deliveriesMap.forEach((key, value){
    //     if (value.recentPath == currentPath){//db path == adding path
    //       desiredKey = key;
    //     }
    // });
    // recentDB.delete(desiredKey);
  }
