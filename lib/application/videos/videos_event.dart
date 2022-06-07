part of 'videos_bloc.dart';

@immutable
abstract class VideosEvent {}

class FetchFolders extends VideosEvent {
  List<String> fetched;
  FetchFolders({required this.fetched});
}

class BottomNavEvent extends VideosEvent {
  int pageNo;
  BottomNavEvent({required this.pageNo});
}

class FavEvent extends VideosEvent {
  bool fetched;
  FavEvent({required this.fetched});
}
