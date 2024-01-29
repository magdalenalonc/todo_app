import 'package:todo_app/1_domain/entities/unique_id.dart';

class ToDoEntry {
  const ToDoEntry({
    required this.id,
    required this.description,
    required this.isDone,
  });

  final EntryId id;
  final String description;
  final bool isDone;

  factory ToDoEntry.empty() {
    return ToDoEntry(
      id: EntryId(),
      description: '',
      isDone: false,
    );
  }
}
