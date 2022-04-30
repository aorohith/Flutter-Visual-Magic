import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'video_model.g.dart';

@HiveType(typeId: 1)
class VideoModel {

  @HiveField(0)
  final title;

  @HiveField(1)
  final path;

  @HiveField(2)
  final height;

  @HiveField(3)
  final width;

  @HiveField(4)
  final filesize;

  @HiveField(5)
  final duration;

  @HiveField(6)
  final date;

  @HiveField(7)
  static final folderPaths=[];

  @HiveField(8)
  final isFavourite;

  VideoModel({
    required this.title,
    required this.path,
    required this.height,
    required this.width,
    required this.filesize,
    required this.duration,
    required this.date,
    
    required this.isFavourite,
  }
  );
}

@HiveType(typeId: 2)
class UserModel{

  @HiveField(0)
  final name;

  @HiveField(1)
  final email;

  @HiveField(2)
  final image;

  UserModel({required this.name, required this.email, required this.image});
}
