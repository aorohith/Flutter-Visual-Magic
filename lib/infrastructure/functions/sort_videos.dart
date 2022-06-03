
import 'videos_with_info.dart';

sortAlphabetical() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.title!.toLowerCase().compareTo(
          b.title!.toLowerCase(),
        );
  });
}

sortByDuration() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.duration!.compareTo(b.duration!);
  });
}

sortBySize() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.filesize!.compareTo(b.filesize!);
  });
}

sortByDate() {
  fetchedVideosWithInfo.value.sort((a, b) {
    return a.date!.compareTo(b.date!);
  });
}
