import 'package:flutter/foundation.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';

List<String> fetchedVideos = [];
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]);
List<String> tempDirectory = [];
ValueNotifier<List> fetchedVideosWithInfo = ValueNotifier([]);



final videoInfo = FlutterVideoInfo();

 onSuccess(List<String> data) {
  fetchedVideos = data;
  getVideoWithInfo();
}

//first called from splash screen
splashFetch() async {
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
Future loadFolderList()async{
  for(String path in fetchedVideos){
    var splittedPath = path.split('/');

    tempDirectory.add(splittedPath[splittedPath.length - 2]);
    tempDirectory = tempDirectory.toSet().toList();
  }
  fetchedFolders.value = tempDirectory;
}

//video info collection
Future getVideoWithInfo() async{
  
  for(String path in fetchedVideos){
    var info  = await videoInfo.getVideoInfo(path);
    fetchedVideosWithInfo.value.add(info);
  }
}

sortAlphabetical(){
  print(fetchedVideosWithInfo.value[200].location);
  fetchedVideosWithInfo.value.sort((a, b){ 
    return a.title.toLowerCase().compareTo(b.title.toLowerCase(),);
}
);
fetchedVideosWithInfo.notifyListeners();
}

sortByDate(){

}



