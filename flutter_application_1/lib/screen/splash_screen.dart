import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text('Tele Tıp',
                  style: GoogleFonts.greatVibes(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      color: Colors.white,
                      fontSize: 50)),
            ),
          ),
        ],
      ),
    );
  }
}
