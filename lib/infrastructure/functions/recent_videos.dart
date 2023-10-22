//###################...recent section...####################
import 'package:flutter/material.dart';

import '../../db/Models/models.dart';
import '../../main.dart';

class RecentVideos extends ChangeNotifier {
  static ValueNotifier<List<RecentModel>> recentVideos = ValueNotifier([]);

  static clearVideos() {
    recentVideos.value.clear();
    recentVideos.notifyListeners();
  }

  static getRecentList() async {
    recentVideos.value.clear();
    if (recentDB.values.isNotEmpty) {
      List<RecentModel> dbRecent = recentDB.values.toList();
      recentVideos.value.addAll(dbRecent.reversed);
    }
  }

  static addToRecent(RecentModel value) async {
    if (recentDB.values.isNotEmpty) {
      final keys = recentDB.keys.toList();
      final values = recentDB.values.toList();
      for (int i = 0; i < keys.length; i++) {
        if (values[i].recentPath == value.recentPath) {
          recentDB.delete(keys[i]);
          break;
        }
      }
    }
    recentDB.add(value);
    getRecentList();
  }
}
