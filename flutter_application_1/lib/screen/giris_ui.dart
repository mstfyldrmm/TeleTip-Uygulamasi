import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/giris_ekrani.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class GirisUi extends StatefulWidget {
  const GirisUi({Key? key}) : super(key: key);

  @override
  State<GirisUi> createState() => _GirisUiState();
}

class _GirisUiState extends State<GirisUi> {
  final String path = "assets/girisui.jpg";
  @override
  Widget build(BuildContext context) {
    double yatayGenislik = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Image.asset(
                  path,
                  fit: BoxFit.fill,
                  width: yatayGenislik,
                ),
              ),
              SizedBox.shrink(),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sağlıkla teknolojinin buluşması',
                        style: GoogleFonts.caveat(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Aradığınız doktoru kolayca bulun\nKolayca iletişime geçin',
                          style: GoogleFonts.caveat(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w200)),
                      SizedBox(
                        width: yatayGenislik - 30,
                        height: yatayGenislik / 7,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 138, 134, 226)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                200, 138, 134, 226))))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: GirisEkrani(),
                                  isIos: true,
                                  duration: Duration(milliseconds: 800),
                                ),
                              );
                            },
                            child: Text(
                              'Başla',
                              style: GoogleFonts.caveat(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
