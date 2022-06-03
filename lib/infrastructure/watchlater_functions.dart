//#################...Watch later...#####################

import '../db/Models/models.dart';
import '../main.dart';

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



addWatchLater(WatchlaterModel value) {
  watchlaterDB.add(value);
}

checkWatchlater(String watchlaterVideoPath) {
  if (watchlaterDB.isNotEmpty) {
    List<WatchlaterModel> watchlaterPaths = watchlaterDB.values.toList();
    final isExists = watchlaterPaths
        .where((itemToCheck) => itemToCheck.laterPath == watchlaterVideoPath);
    if (isExists.isEmpty) {
      return true; //no matching element found
    } else {
      return false; //matching element found in db
    }
  }
  return true;
}