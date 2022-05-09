import 'package:hive_flutter/hive_flutter.dart';
part 'watch_later_model.g.dart';

@HiveType(typeId: 5)
class WatchlaterModel {

  @HiveField(0)
  final String laterPath;

  WatchlaterModel({required this.laterPath});
}
