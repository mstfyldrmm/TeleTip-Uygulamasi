import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_hastalar.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_doktor_listesi.dart';
import 'package:flutter_application_1/server_util/processed_requests.dart';
import 'package:page_transition/page_transition.dart';

import '../../server_util/classes.dart';
import '../../server_util/requests.dart';

class DoktorChatEkrani extends StatefulWidget {
  DoktorChatEkrani(
      {Key? key, this.data, required this.doktor, required this.hasta});
  final data;
  final Doktor doktor;
  final Hasta hasta;

  @override
  State<DoktorChatEkrani> createState() => _DoktorChatEkraniState();
}

class _DoktorChatEkraniState extends State<DoktorChatEkrani> {
  List<Mesaj> mesajlar = [];

  Future mesajlariGetir() async {
    mesajlar = await mesajEkraniSorgusu(
        widget.doktor.doktor_ID, widget.hasta.hasta_ID);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mesajlariGetir();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mesajlariGetir();
  }

  TextEditingController mesaj = TextEditingController();
  bool gonderButton = false;
  var butonRenk = Colors.white;

  @override
  Widget build(BuildContext context) {
    void doktorMesajGonder(String icerik) {
      mesajGonderme(widget.doktor.doktor_ID, widget.hasta.hasta_ID, icerik, 1);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: DoktorHastalar(doktor: widget.doktor),
                isIos: true,
                duration: Duration(milliseconds: 800),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 20,
            ),
            SizedBox(
              width: 13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hasta.hasta_ISIM + ' ' + widget.hasta.hasta_SOYISIM,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                Text(
                  "Aktif",
                  style: TextStyle(color: Colors.black45, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Text("data"),
              icon: Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                reverse: true,
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: mesajlar.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                                alignment: (mesajlar[index].yon == 0
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (mesajlar[index].yon == 1
                                        ? Colors.grey.shade200
                                        : Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    mesajlar[index].mesaj,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: butonRenk,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: butonRenk,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: mesaj,
                      onChanged: (value) {
                        if (value.length > 0)
                          setState(() {
                            gonderButton = true;
                          });
                        else
                          setState(() {
                            gonderButton = false;
                          });
                      },
                      decoration: InputDecoration(
                          hintText: "Mesajını yaz...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      var a = mesaj.text.trim();
                      doktorMesajGonder(a);
                      mesajlariGetir();
                      setState(
                        () {},
                      );
                    },
                    child: Icon(
                      gonderButton ? Icons.send : Icons.camera_alt_outlined,
                      color: butonRenk,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (mesajlar[index].yon == 1
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (mesajlar[index].yon == 0
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                mesajlar[index].mesaj,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
 */
