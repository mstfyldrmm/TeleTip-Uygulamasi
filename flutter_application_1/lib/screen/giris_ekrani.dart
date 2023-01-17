import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_giris.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_kayit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'page_hasta/hasta_giris.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  @override
  Widget build(BuildContext context) {
    final String _path = 'assets/jpg/ekran2.jpg';
    double yatayGenislik = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Image.asset(
              _path,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: yatayGenislik / 8,
                    width: yatayGenislik - 30,
                    child: _newElevatedButton('Hasta Girisi',
                        nextPage: HastaGiris()),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: yatayGenislik / 8,
                    child: _newElevatedButton('Doktor Girisi',
                        nextPage: DoktorGiris()),
                    width: yatayGenislik - 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ElevatedButton _newElevatedButton(String icerik, {required Widget nextPage}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: nextPage,
            isIos: true,
            duration: Duration(milliseconds: 800),
          ),
        );
      },
      child: Text(
        icerik,
        style: GoogleFonts.pacifico(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 50, 49, 58)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side:
                      BorderSide(color: Color.fromARGB(200, 138, 134, 226))))),
    );
  }
}
