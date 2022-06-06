part of 'videos_bloc.dart';

class VideosState {
  List<String> fetchedPath;
  List<String> folderVideos;
  VideosState({this.fetchedPath=const [], this.folderVideos=const []});
}

class VideosInitial extends VideosState {
  VideosInitial() : super(fetchedPath:[],folderVideos:[]);
}
