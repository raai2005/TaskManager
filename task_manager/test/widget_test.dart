import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager/main.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskManagerApp());

    // Verify the login screen is shown
    expect(find.text('PLANIT'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
