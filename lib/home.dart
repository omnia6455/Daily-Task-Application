import 'package:agenda/Favourite.dart';
import 'package:agenda/History.dart';
import 'package:agenda/Saved.dart';
import 'package:agenda/do_list.dart';
import 'package:flutter/material.dart';
import 'create.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [
    const DoList(),
    const Saved(),
    const Favourite(),
    const History(),
  ];
  PageController pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context){
    Size screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: pageController,
              children: pages,
              onPageChanged: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
          ),
          Positioned(
            bottom: 0,
            height: screenSize.height * .09,
            width: screenSize.width,
            child: index == 0
                ? ClipPath(
                    clipper: Clipper(),
                    child: BottomNavigationBar(
                      backgroundColor: const Color(0xffFFD1E8),
                      onTap: (int currentIndex) {
                        setState(() {
                          index = currentIndex;
                          pageController.animateToPage(currentIndex,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease);
                        });
                      },
                      currentIndex: index,
                      showSelectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      fixedColor: const Color(0xffbe566b).withOpacity(.6),
                      unselectedItemColor: Colors.white54,
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/image/category.png",
                            color: index == 0
                                ? const Color(0xffbe566b).withOpacity(.6)
                                : Colors.white70,
                            width: 36,
                            height: 36,
                          ),
                          label: 'Your Tasks',
                        ),
                        BottomNavigationBarItem(
                            icon: index == 1
                                ? Image.asset("assets/image/saved_fill.png",
                                    width: 36,
                                    height: 36,
                                    color:
                                        const Color(0xffbe566b).withOpacity(.6))
                                : Image.asset(
                                    "assets/image/saved.png",
                                    width: 36,
                                    height: 36,
                                    color: Colors.white.withOpacity(.8),
                                  ),
                            label: 'Save'),
                        BottomNavigationBarItem(
                            icon: index == 2
                                ? Image.asset(
                                    "assets/image/favourite_fill.png",
                                    width: 36,
                                    height: 36,
                                    color:
                                        const Color(0xffbe566b).withOpacity(.6),
                                  )
                                : Image.asset(
                                    "assets/image/favourite.png",
                                    width: 36,
                                    height: 36,
                                    color: index == 2
                                        ? const Color(0xffbe566b)
                                            .withOpacity(.6)
                                        : Colors.white,
                                  ),
                            label: 'Favourite'),
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              "assets/image/date.png",
                              width: 36,
                              height: 36,
                              color: index == 3
                                  ? const Color(0xffbe566b).withOpacity(.6)
                                  : Colors.white.withOpacity(.9),
                            ),
                            label: 'History'),
                      ],
                    ),
                  )
                : BottomNavigationBar(
                    backgroundColor: const Color(0xffFFD1E8),
                    onTap: (int currentIndex) {
                      setState(() {
                        index = currentIndex;
                        pageController.animateToPage(currentIndex,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease);
                      });
                    },
                    currentIndex: index,
                    showSelectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    fixedColor: const Color(0xffbe566b).withOpacity(.6),
                    unselectedItemColor: Colors.white54,
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/image/category.png",
                          color: index == 0
                              ? const Color(0xffbe566b).withOpacity(.6)
                              : Colors.white70,
                          width: 36,
                          height: 36,
                        ),
                        label: 'Your Tasks',
                      ),
                      BottomNavigationBarItem(
                          icon: index == 1
                              ? Image.asset("assets/image/saved_fill.png",
                                  width: 36,
                                  height: 36,
                                  color:
                                      const Color(0xffbe566b).withOpacity(.6))
                              : Image.asset(
                                  "assets/image/saved.png",
                                  width: 36,
                                  height: 36,
                                  color: Colors.white.withOpacity(.8),
                                ),
                          label: 'Save'),
                      BottomNavigationBarItem(
                          icon: index == 2
                              ? Image.asset(
                                  "assets/image/favourite_fill.png",
                                  width: 36,
                                  height: 36,
                                  color:
                                      const Color(0xffbe566b).withOpacity(.6),
                                )
                              : Image.asset(
                                  "assets/image/favourite.png",
                                  width: 36,
                                  height: 36,
                                  color: index == 2
                                      ? const Color(0xffbe566b).withOpacity(.6)
                                      : Colors.white,
                                ),
                          label: 'Favourite'),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/image/date.png",
                            width: 36,
                            height: 36,
                            color: index == 3
                                ? const Color(0xffbe566b).withOpacity(.6)
                                : Colors.white.withOpacity(.9),
                          ),
                          label: 'History'),
                    ],
                  ),
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight+25,
          left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const Creation();
                  },
                ));
              },
              child: index == 0
                  ? Center(
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffbe566b).withOpacity(.56),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(33))),
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          "assets/image/write_note.png",
                          color: Colors.white,
                        ),
                      ),
                  )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * .4, 0);
    path.quadraticBezierTo(
        size.width * .5, size.height * .5, size.width * .6, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
