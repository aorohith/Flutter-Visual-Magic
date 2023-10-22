import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:visual_magic/infrastructure/functions/fetch_video_data.dart';

class GetVideoInfo extends ChangeNotifier {
  static FlutterVideoInfo videoInfo =
      FlutterVideoInfo(); //creating object of info class
  static ValueNotifier<List<VideoData>> fetchedVideosWithInfo =
      ValueNotifier([]); //videos with info

  static Future getVideoWithInfo() async {
    fetchedVideosWithInfo.value.clear();
    for (int i = 0; i < fetchedVideosPath.length; i++) {
      var info = await videoInfo.getVideoInfo(fetchedVideosPath[i]);
      fetchedVideosWithInfo.value.add(info!);
    }
    fetchedVideosWithInfo.notifyListeners();
  }
}
