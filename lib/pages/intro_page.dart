import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:radio_app/pages/home_page.dart';

// ignore: must_be_immutable
class IntroPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var name;

  IntroPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
            title: 'Hi $name',
            body:
                "Welcome to Talk Box Radio\n\n Malayalees woke up to free flowing music "
                "and non-stop entertainment, Clear, Relevant, Fun. Talk Box Radio arrives. To the "
                "rhythms of a passenger train, over a steaming cuppa!!!!",
            decoration: const PageDecoration(
              pageColor: Colors.white,
            ),
            image: Image.asset(
              'assets/intro1.png',
              scale: 2,
            ),
            useRowInLandscape: false),
        PageViewModel(
            title: "Let's Start",
            body:
                "\n\nPlaying the music you love\n\n\nHitting you with hits, every day!",
            image: Image.asset(
              'assets/intro3.gif',
              scale: 2,
              height: 200,
            )),
      ],
      done: const Text('Start'),
      onDone: (() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: ((context) {
              return const HomePage();
            }),
          ),
        );
      }),
      showSkipButton: true,
      showNextButton: true,
      next: const Text('next'),
      skip: const Text('skip'),
      dotsDecorator: DotsDecorator(
        activeColor: Colors.blueAccent,
        activeSize: const Size(25, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onChange: (value) => skip(),
      dotsFlex: 3,
      nextFlex: 1,
      skipOrBackFlex: 1,
      animationDuration: 100,
    );
  }

  skip() {
    // ignore: unused_local_variable
    int index = 3;
  }
}
