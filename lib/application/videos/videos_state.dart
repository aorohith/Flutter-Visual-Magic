part of 'videos_bloc.dart';

class VideosState {
  List<String> fetchedPath;
  List<String> folderVideos;
  int index;
  bool isFav;
  VideosState({this.fetchedPath=const [], this.folderVideos=const [], this.isFav=true, this.index=0});
}

class VideosInitial extends VideosState {
  VideosInitial() : super(fetchedPath:[],folderVideos:[]);
}


//######################################
class BottomNavState {
  int index;

  BottomNavState({this.index=0});
}

class BottomNavInitial extends BottomNavState {
  BottomNavInitial() : super(index:0);
}

//######################################
class SortState {
  String sortType;

  SortState({required this.sortType});
}

class SortInitial extends SortState {
  SortInitial() : super(sortType:'Duration');
}

//######################################
class FavPopupState {
  bool favStatus;

  FavPopupState({required this.favStatus});
}

class FavPopupInitial extends FavPopupState {
  FavPopupInitial() : super(favStatus:false);
}

//######################################
class ThumbnailState {
  String thumbnailPath;

  ThumbnailState({required this.thumbnailPath});
}

class ThumbnailInitial extends ThumbnailState {
  ThumbnailInitial() : super(thumbnailPath:'assets/images/download.jpeg');
}
