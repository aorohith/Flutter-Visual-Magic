import 'package:flutter/foundation.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';

final videoInfo = FlutterVideoInfo();
List<String> fetchedVideosPath = [];
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]);
List<String> tempDirectory = [];
ValueNotifier<List> fetchedVideosWithInfo = ValueNotifier([]);


onSuccess(List<String> data) {
  fetchedVideosPath = data;
  print(fetchedVideosPath.join("\n"));
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
  for (String path in fetchedVideosPath) {
    var splittedPath = path.split('/');

    tempDirectory.add(splittedPath[splittedPath.length - 2]);
    tempDirectory = tempDirectory.toSet().toList();
  }
  fetchedFolders.value = tempDirectory;
}

//video info collection
Future getVideoWithInfo() async {
  print(fetchedVideosPath[10]);
  fetchedVideosWithInfo.value.clear();
  for (String path in fetchedVideosPath) {
      var info = await videoInfo.getVideoInfo(path);
      print(
          "###################################################################");
      print(info!.date);
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
