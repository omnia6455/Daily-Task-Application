import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'Task.dart';
import 'home.dart';
import 'list.dart';
import 'main.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Task> tasks = [];
  bool fav=false;
  void getData() async {
    tasks = (await database.query('task', where: 'fav=?', whereArgs: [1])).map(
      (e) {
        return Task(
            id: e['id'] as int,
            quests: (List<Map<String, dynamic>>.from(
                    json.decode(e['task'] as String) as List<dynamic>))
                .map(
                  (e) => Quest.fromMap(e),
                )
                .toList(),
            title: e['title'] as String,
            time: e['time'] as String,
            date: DateTime.parse(e['date'] as String),
            save: e['save'] as int == 1 ? true : false,
            fav: e['fav'] as int == 1 ? true : false);
      },
    ).toList();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    getData();
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "assets/image/background_details.png",
            fit: BoxFit.cover,
          )),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: .5, sigmaY: .5),
              child: Container(
                color: Colors.black.withOpacity(.1),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const HomeScreen(),
          //           ));
          //     },
          //     child: Container(
          //       height: screenSize.height * .05,
          //       width: screenSize.width * .27,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(100),
          //           color: Colors.white70),
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Icon(
          //             Icons.arrow_back_ios_rounded,
          //             color: const Color(0xffbe566b).withOpacity(.7),
          //             size: 20,
          //           ),
          //           const SizedBox(
          //             width: 12,
          //           ),
          //           Text(
          //             "Back",
          //             style: TextStyle(
          //               color: const Color(0xffbe566b).withOpacity(.7),
          //               fontSize: 20,
          //               fontWeight: FontWeight.w900,
          //               decoration: TextDecoration.none,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 12,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSize.height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: screenSize.height * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Favourites",
                            style: TextStyle(
                                color: const Color(0xffbe566b).withOpacity(.7),
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                fontFamily: "sofadiOne"),
                          ),
                        ),
                        const SizedBox(width: 12,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              fav=!fav;
                            });
                          },
                          child:fav? Image.asset("assets/image/favourite.png",
                              width: 40,
                              height: 40,
                              color: const Color(0xffbe566b).withOpacity(.7)):Image.asset("assets/image/favourite_fill.png",
                              width: 40,
                              height: 40,
                              color: const Color(0xffbe566b).withOpacity(.7)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Expanded(
                child: Container(
                    clipBehavior: Clip.none,
                    width: screenSize.width,
                    height: screenSize.height,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      color: Colors.white70,
                    ),
                    child: tasks.isEmpty
                        ? Align(
                            child: Text(
                              "No Favourite Tasks!",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xffbe566b).withOpacity(.4),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: TasksList(
                              tasks: tasks,
                            ),
                          )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
