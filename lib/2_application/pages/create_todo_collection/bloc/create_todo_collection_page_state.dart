part of 'create_todo_collection_page_cubit.dart';

class CreateToDoCollectionPageState extends Equatable {
  const CreateToDoCollectionPageState({this.title, this.color});

  final String? title;
  final String? color;

  CreateToDoCollectionPageState copyWith({String? color, String? title}) {
    return CreateToDoCollectionPageState(
      color: color ?? this.color,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [title, color];
}
