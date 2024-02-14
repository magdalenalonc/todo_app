class ServerException implements Exception {}

class FirestoreCollectionNotFoundException implements ServerException {
  FirestoreCollectionNotFoundException({required this.id});
  
  final String id;
}

class CacheException implements Exception {}

class CollectionNotFoundException implements CacheException {}

class EntryNotFoundException implements CacheException {}
