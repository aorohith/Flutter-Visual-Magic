import 'package:hive_flutter/hive_flutter.dart';
part 'favourites_model.g.dart';

@HiveType(typeId: 1)
class Favourites {

  @HiveField(0)
  final List<String> favVideo;

  Favourites({required this.favVideo});

}