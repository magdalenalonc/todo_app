import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class MockToDoOverviewCubit extends MockCubit<ToDoOverviewCubitState>
    implements ToDoOverviewCubit {}

void main() {
  Widget widgetUnderTest({required ToDoOverviewCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<ToDoOverviewCubit>(
        create: (context) => cubit,
        child: const Scaffold(body: OverviewPage()),
      ),
    );
  }

  group('OverviewPage', () {
    late ToDoOverviewCubit mockToDoOverviewCubit;

    setUp(() {
      mockToDoOverviewCubit = MockToDoOverviewCubit();
    });

    group('should be displayed view state', () {
      testWidgets('Loading when cubit emits ToDoOverviewCubitLoadingState',
          (widgetTester) async {
        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([ToDoOverviewCubitLoadingState()]),
          initialState: ToDoOverviewCubitLoadingState(),
        );

        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));

        expect(find.byType(ToDoOverviewLoading), findsOneWidget);
      });

      testWidgets('Loaded when cubit emits ToDoOverviewCubitLoadedState',
          (widgetTester) async {
        final toDoCollection = ToDoCollection(
          id: CollectionId.fromUniqueString(1.toString()),
          title: 'test title',
          color: ToDoColor(colorIndex: 0),
        );

        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([
            ToDoOverviewCubitLoadedState(collections: [toDoCollection]),
          ]),
          initialState: ToDoOverviewCubitLoadingState(),
        );

        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ToDoOverviewLoading), findsNothing);
        expect(find.byType(ToDoOverviewLoaded), findsOneWidget);
        expect(find.text('test title'), findsOneWidget);
      });

      testWidgets('Error when cubit emits ToDoOverviewCubitErrorState',
          (widgetTester) async {
        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([ToDoOverviewCubitErrorState()]),
          initialState: ToDoOverviewCubitLoadingState(),
        );

        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));
        await widgetTester.pumpAndSettle();

        expect(find.byType(ToDoOverviewError), findsOneWidget);
      });
    });
  });
}
