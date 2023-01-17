import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_giris.dart';
import 'package:flutter_application_1/screen/giris_ekrani.dart';
import 'package:flutter_application_1/server_util/processed_requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/classes.dart';
import '../../server_util/requests.dart';

class DoktorKayit extends StatefulWidget {
  const DoktorKayit({Key? key}) : super(key: key);

  @override
  State<DoktorKayit> createState() => _DoktorKayitState();
}

class _DoktorKayitState extends State<DoktorKayit> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController adController = TextEditingController();
  TextEditingController soyadController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  TextEditingController anaBilimDaliController = TextEditingController();
  TextEditingController okulController = TextEditingController();
  TextEditingController hastaneController = TextEditingController();
  TextEditingController uzmanController = TextEditingController();
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

    Doktor doktor = Doktor(
        doktor_ID: id,
        doktor_ISIM: ad,
        doktor_SOYISIM: soyad,
        doktor_MAIL: eposta,
        doktor_SIFRE: sifre,
        doktor_AnaBilim: anaBilim,
        doktor_calistigiKurum: kurum,
        doktor_mezunOkul: okul,
        doktor_uzmanliklar: uzmanlik);

    final mailController = TextEditingController();
    final sifreController = TextEditingController();
    bool kontrol = false;

    Future doktorMailKontrol(String doktorMail) async {
      List<Doktor> doktorList = await doktorGetRequest();
      for (var item in doktorList) {
        if (doktorMail == item.doktor_MAIL) {
          id = item.doktor_ID;
          ad = item.doktor_ISIM;
          soyad = item.doktor_SOYISIM;
          eposta = item.doktor_MAIL;
          sifre = item.doktor_SIFRE;
          kontrol = true;
          break; //kontrol 1 kere true deger almasi yeterlidir.
        } else {
          kontrol = false;
        }
      }
    }

    double yatayGenislik = MediaQuery.of(context).size.width;

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

    return Scaffold(
        body: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Doktor Kayıt Formu',
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
                        _textFieldCreater('Adiniz', adController),
                        _textFieldCreater('Soyadiniz', soyadController),
                        _textFieldCreater('Email adresiniz', mailController),
                        _textFieldCreater(
                            'Şifre', icerikGizle: true, sifreController),
                        _textFieldCreater(
                            'Ana bilim dalı', anaBilimDaliController),
                        _textFieldCreater(
                            ' Uzmanlık alanları', uzmanController),
                        _textFieldCreater('Mezun olduğu okul', okulController),
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
                                  print('okey');
                                  doktorMailKontrol(mailController.text);
                                  if (kontrol) {
                                    _showDialog('Uyari',
                                        'Bu mail kullanimda\nLütfen farklı mail adresi giriniz');
                                  } else {
                                    doktorKayit(
                                        doktor_ISIM: adController.text,
                                        doktor_SOYISIM: soyadController.text,
                                        doktor_MAIL: mailController.text,
                                        doktor_SIFRE: sifreController.text,
                                        doktor_AnaBilim:
                                            anaBilimDaliController.text,
                                        doktor_calistigiKurum:
                                            hastaneController.text,
                                        doktor_mezunOkul: okulController.text,
                                        doktor_uzmanliklar:
                                            uzmanController.text);
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
                              child: _girisEkranButton(context, GirisEkrani()),
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
}

String? isNotEmpty(String? data) {
  return (data?.isNotEmpty ?? false) ? null : 'Bu alan bos gecilemez';
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
