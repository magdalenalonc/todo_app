import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_error.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: ToDoOverviewError(),
      ),
    );
  }

  group('ToDoOverviewError', () {
    testWidgets('should render correctly', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());
      await widgetTester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('ERROR, please try again'), findsOneWidget);
    });
  });
}
