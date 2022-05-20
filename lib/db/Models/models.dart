import 'package:hive_flutter/hive_flutter.dart';
part 'models.g.dart';


@HiveType(typeId: 0)
class UserModel {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String imgPath;

  @HiveField(3)
  final String description;

  UserModel({
    required this.name,
    required this.email,
    required this.imgPath,
    required this.description
  });
}


@HiveType(typeId: 1)
class Favourites {

  @HiveField(0)
  final String favVideo;

  Favourites({required this.favVideo});

}

@HiveType(typeId: 2)
class RecentModel {

  @HiveField(0)
  final String recentPath;

  @HiveField(1)
  final DateTime recentDate;

  RecentModel({
    required this.recentPath,
    required this.recentDate,
  });
}


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
  String playListVideo;


  PlayListVideos ({
    required this.playListName,
    required this.playListVideo,
  });
}

@HiveType(typeId: 5)
class WatchlaterModel {

  @HiveField(0)
  final String laterPath;

  WatchlaterModel({required this.laterPath});
}
