import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_detail_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailState> {
  ToDoDetailCubit({
    this.collectionId,
    required this.loadToDoEntryIdsForCollection,
  }) : super(ToDoDetailLoadingState());

  final CollectionId? collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(ToDoDetailLoadingState());
    if (collectionId != null) {
      try {
        final entryIds = await loadToDoEntryIdsForCollection.call(
          CollectionIdParam(collectionId: collectionId!),
        );

        if (entryIds.isLeft) {
          emit(ToDoDetailErrorState());
        } else {
          emit(ToDoDetailLoadedState(entryIds: entryIds.right));
        }
      } on Exception {
        emit(ToDoDetailErrorState());
      }
    } else {
      emit(ToDoDetailErrorState());
    }
  }
}
