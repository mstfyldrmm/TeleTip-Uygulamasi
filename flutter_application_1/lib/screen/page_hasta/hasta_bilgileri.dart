// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_profil_duzenleme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/classes.dart';

class HastaBilgileri extends StatefulWidget {
  final Hasta hasta;
  const HastaBilgileri({
    Key? key,
    required this.hasta,
  }) : super(key: key);

  @override
  _HastaBilgileriState createState() => _HastaBilgileriState();
}

class _HastaBilgileriState extends State<HastaBilgileri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 224, 244),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/png/male.png'),
                ),
                Row(
                  children: [
                    Text(
                      "Ad:\t\t",
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      widget.hasta.hasta_ISIM,
                      style: GoogleFonts.pacifico(
                          color: Color.fromARGB(199, 0, 0, 0), fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Soyad: \t\t",
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      widget.hasta.hasta_SOYISIM,
                      style: GoogleFonts.pacifico(
                          color: Color.fromARGB(199, 0, 0, 0), fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "E-POSTA:",
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      widget.hasta.hasta_MAIL,
                      style: GoogleFonts.pacifico(
                          color: Color.fromARGB(199, 0, 0, 0), fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 138, 134, 226)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromARGB(199, 0, 0, 0))))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: HastaProfilDuzenleme(widget.hasta),
                            isIos: true,
                            duration: Duration(milliseconds: 800),
                          ),
                        );
                      },
                      child: Text(
                        "Profili duzenle",
                        style: GoogleFonts.pacifico(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
