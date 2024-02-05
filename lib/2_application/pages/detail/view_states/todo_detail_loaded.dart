import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.entryIds,
    required this.collectionId,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => ToDoEntryItemProvider(
                collectionId: collectionId,
                entryId: entryIds[index],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                key: const Key('add-todo-entry'),
                onPressed: () {
                  context.pushNamed(
                    CreateToDoEntryPage.pageConfig.name,
                    extra: collectionId,
                  );
                },
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
