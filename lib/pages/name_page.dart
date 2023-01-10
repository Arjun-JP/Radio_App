import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio_app/pages/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String checkname;

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  TextEditingController controller = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(235, 172, 221, 242),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .5,
                  left: MediaQuery.of(context).size.width * .1),
              child: Row(
                children: [
                  Text(
                    'Talk Box',
                    style: GoogleFonts.kaushanScript(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 65,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '   Radio',
                    style: GoogleFonts.kaushanScript(
                        color: const Color.fromARGB(255, 125, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .2),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter name...',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 3, 3, 3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .35,
                  left: MediaQuery.of(context).size.width * .5),
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: (() {
                    final name = controller.text;
                    if (name.isEmpty) {
                      return;
                    } else {
                      savename();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: ((context) {
                            return IntroPage(
                              name: name,
                            );
                          }),
                        ),
                      );
                    }
                  }),
                  child: const Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }

  Future savename() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('name', controller.text);
    checkname = pref.getString('name').toString();

    setState(() {});
  }
}
