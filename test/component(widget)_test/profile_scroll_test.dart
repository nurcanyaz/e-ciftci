import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:e_ciftcim/screens/profile/components/body.dart';

void main() {
  testWidgets('Body widget scroll test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Body()));

    // Obtain the SingleChildScrollView widget
    var scrollView = find.byType(SingleChildScrollView);
    expect(scrollView, findsOneWidget);

    // Attempt to scroll down
    await tester.drag(scrollView, Offset(0, -500));
    await tester.pumpAndSettle();

    // At this point, you could check for certain conditions after the scroll
    // For example, you can test whether a certain widget is now visible or not
  });
}
