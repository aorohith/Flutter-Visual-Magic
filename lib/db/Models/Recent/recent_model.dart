import 'package:hive_flutter/hive_flutter.dart';
part 'recent_model.g.dart';

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
