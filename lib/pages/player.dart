import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/pages/home_page.dart';

int cindex = 0;
int cindex1 = 1;
final player = AudioPlayer();

bool isplpaying = false;
late int currentindex;

class Play extends StatefulWidget {
  final String name;
  final String pic;
  final String musicurl;
  final String tag;
  final int index;

  const Play({
    super.key,
    required this.name,
    required this.musicurl,
    required this.pic,
    required this.tag,
    required this.index,
  });

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // live badging
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .6,
                  left: MediaQuery.of(context).size.width * .075),
              child: const SizedBox(
                child: Text(
                  '-----------------------  LIVE  -----------------------',
                  style: TextStyle(
                      color: Color.fromARGB(255, 174, 170, 170),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            // Play Button
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .72,
                  left: MediaQuery.of(context).size.width * .38),
              child: IconButton(
                iconSize: 70,
                onPressed: () async {
                  playradio() async {
                    if (!isplpaying) {
                      currentindex = widget.index;
                      isplpaying = true;
                      await player.stop();
                      await player.setUrl(widget.musicurl);

                      await player.play();
                    } else {
                      isplpaying = false;
                      await player.stop();
                    }
                  }

                  setState(() {
                    playradio();
                  });
                },
                icon: Icon(
                  isplpaying == true ? Icons.pause : Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            // Tag (comment) inside the player
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .06,
                  left: MediaQuery.of(context).size.width * .1),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Text(
                  widget.tag,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            // next button inside player
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .72,
                  left: MediaQuery.of(context).size.width * .65),
              child: IconButton(
                  iconSize: 70,
                  onPressed: () async {
                    cindex++;
                    int chanallimit = widget.index + cindex;
                    if (chanallimit > 18 || chanallimit < 0) {
                      chanallimit = 0;
                      cindex = 0;
                    }

                    dynamic nexturl = await fmData[chanallimit]['url'];
                    setState(() {
                      isplpaying = true;
                    });

                    await player.stop();
                    await player.setUrl(nexturl);
                    await player.play();
                  },
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: Colors.white,
                  )),
            ),
            // previous button
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .72,
                  left: MediaQuery.of(context).size.width * .12),
              child: IconButton(
                  iconSize: 70,
                  onPressed: () async {
                    cindex1++;

                    int chanallimit = widget.index + cindex1;
                    if (chanallimit < 0 || chanallimit > 18) {
                      chanallimit = 18;
                      cindex1 = 0;
                    }
                    dynamic nexturl = await fmData[chanallimit]['url'];

                    setState(() {
                      isplpaying = true;
                    });
                    await player.stop();
                    await player.setUrl(nexturl);
                    await player.play();
                  },
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: Colors.white,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .15,
                  left: MediaQuery.of(context).size.height * .25,
                  right: MediaQuery.of(context).size.height * .04,
                  bottom: MediaQuery.of(context).size.height * .44),
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width * .5,
              color: Colors.transparent,
              child: Image.asset(widget.pic),
            ),
          ],
        ),
      ),
    );
  }
}
