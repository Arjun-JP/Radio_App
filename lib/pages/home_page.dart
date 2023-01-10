import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_app/pages/asscets.dart';
import 'package:radio_app/pages/mail.dart';
import 'package:radio_app/pages/name_page.dart';
import 'package:radio_app/pages/player.dart';

List fmData = [];
final player = AudioPlayer();
bool isplpaying = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadData() async {
    var data = await rootBundle.loadString('assets/json.json');
    setState(() {
      fmData = jsonDecode(data);
    });
  }

  @override
  void initState() {
    loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(216, 31, 27, 27),
          child: Stack(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Text(
                      'Talk Box',
                      style: GoogleFonts.kaushanScript(
                          color: const Color.fromARGB(255, 255, 253, 253),
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '   Radio',
                      style: GoogleFonts.kaushanScript(
                          color: const Color.fromARGB(255, 231, 147, 147),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .11),
                child: InkWell(
                  onTap: () => Utils.openlink(
                    url: Uri.parse('https://www.instagram.com/__mr__jp_'),
                  ),
                  child: const ListTile(
                    leading: Icon(
                      Icons.mail_rounded,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .2),
                child: const Divider(
                  height: 20,
                  color: Color.fromARGB(255, 255, 252, 252),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .25),
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const Welcome())));
                    },
                    child: const Text(
                      'Available Stations',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .33),
                child: ListView.separated(
                  itemCount: fmData.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () async {
                        final musicurl = fmData[index]['url'];
                        final name = (fmData[index]['name']);
                        player.setUrl(musicurl);
                        player.stop();
                        isplpaying = false;

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return Play(
                                  name: name,
                                  musicurl: musicurl,
                                  pic: radioname[index],
                                  tag: fmData[index]['tags'],
                                  index: index);
                            }),
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.radio_outlined,
                        color: Colors.white,
                      ),
                      title: Center(
                        child: Text(
                          fmData[index]['name'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 5,
                      color: Color.fromARGB(255, 239, 135, 135),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        //scrolling silver appbar
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              forceElevated: true,
              stretch: true,
              floating: true,
              snap: true,
              backgroundColor: Colors.black,
              title: Text(
                'Radio',
                style: GoogleFonts.kaushanScript(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40),
              ),
            ),
          ],
          body: Column(
            children: [
              // hedder off the music widget
              const Divider(height: 20),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      itemCount: fmData.length,
                      itemBuilder: ((context, index) {
                        return Container(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Stack(children: [
                            Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    fmData[index]['name'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    subtittle[index],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  trailing: const Icon(
                                    Icons.format_indent_decrease_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                // play button in radio widget
                                InkWell(
                                  onTap: (() async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) {
                                          final musicurl = fmData[index]['url'];
                                          final name = (fmData[index]['name']);
                                          player.setUrl(musicurl);
                                          player.stop();

                                          isplpaying = false;

                                          return Play(
                                            name: name,
                                            musicurl: musicurl,
                                            pic: radioname[index],
                                            tag: fmData[index]['tags'],
                                            index: index,
                                          );
                                        }),
                                      ),
                                    );
                                  }),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width * .8,
                                    decoration: BoxDecoration(
                                        color: colors[index],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ],
                            ),
                            // Tags(comments) inside music Wedgets
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .15,
                                  left:
                                      MediaQuery.of(context).size.width * .05),
                              child: SizedBox(
                                child: Text(
                                  fmData[index]['tags'],
                                  style: TextStyle(
                                      color: colorstext[index],
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .15,
                                  left: MediaQuery.of(context).size.width * .4),
                              child: SizedBox(
                                width: 300,
                                height: 200,
                                child: Image.asset(radioname[index]),
                              ),
                            ),
                            // Container holding  tap function and play button in music widget
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * .45),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: ((context) {
                                        final musicurl = fmData[index]['url'];

                                        player.setUrl(musicurl);
                                        final name = (fmData[index]['name']);

                                        return Play(
                                          name: name,
                                          musicurl: musicurl,
                                          pic: radioname[index],
                                          tag: fmData[index]['tags'],
                                          index: index,
                                        );
                                      }),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 42, 45, 61),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  height:
                                      MediaQuery.of(context).size.height * .162,
                                  width: MediaQuery.of(context).size.width,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                              'live\nLive Music\n(Back to Back)',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          IconButton(
                                              onPressed: () async {
                                                await Navigator.of(context)
                                                    .push(
                                                  MaterialPageRoute(
                                                    builder: ((context) {
                                                      final musicurl =
                                                          fmData[index]['url'];

                                                      player.setUrl(musicurl);
                                                      final name =
                                                          (fmData[index]
                                                              ['name']);

                                                      return Play(
                                                        name: name,
                                                        musicurl: musicurl,
                                                        pic: radioname[index],
                                                        tag: fmData[index]
                                                            ['tags'],
                                                        index: index,
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.play_circle,
                                                color: Colors.white,
                                                size: 60,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                      // sepparator in B/W two music widgets
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 15,
                          color: Colors.black,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
