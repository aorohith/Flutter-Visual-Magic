part of 'videos_bloc.dart';

class VideosEvent {}

class FetchFolders extends VideosEvent {
  List<String> fetched;
  FetchFolders({required this.fetched});
}

class FavEvent extends VideosEvent {
  bool fetched;
  FavEvent({required this.fetched});
}

//###################################
class BottomNavEvent {}

class ChangePageEvent extends BottomNavEvent {
  int pageNo;
  ChangePageEvent({required this.pageNo});
}

//###################################
class SortEvent {}

class ChangeSortTypeEvent extends SortEvent {
  String type;
  ChangeSortTypeEvent({required this.type});
}


