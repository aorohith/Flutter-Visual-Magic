part of 'videos_bloc.dart';

@immutable
abstract class VideosEvent {}

class FetchFolders extends VideosEvent {
  List<String> fetched;
  FetchFolders({required this.fetched});
}
