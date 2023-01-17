import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/home.dart';
import 'package:flutter_application_1/screen/page_doktor/home_page.dart';
import 'package:flutter_application_1/server_util/processed_requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/classes.dart';

class DoktorKayitYenileme extends StatefulWidget {
  const DoktorKayitYenileme({Key? key, required this.doktor}) : super(key: key);
  final Doktor doktor;

  @override
  State<DoktorKayitYenileme> createState() => _DoktorKayitYenilemeState();
}

class _DoktorKayitYenilemeState extends State<DoktorKayitYenileme> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController mailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  TextEditingController anaBilimDaliController = TextEditingController();
  TextEditingController hastaneController = TextEditingController();
  TextEditingController uzmanController = TextEditingController();

  void _showDialog(String baslik, String icerik, Doktor doktor) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 224, 244),
          title: new Text(
            baslik,
            style: GoogleFonts.pacifico(color: Color.fromARGB(199, 0, 0, 0)),
          ),
          content: new Text(
            icerik,
            style: GoogleFonts.pacifico(color: Color.fromARGB(199, 0, 0, 0)),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Kapat"),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: DoctorHome(
                      doktor: doktor,
                    ),
                    isIos: true,
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int id = 0;
    String ad = "";
    String soyad = "";
    String eposta = "";
    String sifre = "";
    String anaBilim = "";
    String uzmanlik = "";
    String okul = "";
    String kurum = "";
    return Scaffold(
        body: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Doktor Kayıt Yenileme',
                        style: GoogleFonts.pacifico(
                            color: Colors.white, fontSize: 40),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _textFieldCreater('Email adresiniz', mailController),
                        _textFieldCreater(
                            'Şifre', icerikGizle: true, sifreController),
                        _textFieldCreater(
                            'Ana bilim dalı', anaBilimDaliController),
                        _textFieldCreater(
                            ' Uzmanlık alanı ekle', uzmanController),
                        _textFieldCreater('Çalıştığı kurum', hastaneController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {
                                if (_key.currentState?.validate() ?? false) {
                                  doktorAyarDegisim(
                                      doktor_AnaBilim:
                                          anaBilimDaliController.text,
                                      doktor_calistigiKurum:
                                          hastaneController.text,
                                      doktor_uzmanliklar: uzmanController.text,
                                      doktor_MAIL: mailController.text,
                                      doktor_SIFRE: sifreController.text,
                                      doktorID: widget.doktor.doktor_ID,
                                      doktor_ISIM: widget.doktor.doktor_ISIM,
                                      doktor_SOYISIM:
                                          widget.doktor.doktor_SOYISIM,
                                      doktor_mezunOkul:
                                          widget.doktor.doktor_mezunOkul);

                                  Doktor guncelDoktor = Doktor(
                                      doktor_ID: widget.doktor.doktor_ID,
                                      doktor_ISIM: widget.doktor.doktor_ISIM,
                                      doktor_SOYISIM:
                                          widget.doktor.doktor_SOYISIM,
                                      doktor_MAIL: mailController.text,
                                      doktor_SIFRE: sifreController.text,
                                      doktor_AnaBilim:
                                          anaBilimDaliController.text,
                                      doktor_calistigiKurum:
                                          hastaneController.text,
                                      doktor_mezunOkul:
                                          widget.doktor.doktor_mezunOkul,
                                      doktor_uzmanliklar: uzmanController.text);
                                  _showDialog(
                                      'Guncelleme basarili', '', guncelDoktor);
                                }
                              },
                              child: Text(
                                'Guncelle',
                                style: GoogleFonts.pacifico(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
    ;
  }
}

Padding _textFieldCreater(String icerik, TextEditingController controller,
    {TextInputType klavyeTipi = TextInputType.emailAddress,
    bool icerikGizle = false}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextFormField(
      style: GoogleFonts.pacifico(color: Colors.white),
      keyboardType: klavyeTipi,
      controller: controller,
      obscureText: icerikGizle,
      validator: isNotEmpty,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          focusColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.white)),
          labelText: icerik,
          labelStyle: TextStyle(color: Colors.white)),
    ),
  );
}

String? isNotEmpty(String? data) {
  return (data?.isNotEmpty ?? false) ? null : 'Bu alan bos gecilemez';
}
