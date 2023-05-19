import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_ciftcim/screens/home/home_screen.dart';
import 'package:e_ciftcim/screens/home/components/popular_product.dart';

void main() {
  testWidgets('Screen transition integration test', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Act
    await tester.tap(find.text('Popüler Ürünler'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(PopularProducts), findsOneWidget);
  });
}