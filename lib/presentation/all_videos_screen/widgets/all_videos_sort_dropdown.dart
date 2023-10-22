import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_magic/infrastructure/functions/sort_videos.dart';
import '../../../application/videos/videos_bloc.dart';

class SortDropdown extends StatefulWidget {
  const SortDropdown({Key? key}) : super(key: key);

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  String dropdownValue = 'Duration';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: BlocBuilder<SortBloc, SortState>(
        builder: (context, state) {
          return DropdownButton(
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Colors.black,
            value: state.sortType,
            icon: const Icon(Icons.sort),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              switch (newValue) {
                case "A to Z":
                  SortVideos.sortAlphabetical();
                  break;
                case "Duration":
                  SortVideos.sortByDuration();
                  break;
                case "Date":
                  SortVideos.sortByDate();
                  break;
                case "FileSize":
                  SortVideos.sortBySize();
              }
              context
                  .read<SortBloc>()
                  .add(ChangeSortTypeEvent(type: newValue!));
            },
            items:
                ['A to Z', 'Duration', 'Date', 'FileSize'].map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
