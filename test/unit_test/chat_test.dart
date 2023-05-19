import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:e_ciftcim/models/Profile.dart';
import 'package:e_ciftcim/screens/chat/components/contact_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_ciftcim/models/Profile.dart';

import 'package:e_ciftcim/screens/chat/components/chat_form.dart';

import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:e_ciftcim/models/Profile.dart';
import 'package:e_ciftcim/screens/chat/components/contact_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileController extends Mock implements UserProfileController {}

void main() {
  setUpAll(() {
    registerFallbackValue(Profile(uid: '', seller: false));
  });

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('MessagePanelDisplay renders correctly', (WidgetTester tester) async {
    // Mock data
    final List<Profile> mockProfiles = [
      Profile(uid: '34234hdhfsjfhsjdf', seller: false,fName: 'Messi',lName: 'Terra', username: 'Heratera',sex: 'Kadın',icon: 'femaile.svg',),
      Profile(uid: '34234hdhfsjfhs23423jdf', seller: false,fName: 'Issem',lName: 'Arret', username: 'terahera',sex: 'Kadın',icon: 'femaile.svg',),
    ];

    // Mock the ProfileController
    final MockProfileController mockProfileController = MockProfileController();
    when(() => mockProfileController.getProfileStream())
        .thenAnswer((_) => Stream.value(mockProfiles));

    // Assign mockProfileController to the actual controller's singleton instance (assuming this exists in your class).
    UserProfileController profileController = mockProfileController;

    // Build MessagePanelDisplay widget
    await tester.pumpWidget(makeTestableWidget(child: MessagePanelDisplay()));

    // We expect to see a ListView containing elements for each profile
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(mockProfiles.length));

    // Check that each TextButton has the correct text
    for (var i = 0; i < mockProfiles.length; i++) {
      expect(find.text(mockProfiles[i].username!), findsOneWidget);
    }
  });
}
