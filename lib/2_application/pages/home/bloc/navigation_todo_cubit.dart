import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationToDoCubit extends Cubit<NavigationToDoState> {
  NavigationToDoCubit() : super(const NavigationToDoState());

  void selectedToDoCollectionChanged(CollectionId collectionId) {
    emit(NavigationToDoState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    if (state.isSecondBodyIsDisplayed != isSecondBodyDisplayed) {
      emit(
        NavigationToDoState(
          isSecondBodyIsDisplayed: isSecondBodyDisplayed,
          selectedCollectionId: state.selectedCollectionId,
        ),
      );
    }
  }
}
