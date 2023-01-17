import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_bilgileri.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_kayit.dart';
import 'package:flutter_application_1/screen/page_hasta/home.dart';
import 'package:flutter_application_1/server_util/classes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../constants.dart';
import '../../server_util/requests.dart';

class HastaGiris extends StatefulWidget {
  @override
  State<HastaGiris> createState() => _HastaGirisState();
}

class _HastaGirisState extends State<HastaGiris> {
  // final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _key = GlobalKey();
    double yatayGenislik = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;
    final String _path = 'assets/hasta_giriss.jpg';

    int id = 0;
    String ad = "";
    String soyad = "";
    String eposta = "";
    String sifre = "";

    Hasta hasta = Hasta(
        hasta_ID: id,
        hasta_ISIM: ad,
        hasta_SOYISIM: soyad,
        hasta_MAIL: eposta,
        hasta_SIFRE: sifre);

    final mailController = TextEditingController();
    final sifreController = TextEditingController();
    bool kontrol = false;

    Future hastaGirisSorgusu(String hasta_mail, String hasta_sifre) async {
      List<Hasta> hastaList = await hastaGetRequest();
      for (var item in hastaList) {
        if (hasta_mail == item.hasta_MAIL && hasta_sifre == item.hasta_SIFRE) {
          id = item.hasta_ID;
          ad = item.hasta_ISIM;
          soyad = item.hasta_SOYISIM;
          eposta = item.hasta_MAIL;
          sifre = item.hasta_SIFRE;
          hasta = item;
          kontrol = true;
          break; //kontrol 1 kere true deger almasi yeterlidir.
        } else {
          kontrol = false;
        }
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 224, 244),
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
                                      Color.fromARGB(255, 138, 134, 226)),
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
                                  hastaGirisSorgusu(mailController.text,
                                      sifreController.text);
                                  if (kontrol) {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: HastaHome(hasta: hasta,),
                                        isIos: true,
                                        duration: Duration(milliseconds: 800),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'Tele-Tıp uygulamasına giriş',
                                style:
                                    GoogleFonts.pacifico(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: yatayGenislik - 100,
                          height: yatayGenislik / 8,
                          child: _elevatedButtonCreaterr(
                              nextPage: HastaKayit(),
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
                MaterialStateProperty.all(Color.fromARGB(255, 138, 134, 226)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromARGB(199, 0, 0, 0))))),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: HastaKayit(),
              isIos: true,
              duration: Duration(milliseconds: 800),
            ),
          );
        },
        child: Text(
          icerik,
          style: GoogleFonts.pacifico(color: Colors.white),
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
