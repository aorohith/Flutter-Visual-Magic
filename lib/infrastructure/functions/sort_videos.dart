
import 'videos_with_info.dart';

sortAlphabetical() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.title!.toLowerCase().compareTo(
          b.title!.toLowerCase(),
        );
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDuration() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.duration!.compareTo(b.duration!);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortBySize() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.filesize!.compareTo(b.filesize!);
  });
  fetchedVideosWithInfo.notifyListeners();
}

sortByDate() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.date!.compareTo(b.date!);
  });
  fetchedVideosWithInfo.notifyListeners();
}
