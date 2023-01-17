import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/chat.dart';
import 'package:flutter_application_1/screen/page_doktor/doctor_box.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_detayli_profil.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_profil.dart';
import 'package:flutter_application_1/screen/textbox.dart';
import 'package:flutter_application_1/server_util/requests.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../server_util/classes.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key, required this.hasta}) : super(key: key);
  final Hasta hasta;

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  bool _searcBoolean = false;
  List<Doktor> doktorlar = [];
  List<Doktor> arananDoktorlar = [];

  doktorlariGetir() async {
    List<Doktor> doktorlar = [];
    doktorlar = await doktorGetRequest();
    return doktorlar;
  }

  doktorGetir(String ifade) async {
    ifade = ifade.toLowerCase().trim();
    List<Doktor> doktorlar = [];
    doktorlar = await doktorGetRequest();
    for (var item in doktorlar) {
      if (item.doktor_ISIM.toLowerCase().trim().contains(ifade) ||
          item.doktor_SOYISIM.toLowerCase().trim().contains(ifade) ||
          item.doktor_AnaBilim.toLowerCase().trim().contains(ifade) ||
          item.doktor_uzmanliklar.toLowerCase().trim().contains(ifade)) {
        arananDoktorlar.add(item);
        //return arananDoktorlar;
      }
    }
    return arananDoktorlar;
  }

  Widget _searchTextField() {
    return TextField(
      controller: searchController,
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      onSubmitted: (value) {
        if (value != null) {
          setState(() {
            isLoading = !isLoading;
          });
        }
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Arama', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: !_searcBoolean
                ? Text(
                    'Doktorlar',
                    style: GoogleFonts.caveat(),
                  )
                : _searchTextField(),
            actions: !_searcBoolean
                ? [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searcBoolean = true;
                          });
                        })
                  ]
                : [
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            arananDoktorlar.clear();
                            _searcBoolean = false;
                            isLoading = !isLoading;
                          });
                        })
                  ]),
        body: FutureBuilder(
            future: isLoading
                ? doktorGetir(searchController.text)
                : doktorlariGetir(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
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
                                child: DoktorDetayliSayfa(
                                  doktor: snapshot.data[index],
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
                          title: Text(
                            'Dr.' +
                                snapshot.data[index].doktor_ISIM +
                                '  ' +
                                snapshot.data[index].doktor_SOYISIM,
                            style: GoogleFonts.caveat(
                                color: Color.fromARGB(199, 0, 0, 0),
                                fontSize: 40),
                          ),
                          subtitle: Text(
                            snapshot.data[index].doktor_AnaBilim +
                                '\n' +
                                snapshot.data[index].doktor_uzmanliklar,
                            style: GoogleFonts.caveat(
                                color: Color.fromARGB(199, 0, 0, 0),
                                fontSize: 30),
                          ),
                          trailing: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Chat(
                                        hasta: widget.hasta,
                                        doktor: snapshot.data[index],
                                      ),
                                      isIos: true,
                                      duration: Duration(milliseconds: 800),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.message_rounded),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.only(bottom: 20.0),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}

/*AppBar(
            title: !_searcBoolean
                ? Text(
                    'Doktorlar',
                    style: GoogleFonts.caveat(),
                  )
                : _searchTextField(),
            actions: !_searcBoolean
                ? [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searcBoolean = true;
                          });
                        })
                  ]
                : [
                    IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            arananDoktorlar.clear();
                            _searcBoolean = false;
                          });
                        })
                  ] */
