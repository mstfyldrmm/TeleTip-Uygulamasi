import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/server_util/classes.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.doktor}) : super(key: key);
  final Doktor doktor;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Badge(
              position: BadgePosition.topEnd(top: 7, end: -4),
              badgeContent: Text(
                '1',
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(
                Icons.notifications_sharp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Text(
                "Merhaba, Dr.${widget.doktor.doktor_ISIM.toUpperCase()} ${widget.doktor.doktor_SOYISIM.toUpperCase()} ",
                style: GoogleFonts.shadowsIntoLight(
                    color: Colors.white, fontSize: 30)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              child: Text(
            "Beni Türk hekimlerine\n emanet edin",
            style: GoogleFonts.shadowsIntoLight(
                color: Color.fromARGB(199, 0, 0, 0), fontSize: 30),
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
            child: Row(children: []),
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
                  image: NetworkImage(
                      "https://media.istockphoto.com/vectors/electronic-health-record-concept-vector-id1299616187?k=20&m=1299616187&s=612x612&w=0&h=gmUf6TXc8w6NynKB_4p2TzL5PVIztg9UK6TOoY5ckMM="),
                  fit: BoxFit.cover,
                )),
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
        ]),
      ),
    );
  }
}
