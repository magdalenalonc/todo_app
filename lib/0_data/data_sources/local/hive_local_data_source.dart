import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exceptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';

class HiveLocalDataSource implements ToDoLocalDataSourceInterface {
  late BoxCollection toDoCollections;

  bool isInitialize = false;

  Future<void> init() async {
    if (!isInitialize) {
      String path = '';
      if (!kIsWeb) {
        final directory = await getApplicationDocumentsDirectory();
        path = directory.path;
      }

      toDoCollections = await BoxCollection.open(
        'todo',
        {'collection', 'entry'},
        path: path,
      );
      isInitialize = true;
    } else {
      debugPrint('Hive was already initialized');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    return toDoCollections.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    return toDoCollections.openBox<Map>('entry');
  }

  @override
  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collection}) async {
    final collectionBox = await _openCollectionBox();
    final entryBox = await _openEntryBox();

    await collectionBox.put(collection.id, collection.toJson());
    await entryBox.put(collection.id, {});

    return true;
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entry}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();

    entryList
        .cast<String, dynamic>()
        .putIfAbsent(entry.id, () => entry.toJson());

    await entryBox.put(collectionId, entryList);

    return true;
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) async {
    final collectionBox = await _openCollectionBox();
    final collection =
        (await collectionBox.get(collectionId))?.cast<String, dynamic>();
    if (collection == null) {
      throw EntryNotFoundException();
    }

    return ToDoCollectionModel.fromJson(collection);
  }

  @override
  Future<List<String>> getToDoCollectionIds() async {
    final collectionBox = await _openCollectionBox();
    final collectionIds = collectionBox.getAllKeys();

    return collectionIds;
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();

    if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

    final entry = entryList[entryId].cast<String, dynamic>();
    return ToDoEntryModel.fromJson(entry);
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);
    if (entryList == null) throw CollectionNotFoundException();

    final entryIdList = entryList.cast<String, dynamic>().keys.toList();

    return entryIdList;
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) async {
    final entryBox = await _openEntryBox();
    final entryList = await entryBox.get(collectionId);

    if (entryList == null) throw CollectionNotFoundException();

    if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

    final entry =
        ToDoEntryModel.fromJson(entryList[entryId].cast<String, dynamic>());

    final updatedEntry = ToDoEntryModel(
      id: entry.id,
      description: entry.description,
      isDone: !entry.isDone,
    );

    entryList[entryId] = updatedEntry.toJson();

    await entryBox.put(collectionId, entryList);

    return updatedEntry;
  }
}
