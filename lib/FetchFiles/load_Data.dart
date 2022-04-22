import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';

ValueNotifier<List<String>> fetchedVideos = ValueNotifier([]);
ValueNotifier<List<String>> fetchedFolders = ValueNotifier([]);
List<String> tempDirectory = [];

 onSuccess(List<String> data) {
  fetchedVideos.value = data;
}

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

Future loadFolderList()async{
  for(String path in fetchedVideos.value){
    var splittedPath = path.split('/');
    tempDirectory.add(splittedPath[splittedPath.length - 2]);
    tempDirectory = tempDirectory.toSet().toList();
    print(fetchedVideos.value.length);
  }
  fetchedFolders.value = tempDirectory;
   print('''########gdfgdfgdfg#############################e3''');
}
// List<String> getFolderList(){
//   print("#####################################3");
//   print(fetchedFolders.value.length);
//   return fetchedFolders.value;
// }


