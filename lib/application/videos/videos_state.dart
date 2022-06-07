part of 'videos_bloc.dart';

class VideosState {
  List<String> fetchedPath;
  List<String> folderVideos;
  bool isFav;
  VideosState({this.fetchedPath=const [], this.folderVideos=const [], this.isFav=true});
}

class VideosInitial extends VideosState {
  VideosInitial() : super(fetchedPath:[],folderVideos:[]);
}
