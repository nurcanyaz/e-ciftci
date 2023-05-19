import 'package:e_ciftcim/screens/profile/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget createBody() => MaterialApp(home: Body());

void main() {
  group('Profile Menu Scroll Test', () {
    testWidgets('Scroll test', (tester) async {
      await tester.pumpWidget(createBody());

      // Ensure that the "Çıkış Yap" menu item is not found
      expect(find.text('Çıkış Yap'), findsNothing);

      // Scroll the widget
      await tester.fling(find.byType(ListView), Offset(0, -200), 3000);
      await tester.pumpAndSettle();

      // Ensure that the "Çıkış Yap" menu item is still not found
      expect(find.text('Çıkış Yap'), findsOneWidget);
    });
  });
}