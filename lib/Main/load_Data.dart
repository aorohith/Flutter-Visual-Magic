import 'package:permission_handler/permission_handler.dart';
import 'package:visual_magic/FetchFiles/search_files.dart';
import 'package:visual_magic/Main/splash_screen.dart';

List<String> fetchedData=[];

onSuccess(List<String> data) {
    fetchedData = data;
    print("##########################################################################");
    print(fetchedData.runtimeType);
    print(fetchedData.join("\n"));
  }

splashFetch() async{
  if(await _requestPermission(Permission.storage)){
    SearchFilesInStorage.searchInStorage(['.mp4','.mkv',], onSuccess, (p0) {});
  }
  else{
    print("Error");
  }
   
}

Future <bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted){
    return true;
  }else {
    var result = await permission.request();
    if(result == PermissionStatus.granted){
      return true;
    }else{
      return false;
    }
  }
}

List<String> getVideoList(){
  return fetchedData;
}
