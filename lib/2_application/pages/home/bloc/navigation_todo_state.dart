part of 'navigation_todo_cubit.dart';

class NavigationToDoState extends Equatable {
  const NavigationToDoState({
    this.selectedCollectionId,
    this.isSecondBodyIsDisplayed,
  });

  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyIsDisplayed;

  @override
  List<Object?> get props => [selectedCollectionId, isSecondBodyIsDisplayed];
}
