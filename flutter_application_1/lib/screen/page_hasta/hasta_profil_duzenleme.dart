import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_bilgileri.dart';
import 'package:flutter_application_1/screen/page_hasta/home.dart';
import 'package:flutter_application_1/screen/page_hasta/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/classes.dart';
import '../../server_util/processed_requests.dart';

class HastaProfilDuzenleme extends StatefulWidget {
  // const HastaProfilDuzenleme({Key? key}) : super(key: key);
  Hasta hasta;
  HastaProfilDuzenleme(this.hasta);
  @override
  _HastaProfilDuzenlemeState createState() => _HastaProfilDuzenlemeState();
}

class _HastaProfilDuzenlemeState extends State<HastaProfilDuzenleme> {
  GlobalKey<FormState> _key = GlobalKey();
  final adController = TextEditingController();
  final soyadController = TextEditingController();
  final sifreController = TextEditingController();

  void _showDialog(String baslik, String icerik, Hasta hasta) {
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
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: HastaHome(
                      hasta: hasta,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(" PROFİL DÜZENLEME"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset('assets/png/male.png'),
              ),
              SizedBox(
                height: 30,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.upload_file)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: _textFieldCreater('Ad', adController),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: _textFieldCreater('Soyad', soyadController)),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: _textFieldCreater('Şifre', sifreController)),
              TextButton(
                  onPressed: () {
                    if (_key.currentState?.validate() ?? false) {
                      hastaAyarDegisimi(
                          hasta_ID: widget.hasta.hasta_ID,
                          hasta_ISIM: adController.text,
                          hasta_SIFRE: sifreController.text,
                          hasta_SOYISIM: soyadController.text);
                      Hasta guncelHasta = Hasta(
                          hasta_ID: widget.hasta.hasta_ID,
                          hasta_ISIM: adController.text,
                          hasta_SOYISIM: soyadController.text,
                          hasta_MAIL: widget.hasta.hasta_MAIL,
                          hasta_SIFRE: sifreController.text,
                          hasta_FOTO: widget.hasta.hasta_FOTO);
                      _showDialog(
                          'Güncelleme işlemi başarili', '', guncelHasta);
                    }
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: Text(
                    'Guncelle',
                    style:
                        GoogleFonts.pacifico(color: Colors.white, fontSize: 30),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Padding _textFieldCreater(String icerik, TextEditingController controller,
    {TextInputType klavyeTipi = TextInputType.emailAddress,
    bool icerikGizle = false}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: TextFormField(
      style: GoogleFonts.pacifico(color: Color.fromARGB(255, 50, 49, 58)),
      keyboardType: klavyeTipi,
      validator: isNotEmpty,
      controller: controller,
      obscureText: icerikGizle,
      cursorColor: Color.fromARGB(255, 50, 49, 58),
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
