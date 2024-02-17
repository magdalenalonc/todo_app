import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_remote_data_source_interface.dart';
import 'package:todo_app/0_data/data_sources/mapper/todo_collection_mapper.dart';
import 'package:todo_app/0_data/data_sources/mapper/todo_entry_mapper.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRepositoryMixed
    with ToDoCollectionMapper, ToDoEntryMapper
    implements ToDoRepository {
  ToDoRepositoryMixed({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final ToDoLocalDataSourceInterface localDataSource;
  final ToDoRemoteDataSourceInterface remoteDataSource;

  bool get isUserLoggedIn => FirebaseAuth.instance.currentUser != null;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection toDoCollection) {
    // TODO: implement createToDoCollection
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry) {
    // TODO: implement createToDoEntry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    // TODO: implement readToDoCollections
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    // TODO: implement readToDoEntry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) {
    // TODO: implement readToDoEntryIds
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required ToDoEntry entry}) {
    // TODO: implement updateToDoEntry
    throw UnimplementedError();
  }
}
