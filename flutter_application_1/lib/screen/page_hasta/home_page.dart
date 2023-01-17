import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../server_util/classes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.hasta}) : super(key: key);
  final Hasta hasta;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _path =
      "https://www.shutterstock.com/tr/image-vector/woman-asks-online-doctor-help-because-1489527248";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                child: Text(
                  "Merhaba, Sn." +
                      widget.hasta.hasta_ISIM +
                      ' ' +
                      widget.hasta.hasta_SOYISIM.toUpperCase(),
                  style: GoogleFonts.indieFlower(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  child: Text(
                "Hadi Doktorunuzu Bulun",
                style: GoogleFonts.indieFlower(
                    color: Color.fromARGB(199, 0, 0, 0), fontSize: 40),
              )),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 5),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(_path),
                      fit: BoxFit.cover,
                    )),
              ),
            ]),
      ),
    );
  }
}
