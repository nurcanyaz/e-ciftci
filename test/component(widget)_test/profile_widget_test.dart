import 'package:e_ciftcim/screens/profile/components/profile_menu.dart';
import 'package:e_ciftcim/screens/profile/components/profile_pic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:e_ciftcim/screens/profile/components/body.dart';

void main() {
  testWidgets('Body widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Body()));

    // Verify that the ProfilePic widget is present
    expect(find.byType(ProfilePic), findsOneWidget);

    // Verify that the ProfileMenu widget is present
    expect(find.byType(ProfileMenu), findsWidgets);

    // You can also test whether a specific text is present in your widget tree
    // For example, if one of your menuItems has 'Settings' as text
    // expect(find.text('Settings'), findsOneWidget);
  });
}