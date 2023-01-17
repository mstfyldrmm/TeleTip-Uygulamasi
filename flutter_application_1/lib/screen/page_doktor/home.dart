import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_chat_ekrani.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_hastalar.dart';
import 'package:flutter_application_1/screen/page_doktor/doktor_profil.dart';
import '../../server_util/classes.dart';
import 'home_page.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({Key? key, required this.doktor}) : super(key: key);
  final Doktor doktor;

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePage(doktor: widget.doktor),
      DoktorHastalar(doktor: widget.doktor), //chat ekrani
      DoktorProfil(doktor: widget.doktor),
    ];
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: _pages),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color.fromARGB(255, 138, 134, 226),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 255, 224, 244),
              inactiveColor: Color.fromARGB(199, 0, 0, 0),
              title: Text('Ana Sayfa'),
              icon: Icon(Icons.home)),
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 255, 224, 244),
              inactiveColor: Color.fromARGB(199, 0, 0, 0),
              title: Text('Mesaj'),
              icon: Icon(CupertinoIcons.chat_bubble_2_fill)),
          BottomNavyBarItem(
              activeColor: Color.fromARGB(255, 255, 224, 244),
              inactiveColor: Color.fromARGB(199, 0, 0, 0),
              title: Text('Hesap'),
              icon: Icon(Icons.manage_accounts_rounded)),
        ],
      ),
    );
  }
}
