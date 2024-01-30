import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failures.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/core/use_case.dart';

class MockToDoRepository extends Mock implements ToDoRepository {}

void main() {
  final mockToDoRepository = MockToDoRepository();

  group(
    'LoadToDoCollections test',
    () {
      final loadToDoCollectionUnderTest =
          LoadToDoCollections(toDoRepository: mockToDoRepository);

      group(
        'should return ToDoCollection List',
        () {
          test('when ToDoRepository returns ToDoCollection', () async {
            final dummyData = Right<Failure, List<ToDoCollection>>(
              List.generate(
                5,
                (index) => ToDoCollection(
                  id: CollectionId.fromUniqueString(index.toString()),
                  title: 'title $index',
                  color: ToDoColor(
                      colorIndex: index % ToDoColor.predefinedColors.length),
                ),
              ),
            );

            when(() => mockToDoRepository.readToDoCollections()).thenAnswer(
              (_) => Future.value(dummyData),
            );

            final result = await loadToDoCollectionUnderTest(NoParams());
            expect(result.isLeft, false);
            expect(result.isRight, true);
            expect(result, dummyData);
            verify(() => mockToDoRepository.readToDoCollections()).called(1);
            verifyNoMoreInteractions(mockToDoRepository);
          });
        },
      );

      group('should return Failure', () {
        test('when ToDoRepository returns Failure', () async {
          final dummyData =
              Left<Failure, List<ToDoCollection>>(ServerFailure());

          when(() => mockToDoRepository.readToDoCollections()).thenAnswer(
            (realInvocation) => Future.value(dummyData),
          );

          final result = await loadToDoCollectionUnderTest.call(NoParams());

          expect(result.isLeft, true);
          expect(result.isRight, false);
          expect(result, dummyData);
          verify(() => mockToDoRepository.readToDoCollections()).called(1);
          verifyNoMoreInteractions(mockToDoRepository);
        });
      });
    },
  );
}
