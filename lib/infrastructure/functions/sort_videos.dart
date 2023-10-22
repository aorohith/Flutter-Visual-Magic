import 'package:flutter/widgets.dart';
import 'videos_with_info.dart';

class SortVideos extends ChangeNotifier {
  static sortAlphabetical() {
    GetVideoInfo.fetchedVideosWithInfo.value.sort((a, b) {
      return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
    });
    GetVideoInfo.fetchedVideosWithInfo.notifyListeners();
  }

  static sortByDuration() {
    GetVideoInfo.fetchedVideosWithInfo.value.sort((a, b) {
      return a.duration!.compareTo(b.duration!);
    });
    GetVideoInfo.fetchedVideosWithInfo.notifyListeners();
  }

  static sortBySize() {
    GetVideoInfo.fetchedVideosWithInfo.value.sort((a, b) {
      return a.filesize!.compareTo(b.filesize!);
    });
    GetVideoInfo.fetchedVideosWithInfo.notifyListeners();
  }

  static sortByDate() {
    GetVideoInfo.fetchedVideosWithInfo.value.sort((a, b) {
      return a.date!.compareTo(b.date!);
    });
    GetVideoInfo.fetchedVideosWithInfo.notifyListeners();
  }
}
