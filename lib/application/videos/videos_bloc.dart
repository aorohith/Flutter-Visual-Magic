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

    on<FavEvent>((event, emit){
      return emit(VideosState(isFav: event.fetched));
    });
  }
}

//#######################################

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavInitial()) {
   
    on<ChangePageEvent>((event, emit){
      return emit(BottomNavState(index: event.pageNo));
    });
  }
}

//#######################################

class SortBloc extends Bloc<SortEvent, SortState> {
  SortBloc() : super(SortInitial()) {
   
    on<ChangeSortTypeEvent>((event, emit){
      return emit(SortState(sortType: event.type));
    });
  }
}

//#######################################

class FavPopupBloc extends Bloc<FavPopupEvent, FavPopupState> {
  FavPopupBloc() : super(FavPopupInitial()) {
   
    on<ChangeFavPopupEvent>((event, emit){
      return emit(FavPopupState(favSatatus: event.status));
    });
  }
}

//#######################################

class ThumbnailBloc extends Bloc<ThumbnailEvent, ThumbnailState> {
  ThumbnailBloc() : super(ThumbnailInitial()) {
   
    on<ChangeThumbnailEvent>((event, emit){
      return emit(ThumbnailState(thumbnailPath: event.thumbnail));
    });
  }
}
