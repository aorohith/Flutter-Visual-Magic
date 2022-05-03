import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';


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
