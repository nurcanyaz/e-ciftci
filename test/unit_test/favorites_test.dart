// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:e_ciftcim/screens/Favourites/favourites.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Favorilerim Test', () {
    var favorites = Favorites();
    test('Favorilere ekleme', () {
      //1 rakamını ekliyoruz
      var number = 1;
      favorites.add(number);
      //Listenin içerisinde eklediğimiz sayıyı kontrol ediyoruz
      //expect metodu ile beklediğimiz sonucu kontrol ediyoruz
      expect(favorites.items.contains(number), true);
    });

    test('Favorilerden çıkarma', () {
      //Önce 2'rakamını ekleyip sonra çıkarıyoruz
      var number = 2;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}