import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_entry_model.g.dart';

@JsonSerializable()
class ToDoEntryModel extends Equatable {
  const ToDoEntryModel({
    required this.id,
    required this.description,
    required this.isDone,
  });

  final String id;
  final String description;
  final bool isDone;

  factory ToDoEntryModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoEntryModelToJson(this);

  @override
  List<Object?> get props => [id, description, isDone];
}
