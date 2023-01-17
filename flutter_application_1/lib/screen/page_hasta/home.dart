import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/page_hasta/hasta_bilgileri.dart';

import 'package:flutter_application_1/screen/page_hasta/hasta_doktor_listesi.dart';
import '../../server_util/classes.dart';
import 'home_page.dart';

class HastaHome extends StatefulWidget {
  const HastaHome({Key? key, required this.hasta}) : super(key: key);
  final Hasta hasta;

  @override
  _HastaHomeState createState() => _HastaHomeState();
}

class _HastaHomeState extends State<HastaHome> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePage(hasta: widget.hasta),
      DoctorPage(hasta: widget.hasta),
      HastaBilgileri(hasta: widget.hasta)
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
              title: Text('Doktor'),
              icon: Icon(Icons.medical_services_rounded)),
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
