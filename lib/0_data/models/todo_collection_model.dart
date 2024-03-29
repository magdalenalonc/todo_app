import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_collection_model.g.dart';

@JsonSerializable()
class ToDoCollectionModel extends Equatable {
  const ToDoCollectionModel({
    required this.id,
    required this.title,
    required this.colorIndex,
  });

  final String id;
  final String title;
  final int colorIndex;

  factory ToDoCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$ToDoCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToDoCollectionModelToJson(this);

  @override
  List<Object?> get props => [id, title, colorIndex];
}
