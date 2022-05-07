import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 3)
class PlayListName {

  @HiveField(0)
  String playListName;

  PlayListName({
    required this.playListName,
  });
}



@HiveType(typeId: 4)
class PlayListVideos {

  @HiveField(0)
  String playListName;

  @HiveField(1)
  String playListSong;


  PlayListVideos ({
    required this.playListName,
    required this.playListSong,
  });
}
