import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(VideosInitial()) {
    on<FetchFolders>((event, emit) async {
      List<String> temp = [];

      for (String path in event.fetched) {
        temp.add(
          path.substring(
            0,
            path.lastIndexOf('/'),
          ),
        ); //removed video name and add to temp

      }
      temp = temp.toSet().toList();
      return emit(VideosState(folderVideos:temp));
    });
  }
}
