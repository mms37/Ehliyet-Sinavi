import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EhliyetSorulariUygulamasi());
}

class EhliyetSorulariUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SoruSayfasi(),
    );
  }
}

class Soru {
  final String soruMetni;
  final List<String?> secenekler;
  final String dogruCevap;

  Soru({required this.soruMetni, required this.secenekler, required this.dogruCevap});
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Soru> sorular = [
    Soru(
      soruMetni: "Kırmızı ışıkta durmak zorunlu mudur?",
      secenekler: ["Evet", "Hayır"],
      dogruCevap: "Evet",
    ),
    Soru(
      soruMetni: "Taşıt yolunda yaya olarak yürümek doğru mudur?",
      secenekler: ["Evet", "Hayır"],
      dogruCevap: "Hayır",
    ),
    Soru(
      soruMetni: "Öndeki aracı sollarken nelere dikkat etmelisiniz?",
      secenekler: ["Sollama şeridi olmalı", "Korna çalmalı", "Fazla hızlı olmalı"],
      dogruCevap: "Sollama şeridi olmalı",
    ),
    Soru(
      soruMetni: "Emniyet kemeri, koltuğa nasıl takılır?",
      secenekler: ["Takmaya gerek yok", "Sol omuz ve beli kapsayacak şekilde takılır"],
      dogruCevap: "Sol omuz ve beli kapsayacak şekilde takılır",
    ),
    Soru(
      soruMetni: "Sürücü belgesi alabilmek için kaç yaşını doldurmalısınız?",
      secenekler: ["17", "18", "19", "20"],
      dogruCevap: "18",
    ),
  ];

  int soruIndex = 0;
  int dogruSayisi = 0;
  String? secenekler;

  void cevapKontrol() {
    if (secenekler == sorular[soruIndex].dogruCevap) {
      dogruSayisi++;
    }
    secenekler = null; // Cevap işlendikten sonra boşaltın
    ileriGit();
  }

  void ileriGit() {
    if (soruIndex < sorular.length - 1) {
      setState(() {
        soruIndex++;
      });
    } else {
      // Sınav tamamlandı, sonuç sayfasına geç
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SonucSayfasi(dogruSayisi: dogruSayisi, toplamSoru: sorular.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ehliyet Sınavı"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Soru ${soruIndex + 1}/${sorular.length}",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Text(
                sorular[soruIndex].soruMetni,
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: sorular[soruIndex].secenekler.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(sorular[soruIndex].secenekler[index] ?? ""),
                    leading: Radio<String?>(
                      value: sorular[soruIndex].secenekler[index],
                      groupValue: secenekler,
                      onChanged: (String? value) { // Değişiklik burada
                        setState(() {
                          secenekler = value;
                        });
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  cevapKontrol();
                },
                child: Text("Cevapla"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SonucSayfasi extends StatelessWidget {
  final int dogruSayisi;
  final int toplamSoru;

  SonucSayfasi({required this.dogruSayisi, required this.toplamSoru});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sonuç"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tebrikler!",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              "Toplam Soru: $toplamSoru",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Doğru Sayısı: $dogruSayisi",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Yeni bir sınav için sayfayı yeniden başlat
                Navigator.pop(context);
              },
              child: Text("Yeniden Başla"),
            ),
          ],
        ),
      ),
    );
  }
}
