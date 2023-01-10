import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_app/pages/home_page.dart';
import 'package:radio_app/pages/name_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    navigateToHome();
    super.initState();
  }

  Future navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    final pref = await SharedPreferences.getInstance();
    checkname = pref.getString('name').toString();

    if (checkname.isEmpty || checkname == 'null') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const Welcome())));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomePage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .2,
              left: MediaQuery.of(context).size.width * .1),
          child: SizedBox(
            width: 300,
            height: 250,
            child: Image.asset('assets/intro3.gif', fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .60,
          ),
          child: Center(
            child: Text('Talk Box',
                style: GoogleFonts.kaushanScript(
                    color: const Color.fromARGB(255, 9, 9, 9),
                    fontSize: 45,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .9,
              left: MediaQuery.of(context).size.width * .455),
          child: Text('©️Jp',
              style: GoogleFonts.kaushanScript(
                  color: const Color.fromARGB(255, 0, 0, 0))),
        )
      ]),
    );
  }
}
