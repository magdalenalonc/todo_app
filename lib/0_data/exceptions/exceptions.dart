class ServerException implements Exception {}

class FirestoreCollectionNotFoundException implements ServerException {
  FirestoreCollectionNotFoundException({required this.id});

  final String id;
}

class FirestoreEntryNotFoundException implements ServerException {
  FirestoreEntryNotFoundException({
    required this.id,
    required this.collectionId,
  });

  final String id;
  final String collectionId;
}

class CacheException implements Exception {}

class CollectionNotFoundException implements CacheException {}

class EntryNotFoundException implements CacheException {}
