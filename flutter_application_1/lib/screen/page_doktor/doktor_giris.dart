import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_kayit.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_profil.dart';
import 'package:flutter_application_1/screen/page_doktor/home.dart';
import 'package:flutter_application_1/server_util/classes.dart';
import 'package:flutter_application_1/server_util/requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';

class DoktorGiris extends StatelessWidget {
  const DoktorGiris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey();
    double yatayGenislik = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;
    final String _path = 'assets/doktor.png';

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

    Future doktorGirisSorgusu(String doktorMail, String doktorSifre) async {
      List<Doktor> doktorList = await doktorGetRequest();
      for (var item in doktorList) {
        if (doktorMail == item.doktor_MAIL &&
            doktorSifre == item.doktor_SIFRE) {
          id = item.doktor_ID;
          ad = item.doktor_ISIM;
          soyad = item.doktor_SOYISIM;
          eposta = item.doktor_MAIL;
          sifre = item.doktor_SIFRE;
          kontrol = true;
          doktor = item;
          break; //kontrol 1 kere true deger almasi yeterlidir.
        } else {
          kontrol = false;
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Image.asset(
                      _path,
                      height: height,
                    )),
                  )),
              Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _textFieldCreater('Mail Adresiniz', mailController),
                        _textFieldCreater('Sifre', sifreController,
                            icerikGizle: true),
                        SizedBox(
                          width: yatayGenislik - 100,
                          height: yatayGenislik / 8,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 255, 224, 244)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  199, 0, 0, 0))))),
                              onPressed: () {
                                if (_key.currentState?.validate() ?? false) {
                                  doktorGirisSorgusu(mailController.text,
                                      sifreController.text);
                                  if (kontrol) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: DoctorHome(doktor: doktor),
                                        isIos: true,
                                        duration: Duration(milliseconds: 800),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Tele-Tıp uygulamasına giriş',
                                style: GoogleFonts.pacifico(
                                    color: Color.fromARGB(199, 0, 0, 0)),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: yatayGenislik - 100,
                          height: yatayGenislik / 8,
                          child: _elevatedButtonCreaterr(
                              nextPage: DoktorKayit(),
                              context,
                              'Hala Kayıt olmadın mı\nKaydolmak için tıkla'),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _elevatedButtonCreaterr(
    BuildContext context,
    String icerik, {
    required Widget nextPage,
  }) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 255, 224, 244)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromARGB(199, 0, 0, 0))))),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: DoktorKayit(),
              isIos: true,
              duration: Duration(milliseconds: 800),
            ),
          );
        },
        child: Text(
          icerik,
          style: GoogleFonts.pacifico(color: Color.fromARGB(199, 0, 0, 0)),
        ));
  }

  Padding _textFieldCreater(String icerik, TextEditingController controller,
      {TextInputType klavyeTipi = TextInputType.emailAddress,
      bool icerikGizle = false}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        autofocus: false,
        style: GoogleFonts.pacifico(color: Color.fromARGB(255, 50, 49, 58)),
        keyboardType: klavyeTipi,
        validator: isNotEmpty,
        controller: controller,
        obscureText: icerikGizle,
        cursorColor: Color.fromARGB(255, 50, 49, 58),
        decoration: InputDecoration(
            errorStyle:
                GoogleFonts.pacifico(color: Color.fromARGB(255, 50, 49, 58)),
            focusColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide:
                    new BorderSide(color: Color.fromARGB(255, 50, 49, 58))),
            labelText: icerik,
            labelStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  String? isNotEmpty(String? data) {
    return (data?.isNotEmpty ?? false)
        ? null
        : 'Mail adresi ya da sifre hatali';
  }
}
