// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ehliyet/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Ehliyet Sınavı Uygulaması', (WidgetTester tester) async {
    // Uygulamayı başlatın
    await tester.pumpWidget(EhliyetSorulariUygulamasi());

    // Başlangıçta ilk soru gösterilmeli
    expect(find.text("Soru 1/5"), findsOneWidget);

    // Rastgele bir cevap seçin
    await tester.tap(find.byType(Radio));
    await tester.pump();

    // Cevapladıktan sonra ileri git butonuna tıklayın
    await tester.tap(find.text("Cevapla"));
    await tester.pump();

    // İkinci soruya geçildiğini kontrol edin
    expect(find.text("Soru 2/5"), findsOneWidget);

    // Tüm soruları cevaplayın ve sonuc sayfasına gidin
    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byType(Radio));
      await tester.pump();
      await tester.tap(find.text("Cevapla"));
      await tester.pump();
    }

    // Sonuc sayfasında doğru sonuçları kontrol edin
    expect(find.text("Tebrikler!"), findsOneWidget);
    expect(find.text("Toplam Soru: 5"), findsOneWidget);
    expect(find.text("Doğru Sayısı: 5"), findsOneWidget);
  });
}

