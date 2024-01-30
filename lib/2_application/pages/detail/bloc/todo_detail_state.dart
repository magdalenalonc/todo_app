part of 'todo_detail_cubit.dart';

abstract class ToDoDetailState extends Equatable {
  const ToDoDetailState();

  @override
  List<Object> get props => [];
}

final class ToDoDetailLoadingState extends ToDoDetailState {}

final class ToDoDetailErrorState extends ToDoDetailState {}

final class ToDoDetailLoadedState extends ToDoDetailState {
  const ToDoDetailLoadedState({required this.entryIds});

  final List<EntryId> entryIds;

  @override
  List<Object> get props => [entryIds];
}
