import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_giris.dart';
import 'package:flutter_application_1/server_util/classes.dart';

import 'package:flutter_application_1/server_util/processed_requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/requests.dart';

class HastaKayit extends StatelessWidget {
  const HastaKayit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int id = 0;
    String ad = "";
    String soyad = "";
    String eposta = "";
    String sifre = "";
    GlobalKey<FormState> key = GlobalKey();
    TextEditingController adController = TextEditingController();
    TextEditingController soyadController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController sifreController = TextEditingController();

    Hasta hasta = Hasta(
        hasta_ID: id,
        hasta_ISIM: ad,
        hasta_SOYISIM: soyad,
        hasta_MAIL: eposta,
        hasta_SIFRE: sifre);
    bool kontrol = false;

    Future hastaMailKontrol(String hastaMail) async {
      List<Hasta> hastaList = await hastaGetRequest();
      for (var item in hastaList) {
        if (hastaMail == item.hasta_MAIL) {
          kontrol = true;
          break; //kontrol 1 kere true deger almasi yeterlidir.
        } else {
          kontrol = false;
        }
      }
    }

    //Hastaya gerekli uyariyi verir
    void _showDialog(String baslik, String icerik) {
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
              TextButton(
                child: new Text("Kapat"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    double yatayGenislik = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Form(
            key: key,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Hasta Kayıt Formu',
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
                        _textFieldCreater('Ad', adController),
                        _textFieldCreater('Soyad', soyadController),
                        _textFieldCreater(
                          'Email adresi',
                          mailController,
                        ),
                        _textFieldCreater(
                            'Şifre', icerikGizle: true, sifreController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () {
                                if (key.currentState?.validate() ?? false) {
                                  hastaMailKontrol(mailController.text);
                                  if (kontrol) {
                                    _showDialog('Uyarı',
                                        '"Bu mail kullanımda.\nLütfen farklı bir mail adresi deneyin"');
                                  } else {
                                    hastaKayit(
                                        adController.text,
                                        soyadController.text,
                                        mailController.text,
                                        sifreController.text);
                                  }
                                }
                              },
                              child: Text(
                                'Kayıt Ol',
                                style: GoogleFonts.pacifico(
                                    color: Colors.white, fontSize: 30),
                              ),
                            )),
                            SizedBox(
                              child: _girisEkranButton(context, HastaGiris()),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  TextButton _girisEkranButton(BuildContext context, Widget nextPage) {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
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
        '\nGiriş ekranı',
        style: GoogleFonts.pacifico(color: Colors.white, fontSize: 30),
      ),
    );
  }

  Padding _textFieldCreater(String icerik, TextEditingController controller,
      {TextInputType klavyeTipi = TextInputType.emailAddress,
      bool icerikGizle = false}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        autofocus: true,
        style: GoogleFonts.pacifico(color: Colors.white),
        keyboardType: klavyeTipi,
        controller: controller,
        validator: isNotEmpty,
        obscureText: icerikGizle,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.white)),
          labelText: icerik,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

String? isNotEmpty(String? data) {
  return (data?.isNotEmpty ?? false) ? null : 'Bu alan bos gecilemez';
}
