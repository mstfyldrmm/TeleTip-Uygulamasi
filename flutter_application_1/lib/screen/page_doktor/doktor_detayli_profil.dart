import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/home_page.dart';
import 'package:flutter_application_1/server_util/classes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class DoktorDetayliSayfa extends StatefulWidget {
  const DoktorDetayliSayfa({Key? key, required this.doktor}) : super(key: key);
  final Doktor doktor;

  @override
  State<DoktorDetayliSayfa> createState() => _DoktorDetayliSayfaState();
}

class _DoktorDetayliSayfaState extends State<DoktorDetayliSayfa> {
  @override
  Widget build(BuildContext context) {
    double yatayGenislik = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 224, 244),
      ),
      backgroundColor: Color.fromARGB(255, 255, 224, 244),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              child: Image.asset('assets/png/male.png'),
            ),
            _containerCreator(
                icerik: widget.doktor.doktor_ISIM,
                genislik: yatayGenislik - 20),
            _containerCreator(
                icerik: widget.doktor.doktor_SOYISIM,
                genislik: yatayGenislik - 20),
            _containerCreator(
                icerik: widget.doktor.doktor_MAIL,
                genislik: yatayGenislik - 20),
            _containerCreator(
                icerik: widget.doktor.doktor_mezunOkul + ' ' + 'mezunu',
                genislik: yatayGenislik - 20),
            _containerCreater(
              baslik: 'Ana Bilim Dali',
              icerik: widget.doktor.doktor_AnaBilim,
              widget: widget,
              yatayGenislik: yatayGenislik - 40,
              yukseklik: 100,
            ),
            SizedBox(
              height: 20,
            ),
            _containerCreater(
                yatayGenislik: yatayGenislik - 20,
                widget: widget,
                yukseklik: 150,
                baslik: 'Çalıştığı kurum',
                icerik: widget.doktor.doktor_calistigiKurum),
            SizedBox(
              height: 20,
            ),
            _containerCreater(
                yatayGenislik: yatayGenislik,
                widget: widget,
                baslik: 'Uzmanlik alanlari',
                icerik: widget.doktor.doktor_uzmanliklar,
                yukseklik: 300),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  FittedBox _containerCreator(
      {required String icerik,
      required double genislik,
      double yukseklik = 100}) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.all(20),
        // color: ,
        decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 138, 134, 226), width: 3),
            borderRadius: BorderRadius.circular(10)),
        width: genislik,
        height: yukseklik,
        child: ListTile(
            leading: Text(
          icerik,
          style: GoogleFonts.caveat(
              color: Color.fromARGB(199, 0, 0, 0), fontSize: 30),
        )),
      ),
    );
  }
}

class _containerCreater extends StatelessWidget {
  const _containerCreater(
      {Key? key,
      required this.yatayGenislik,
      required this.widget,
      required this.yukseklik,
      required this.baslik,
      required this.icerik})
      : super(key: key);

  final double yatayGenislik;
  final DoktorDetayliSayfa widget;
  final double yukseklik;
  final String baslik;
  final String icerik;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: yatayGenislik - 100,
        height: yukseklik,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color.fromARGB(255, 138, 134, 226), width: 3)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(baslik,
                style: GoogleFonts.caveat(
                    color: Color.fromARGB(199, 0, 0, 0), fontSize: 30)),
            Text(icerik,
                style: GoogleFonts.caveat(
                    color: Color.fromARGB(199, 0, 0, 0), fontSize: 30))
          ],
        ),
      ),
    );
  }
}
