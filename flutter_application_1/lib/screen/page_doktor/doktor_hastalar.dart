import 'package:flutter/material.dart';
import 'package:flutter_application_1/server_util/classes.dart';
import 'package:page_transition/page_transition.dart';
import '../../chat.dart';
import '../../server_util/processed_requests.dart';
import '../../server_util/requests.dart';
import 'doktor_chat_ekrani.dart';

class DoktorHastalar extends StatefulWidget {
  const DoktorHastalar({Key? key, required this.doktor}) : super(key: key);
  final Doktor doktor;

  @override
  State<DoktorHastalar> createState() => _DoktorHastalarState();
}

class _DoktorHastalarState extends State<DoktorHastalar> {
  List<Mesaj> mesajlar = [];
  List<Hasta> hastalarim = [];

  Future mesajlariGetir() async {
    mesajlar = await mesajGetRequest();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mesajlariGetir();
    hastalarimiGetir();
  }

  Future hastalarimiGetir() async {
    List<Hasta> hastalar = [];
    hastalar = await hastaGetRequest();
    hastalarim.clear();
    for (var item in hastalar) {
      for (var eleman in mesajlar) {
        if (eleman.hasta_ID == item.hasta_ID) {
          if (hastalarim.contains(item)) {
            continue;
          }
          hastalarim.add(item);
        }
      }
    }
    return hastalarim;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: hastalarimiGetir(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: hastalarim.length, //snapshot.data.length
                itemBuilder: (ctx, index) => Expanded(
                  flex: 1,
                  child: Card(
                    color: Color.fromARGB(255, 255, 224, 244),
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: DoktorChatEkrani(
                                hasta: hastalarim[index],
                                doktor: widget.doktor,
                              ),
                              isIos: true,
                              duration: Duration(milliseconds: 800),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                            child: Image.asset(
                          'assets/images/male.png',
                        )),
                        title: Text(hastalarim[index].hasta_ISIM +
                            ' ' +
                            hastalarim[index].hasta_SOYISIM),
                        subtitle: Text(''),
                        trailing: Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: DoktorChatEkrani(
                                        hasta: snapshot.data[index],
                                        doktor: widget.doktor,
                                      ),
                                      isIos: true,
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.message))
                          ],
                        ),
                        contentPadding: EdgeInsets.only(bottom: 20.0),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
