import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_tes/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final player1 = AudioPlayer();
  final player2 = AudioPlayer();
  final player3 = AudioPlayer();

  List<String> audioFiles = [
    'assets/audio/Bewafa Se Pyaar Kiya - Jubin Nautiyal 128 Kbps.mp3',
    'assets/audio/Naseeb Se - Satyaprem Ki Katha 128 Kbps.mp3',
    'assets/audio/Zihaal e Miskin - Vishal Mishra 128 Kbps.mp3',
  ];
  List<String> songNames = [
    'Bewafa Se Pyaar Kiya  ',
    'Naseeb Se  ',
    'Zihaal e Miskin    ',
  ];
  List<String> singer = [
    ' Jubin Nautiyal ',
    ' Satyaprem Ki Katha  ',
    '  Vishal Mishra  ',
  ];
  List<String> image = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVeh6LGFXDkBBkp0WBJZZ4pe8tKGTdBOU99Q&usqp=CAU",
    "https://live-production.wcms.abc-cdn.net.au/a362273509f7eccdcf362bb73b3b006d?impolicy=wcms_crop_resize&cropH=788&cropW=1400&xPos=0&yPos=0&width=862&height=485",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiAC7VXHdnLi-1Nf-RV4R5XeqX343rr65pAJaPj6YsNFRekMs0UItfcua6KD7MsiLdMtU&usqp=CAU"
  ];
  List<AudioPlayer> players = [];

  @override
  void initState() {
    super.initState();
    players = [player1, player2, player3];
  }

  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    player3.dispose();
    super.dispose();
  }

  void playAudio(int index) async {
    if (players[index].playing) {
      await players[index].pause();
    } else {
      await players[index].setAsset(audioFiles[index]);
      await players[index].play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              gradientColor2,
              gradientColor1,
            ],
          ),
        ),
        child: Column(
          children: [
            searchBarWidget(size),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: songNames.length,
                  itemBuilder: (context, index) => musicMainContainer(
                      size, songNames[index], singer[index], index)),
            ),
            const SizedBox(height: 10),
            filterTexts(size),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: audioFiles.length,
                itemBuilder: (context, index) {
                  return musicTile(size, songNames[index].toString(),
                      songNames[index], image[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    height: size.height / 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.home_outlined),
                        Icon(Icons.search_outlined),
                        Icon(Icons.music_note_outlined),
                        Icon(Icons.person_outline),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget musicTile(
      Size size, String songName, String singerName, String image) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 60,
                width: size.width / 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kWhite,
                ),
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  songName,
                  style: const TextStyle(
                    color: kWhite,
                    fontSize: 16,
                  ),
                ),
                Text(
                  singerName,
                  style: TextStyle(
                    color: kWhite.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.favorite_outline_outlined),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Padding filterTexts(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width / 3,
            height: 30,
            decoration: BoxDecoration(
              color: blueColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                'Trending right now',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const Text(
            'Rock',
            style: TextStyle(color: kWhite),
          ),
          const Text(
            'Hip Hop',
            style: TextStyle(color: kWhite),
          ),
          const Text(
            'Electro',
            style: TextStyle(color: kWhite),
          )
        ],
      ),
    );
  }

  Widget musicMainContainer(Size size, String songName, String singer, index) {
    return SingleChildScrollView(
      // Wrap the Row with SingleChildScrollView
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: size.height / 4,
            child: Container(
              margin: EdgeInsets.only(left: size.width / 20),
              width: size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHp7oaId_fXHyAxALpMg2jX-shSGi_-QKYAA&usqp=CAU",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.more_horiz)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 10),
                    child: Container(
                      width: size.width / 1.8,
                      height: 69,
                      decoration: BoxDecoration(
                          color: blueColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 5),
                              Column(
                                children: [
                                  Text(
                                    songName,
                                    style: const TextStyle(
                                      color: kWhite,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.music_note),
                                      Text(
                                        singer,
                                        style: TextStyle(
                                            color: kWhite.withOpacity(0.7),
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => playAudio(index),
                                icon: Icon(
                                  players[index].playing
                                      ? Icons.pause_circle_filled_outlined
                                      : Icons.play_circle_filled_outlined,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBarWidget(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Row(
            children: [
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                      margin: EdgeInsets.only(right: size.width / 30),
                      height: size.height / 17,
                      width: size.width / 8,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.notes_rounded,
                      )),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      height: size.height / 17,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Icon(Icons.search, color: kWhite.withOpacity(0.5)),
                          const SizedBox(width: 5),
                          Text(
                            'Search',
                            style: TextStyle(color: kWhite.withOpacity(0.5)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: size.height / 50),
          const Text(
            'Trending right now',
            style: TextStyle(
              color: kWhite,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
